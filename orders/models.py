# orders/models.py
import os
import random
from datetime import timedelta
from decimal import Decimal
from io import BytesIO
from pprint import pprint
from tempfile import template

from colorful.fields import RGBColorField
from django.conf import settings
from django.contrib import messages
from django.core.files.storage import default_storage
from django.core.exceptions import ValidationError
from django.core.files.base import ContentFile
from django.db.models import Sum
from django.template.defaultfilters import first
from django.template.loader import render_to_string
from django.utils import timezone
from django.utils.html import format_html
from jinja2 import FileSystemLoader, Template
from GC_Enterprise.jinja2 import environment
from xhtml2pdf import pisa

from core.models import GcAbstractModel
from customers.models import Customer
from company.models import Company, OrderCounter
from django.db import models, transaction

from django.db.models.signals import post_delete, pre_delete, post_save
from django.dispatch import receiver
from django.utils.translation import gettext_lazy as _

from drafthorse.models.document import Document as ZFDocument
from drafthorse.models.note import IncludedNote
from drafthorse.models.party import TaxRegistration
from drafthorse.models.tradelines import LineItem
from drafthorse.pdf import attach_xml

import logging
logger = logging.getLogger(__name__)


from .services.pdf_services import PDFService




""" FeeGroup and service phases """

# Honorarzonen Gruppe (Statik, Architektur)
class FeeGroup(GcAbstractModel):
    """
    Defines a group of fee classes, representing categories such as "Structural Engineering"
    or "Architecture".

    Attributes:
        name (str): The name of the fee group, categorizing fee classes into broader areas.

    This grouping enables better organization of fee classes by category. Each `FeeClass` is
    associated with one `FeeGroup`, providing logical separation of fee categories
    within projects.
    """
    name = models.CharField(max_length=100, verbose_name="Name der Honorarklassen Gruppe")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = f"Gruppe Honorarklasse"
        verbose_name_plural = f"Gruppen Honorarklasse"

# Leistungsphasen
class ServicePhase(GcAbstractModel):
    """
    Represents a specific service phase within a project, such as "Design Phase"
    or "Construction Phase".

    Attributes:
        name (str): The name of the service phase.
        description (str): An optional description detailing the service phase.
        percent (Decimal): The percentage value used in calculations for this phase.
        fee_group (FeeGroup): The fee group this phase belongs to, linking it to relevant
            fee classes.

    Each `ServicePhase` provides a modular way to define stages in a project, with
    specified percentages to be applied within the context of a fee class.
    The `percent` value represents the weighting of this phase within the fee calculation.
    """
    lph = models.CharField(max_length=100, null=True, blank=True, verbose_name="Leistungsphase")
    name = models.CharField(max_length=100, verbose_name="Name")
    description = models.TextField(blank=True, null=True, verbose_name="Beschreibung")
    percent = models.DecimalField(max_digits=5, decimal_places=2, verbose_name="Prozentwert")
    fee_group = models.ForeignKey('FeeGroup', on_delete=models.CASCADE, verbose_name="Honorarklasse")

    def __str__(self):
        return f"{self.fee_group}-{self.lph} {self.name}"

    class Meta:
        verbose_name = "Leistungsphase"
        verbose_name_plural = "Leistungsphasen"
        ordering = ['fee_group', 'lph']




""" Document """

class DocumentType(GcAbstractModel):
    name = models.CharField(max_length=100, verbose_name="Dokumenttyp")
    description = models.TextField(blank=True, null=True, verbose_name="Beschreibung")
    book_tasks = models.BooleanField(default=False, verbose_name="Tasks automatisch buchen?")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Dokumenttyp"
        verbose_name_plural = "Dokumenttypen"
    """
    Represents a specific type of document associated with a project.

    Attributes:
        name (str): The name of the document type (e.g., "Invoice", "Offer").
        description (str): An optional description of the document type.
        book_tasks (bool): Determines if tasks associated with this document type 
            are automatically booked upon document creation.

    This class helps categorize documents within projects, enabling different 
    actions based on the document type, such as automatic task bookings.
    """

def default_introduction():
    return (
        "{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %}\n"
        "zu o.g. Bauvorhaben möchte ich Ihnen gerne folgendes Angebot unterbreiten."
    )

class Document(GcAbstractModel):
    """
    Represents a document within a project, storing details about a specific
    document instance.

    Attributes:
        order (Order): The project associated with this document.
        document_type (DocumentType): The type of document (e.g., "Invoice").
        file_path (FileField): The file location where the document is stored.
        description (str): An optional description of the document.

    Methods:
        create_pdf_for_document(): Generates a PDF file for the document, saving
            it to the specified `file_path`.
    """
    order = models.ForeignKey(
        'Order',
        on_delete=models.CASCADE,
        verbose_name="Projekt"  # Kurz und verständlich für die Verknüpfung zur Bestellung
    )
    document_type = models.ForeignKey(
        'DocumentType',
        on_delete=models.CASCADE,
        verbose_name="Dokumententyp"
    )
    file_path = models.FileField(
        blank=True,
        null=True,
        verbose_name="Dateipfad"  # Beschreibt den Pfad zur Datei, kann auch "Dokument" genannt werden
    )

    introduction = models.TextField(
        blank=True,
        null=True,
        default=default_introduction,
        verbose_name="Einleitung"  # Standardbegriff für die optionale Beschreibung
    )
    description = models.TextField(
        blank=True,
        null=True,
        verbose_name="Beschreibung"  # Standardbegriff für die optionale Beschreibung
    )
    conclusion = models.TextField(
        blank=True,
        null=True,
        verbose_name="Abschluss"  # Standardbegriff für die optionale Beschreibung
    )


    def __str__(self):
        return f"{self.document_type.name} für Projekt {self.order.nr}: {self.order.customer.name}"


    """ PDF Erstellung """

    def create_pdf_for_document(self):
        logger.info(f"Start creating PDF for Document [ID: {self.id}, Type: {self.document_type.name if self.document_type else 'Unknown'}, Order ID: {self.order.id}]")

        method_mapping = {
            "Angebot": self._create_angebot_pdf,
            "Rechnung": self._create_rechnung_pdf,
        }

        document_type_name = self.document_type.name if self.document_type else None
        if not document_type_name:
            logger.error(f"Document [ID: {self.id}] has no type defined.")
            raise ValueError("Das Dokument hat keinen Typ (DocumentType.name fehlt).")

        create_pdf_method = method_mapping.get(document_type_name)
        if not create_pdf_method:
            logger.error(f"No PDF creation method defined for Document [ID: {self.id}, Type: {document_type_name}].")
            raise ValueError(f"Keine Methode zur PDF-Erstellung für den Dokumenttyp '{document_type_name}' definiert.")

        try:
            pdf_file_path = create_pdf_method()
            if pdf_file_path:
                self.file_path = pdf_file_path
                self.save()
                logger.info(f"PDF successfully created for Document [ID: {self.id}] at {pdf_file_path}.")
                return True
        except Exception as e:
            logger.exception(f"Error occurred while creating PDF for Document [ID: {self.id}, Type: {document_type_name}]: {e}")
            raise

        logger.error(f"Failed to create PDF for Document [ID: {self.id}, Type: {document_type_name}].")
        raise ValueError(f"Fehler bei der Erstellung des PDFs für den Dokumenttyp '{document_type_name}'.")

    def _create_angebot_pdf(self):
        logger.info(f"Generating Angebot PDF for Document [ID: {self.id}, Order ID: {self.order.id}].")

        due_to = self.order.created_at + timedelta(days=30) if self.order.created_at else timezone.now() + timedelta(days=30)
        phases = self.order.order_service_phases.select_related(
            'service_phase__fee_group'
        ).order_by('service_phase__fee_group__name', 'service_phase__lph', 'weight')

        grouped_phases = {}
        for phase in phases:
            group_key = phase.service_phase.fee_group.name if phase.service_phase.fee_group else "Unknown"
            grouped_phases.setdefault(group_key, []).append(phase)

        context = {
            'document': self,
            'order': self.order,
            'grouped_phases': grouped_phases,
            'customer': self.order.customer,
            'total_net_sum': self.order.total_net,
            'total_vat': self.order.total_vat,
            'total_gross_sum': self.order.total_gross,
            'due_to': due_to,
        }

        file_name = f"{self.order.nr}-{self.document_type.name.replace(' ', '_')}-{timezone.now().strftime('%Y-%m-%d')}.pdf"

        logger.debug(f"Rendering PDF for Document [ID: {self.id}] with context: {context}.")
        return self._generate_pdf('admin/orders/angebot_pdf_template.html', context, file_name)

    def _create_rechnung_pdf(self):
        logger.info(f"Generating Rechnung PDF for Document [ID: {self.id}, Order ID: {self.order.id}].")

        due_to = self.order.created_at + timedelta(days=30) if self.order.created_at else timezone.now() + timedelta(days=30)

        flat_fees = self.order.flat_fees.all().order_by('id')
        line_items = self.order.line_items.all().order_by('id')

        # Alle Aufgaben mit Summen
        task_data = []
        tasks = self.order.order_tasks.all().order_by('id')
        for task in tasks:
            positions = task.task_positions.filter(document=self)
            hours_worked = sum([pos.hours_worked for pos in positions])
            net_sum = hours_worked * self.order.hourly_rate if self.order.hourly_rate else 0
            vat_sum = net_sum * Decimal(self.order.vat.rate) / 100 if self.order.vat else 0
            gross_sum = net_sum + vat_sum

            task_data.append({
                'name': task.name,
                'description': task.description,
                'hours_worked': hours_worked,
                'net_sum': net_sum,
                'vat_sum': vat_sum,
                'gross_sum': gross_sum,
            })

        # Bankverbindungen
        banks = self.order.company.banks.all()

        context = {
                'document': self,
                'order': self.order,
                'customer': self.order.customer,
                'tasks': task_data,
                'flat_fees': flat_fees,
                'line_items': line_items,
                'total_net_sum': self.order.total_net,
                'total_vat': self.order.total_vat,
                'total_gross_sum': self.order.total_gross,
                'due_to': due_to,
                'banks': banks,
            }

        file_name = f"{self.order.nr}-{self.document_type.name.replace(' ', '_')}-{timezone.now().strftime('%Y-%m-%d')}.pdf"

        logger.debug(f"Rendering Rechnung PDF for Document [ID: {self.id}] with context: {context}.")
        return self._generate_pdf('admin/orders/rechnung_pdf_template.html', context, file_name)

    def _generate_pdf(self, template_name, context, file_name):
        logger.info(f"Starting PDF generation for Document [ID: {self.id}, File Name: {file_name}].")

        try:
            rendered_html = self._render_template_with_double_pass(template_name, context)
            logger.debug(f"HTML rendered for Document [ID: {self.id}, Template: {template_name}].")

            pdf_buffer = BytesIO()
            pisa_status = pisa.CreatePDF(rendered_html, dest=pdf_buffer)
            if pisa_status.err:
                logger.error(f"PDF rendering failed for Document [ID: {self.id}].")
                return None

            file_path = f'documents/{self.updated_at.year}/{self.document_type.name.replace(" ", "_")}/{file_name}'
            if default_storage.exists(file_path):
                default_storage.delete(file_path)

            file_content = ContentFile(pdf_buffer.getvalue())
            saved_file_path = default_storage.save(file_path, file_content)

            logger.info(f"PDF saved successfully for Document [ID: {self.id}] at {saved_file_path}.")
            return saved_file_path
        except Exception as e:
            logger.exception(f"Error generating PDF for Document [ID: {self.id}]: {e}")
            raise

    def _render_template_with_double_pass(self, template_name, context):
        """
        Rendert ein Template zweimal, um verschachtelte Platzhalter korrekt zu lösen.

        Diese Methode lädt ein HTML-Template, rendert es einmal mit dem bereitgestellten Kontext
        und verarbeitet das gerenderte HTML anschließend erneut als Template. Diese doppelte
        Verarbeitung sorgt dafür, dass auch verschachtelte Platzhalter vollständig aufgelöst werden.

        Schritte:
            1. Laden des HTML-Templates aus dem Templates-Verzeichnis.
            2. Erstes Rendern mit dem bereitgestellten Kontext.
            3. Umwandeln des ersten Outputs in ein neues Template.
            4. Zweites Rendern des neuen Templates mit demselben Kontext.

        Args:
            template_name (str): Der Name des HTML-Templates.
            context (dict): Der Kontext, der für das Rendering verwendet wird.

        Returns:
            str: Der vollständig gerenderte HTML-String, bereit zur Umwandlung in ein PDF.
        """
        # Template-Umgebung laden
        template_dir = os.path.join(settings.BASE_DIR, 'orders', 'templates')
        env = environment(loader=FileSystemLoader(template_dir))

        # Template laden
        template = env.get_template(template_name)

        # Erstes Rendern
        first_render = template.render(context)

        # Zweites Rendern
        second_template = env.from_string(first_render)
        second_render = second_template.render(context)

        return second_render

    def generate_zugferd_xml(self, profile="COMFORT"):
        # 1. Neues ZF-Dokument
        zf = ZFDocument()
        # Profil-ID: optional BASIC, COMFORT, EXTENDED
        profile_uri = {
            "BASIC": "urn:cen.eu:en16931:2017#conformant#urn:factur-x.eu:1p0:basic",
            "COMFORT": "urn:cen.eu:en16931:2017#conformant#urn:factur-x.eu:1p0:comfort",
            "EXTENDED": "urn:cen.eu:en16931:2017#conformant#urn:factur-x.eu:1p0:extended",
        }[profile]
        zf.context.guideline_parameter.id = profile_uri

        # 2. Header-Felder
        zf.header.id = self.order.nr
        zf.header.type_code = "380"
        zf.header.name = "RECHNUNG"
        zf.header.issue_date_time.value = self.created_at
        zf.header.languages.add("de")
        if self.note:
            note = IncludedNote(); note.content.add(self.note); zf.header.notes.add(note)

        # 3. Seller (your Company)
        s = zf.trade.agreement.seller
        c = self.order.company
        s.name = c.name
        s.address.street = c.street
        s.address.city_name = c.city
        s.address.postcode = c.postal_code
        s.address.country_id = c.country_code
        if c.vat_id:
            s.tax_registrations.add(TaxRegistration(id=("VA", c.vat_id)))

        # 4. Buyer (Customer)
        b = zf.trade.agreement.buyer
        cust = self.order.customer
        b.name = cust.name
        b.address.street = cust.street
        b.address.city_name = cust.city
        b.address.postcode = cust.postcode
        b.address.country_id = cust.country_code
        if cust.vat_id:
            b.tax_registrations.add(TaxRegistration(id=("VA", cust.vat_id)))

        # 5. Settlement info
        zf.trade.settlement.currency_code = "EUR"
        mm = zf.trade.settlement.payment_means
        mm.type_code = self.payment_type or "30"
        zf.trade.settlement.invoicee.name = cust.name
        zf.trade.settlement.payee.name = c.name

        # 6. LineItem-Mapping
        for tp in self.taskpositions.all():
            li = LineItem()
            li.name = tp.description
            li.quantity = Decimal(tp.quantity)
            li.unit_code = tp.unit or "HUR"
            li.net_amount = Decimal(tp.net_sum)
            li.charge_amount = Decimal(tp.net_sum)
            li.gross_amount = Decimal(tp.gross_sum)
            li.tax_category = "S"
            li.tax_percent = Decimal(tp.vat_rate * 100)
            li.tax_amount = Decimal(tp.vat_sum)
            zf.trade.line_items.add(li)

        # 7. XML-Bytes generieren
        xml = zf.serialize()
        return xml


    class Meta:
        verbose_name = "Dokument"  # Singularform für das Modell
        verbose_name_plural = "Dokumente"  # Pluralform für das Model

@receiver(post_save, sender=Document)
def link_related_items_on_document_save(sender, instance, created, **kwargs):
    """
    Signal für das Verknüpfen von OrderLineItems und OrderServicePhases mit einem Dokument nach dem Speichern.
    """
    print(f"Signal link_related_items_on_document_save called for {instance} Type: {instance.document_type.name}")

    # Vorhandener Code zum Verknüpfen von TaskPositions
    if instance.document_type.book_tasks:
        # Verknüpfe nur offene TaskPositions, die noch nicht mit einem Dokument verknüpft sind
        new_task_positions = TaskPosition.objects.filter(
            task__order=instance.order,
            status='open',
            document__isnull=True
        )
        logger.info(f"The system will create {len(new_task_positions)} new TaskPositions for {instance.id} with {len(new_task_positions)} of the system.")
        new_task_positions.update(document=instance, status='booked')
        instance.task_positions.update(status='booked')
        for new_task_position in new_task_positions:
            logger.info(f"TaskPosition {new_task_position.id} for {instance.id} has been set to {new_task_position.document.id}")
    else:
        # Verknüpfe alle TaskPositions des Projekts, unabhängig vom Status
        task_positions = TaskPosition.objects.filter(
            task__order=instance.order,
            document__isnull=True
        )
        task_positions.update(document=instance)

@receiver(pre_delete, sender=Document)
def reset_task_positions_on_document_delete(sender, instance, **kwargs):
    # Setze den Status der TaskPositions auf 'open' und entferne die Verknüpfung zum Dokument
    print(f"Signal reset_task_positions_on_document_delete called for {instance}")
    TaskPosition.objects.filter(document=instance).update(status='open', document=None)

class Vat(GcAbstractModel):
    """
    Defines a VAT (Value Added Tax) rate applicable to projects.

    Attributes:
        name (str): The name of the VAT (e.g., "Standard VAT").
        rate (Decimal): The percentage rate of VAT (e.g., 19.0 for 19% VAT).
        is_default (bool): A boolean flag indicating if this VAT rate is the default.

    The `Vat` class is used to apply specific tax rates to projects, with an option
    to set a default rate.
    """
    name = models.CharField(
        max_length=100,
        verbose_name="Steuername"  # Kurz und prägnant für den Namen der Steuer
    )
    rate = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        default=19.0,
        verbose_name="Steuersatz (%)"  # Eindeutige Bezeichnung mit Prozentangabe
    )
    is_default = models.BooleanField(
        default=False,
        verbose_name="Standard"  # Kurz und präzise, um den Standardsteuersatz zu kennzeichnen
    )
    def __str__(self):
        return f"{self.name} ({self.rate}%)"

    class Meta:
        verbose_name = "Steuerart"  # Singularform für das Modell
        verbose_name_plural = "Steuerarten"  # Pluralform für das Modell

    def save(self, *args, **kwargs):
        if self.is_default:
            Vat.objects.filter(is_default=True).update(is_default=False)
        super(Vat, self).save(*args, **kwargs)





""" Order """

# Projekte
# Todo: Mach nen Foreign Key von Contact zu Order, damit die Contacts direkt als Inline
# im Order Admin verwendet werden können. Nenne Contact in OrderContact um. An das Nav Menu
# denken - Contact raus
class Order(GcAbstractModel):
    """
    Represents a project within the system, with associated fee classes, tax,
    cost, and service phase details.

    Attributes:
        name (str): The name of the project.
        nr (str): A unique identifier for the project.
        customer (Customer): The customer associated with this project.
        company (Company): The company associated with this project.
        description (str): A textual description of the project.
        hourly_rate (Decimal): The hourly rate for the project.
        flat_rate (Decimal): A flat rate fee for the project.
        vat (Vat): The VAT rate applied to the project.
        start_date (Date): The start date of the project.
        end_date (Date): The end date of the project.
        tags (ManyToManyField): Tags associated with the project.
        eligible_costs (Decimal): The eligible costs for fee calculations.
        fee_cost (Decimal): The base fee amount for calculating costs.
        fee_classes (ManyToManyField): The fee classes associated with the project.
        additional_costs (Decimal): Additional costs in percentage for the project.

    Methods:
        clean(): Validates that either `hourly_rate` or `flat_rate` is set.
        generate_unique_nr(): Generates a unique project number.
        calculate_total_order_service_phase_amount(): Calculates the total amount
            for all non-excluded service phases.
        calculate_rebate_base_amount(): Calculates the base amount for rebate calculation.
        calculate_total_order_service_phase_rebate_amount(): Calculates the total rebate amount.
        calculate_total_order_line_item_amount(): Calculates the total amount for all
            line items.
        calculate_total_additional_costs_amount(): Calculates additional costs.
        calculate_total_amount(): Calculates the net total amount for the project.
        calculate_vat_amount(): Calculates the VAT amount.
        calculate_total_amount_with_vat(): Calculates the total amount including VAT.
    """
    name = models.CharField(
        max_length=100,
        null=True,
        blank=True,
        verbose_name="Projektbezeichnung"  # Prägnant
    )
    nr = models.CharField(
        max_length=10,
        null=True,
        blank=True,
        unique=True,
        verbose_name="Auftragsnummer"  # Eine kurze, klare Beschreibung der Auftragsnummer
    )
    customer = models.ForeignKey(
        'customers.Customer',
        on_delete=models.CASCADE,
        verbose_name="Kunde"  # Kurz und prägnant
    )
    company = models.ForeignKey(
        Company,
        on_delete=models.CASCADE,
        default=1,
        verbose_name="Firma"  # Kurz, gängig und klar
    )
    description = models.TextField(
        verbose_name="Beschreibung (Intern)",  # Standardbegriff für Textfelder
        blank=True,
        null=True
    )
    hourly_rate = models.DecimalField(
        max_digits=6,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Stundensatz"  # Klare und kurze Bezeichnung für den Stundensatz
    )
    flat_rate = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Pauschale"
    )
    vat = models.ForeignKey(
        Vat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name="Steuersatz"  # Kurz und gebräuchlich für die Verknüpfung zu VAT
    )
    start_date = models.DateField(
        null=True,
        blank=True,
        verbose_name="Startdatum"  # Klare Bezeichnung für den Starttermin
    )
    end_date = models.DateField(
        null=True,
        blank=True,
        verbose_name="Enddatum"  # Klare Bezeichnung für das Enddatum
    )
    tags = models.ManyToManyField(
        'Tag',
        blank=True,
        related_name='orders',
        verbose_name="Tags"
    )
    # Neues Feld für Nebenkosten in Prozent
    additional_costs = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Nebenkosten (%)",
        help_text="Prozentuale Nebenkosten für das Projekt.",
        default=5
    )
    # Feld für Fahrtkosten
    km_cost = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Fahrtkosten (€)",
        default=0
    )
    # Feld für Kilometer

    # Feld für Fahrtkosten
    km = models.DecimalField(
        max_digits=12,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Geleistete km",
        default=0
    )

    class Meta:
        verbose_name = "Projekt"  # Singularform für das Modell
        verbose_name_plural = "Projekte"  # Pluralform für das Modell

    def clean(self):
        logger.debug(f"Cleaning Order [ID: {self.id}].")

        if not self.hourly_rate and not self.flat_rate:
            logger.error(f"Validation error: No hourly rate or flat rate defined for Order [ID: {self.id}].")
            raise ValidationError('Es muss entweder ein Stundensatz oder eine Pauschale angegeben werden.')

        logger.info(f"Order [ID: {self.id}] passed validation.")
        super().clean()

    def generate_unique_nr(self):
        logger.info(f"Generating unique order number for Order [ID: {self.id}, Company ID: {self.company.id}].")

        current_year = timezone.now().year % 100
        order_counter, created = OrderCounter.objects.get_or_create(
            company=self.company,
            year=current_year,
            defaults={'counter': 0}
        )

        order_counter.counter += 1
        order_counter.save()

        formatted_order_id = f"{order_counter.counter:03d}"
        prefix = self.company.prefix or ''
        suffix = self.company.suffix or ''
        unique_nr = f"{prefix}{current_year}-{formatted_order_id}{suffix}"

        logger.info(f"Generated unique order number: {unique_nr} for Order [ID: {self.id}].")
        return unique_nr

    @property
    def total_service_phases_without_rebate(self):
        """
        Summiert die Beträge aller OrderServicePhases ohne Berücksichtigung des Rabatts,
        die in die Gesamtsumme aufgenommen werden sollen.
        """
        return sum(
            phase.sum_total_amount_without_rebate_for_sum
            for phase in self.order_service_phases.all()
        )

    @property
    def total_service_phases(self):
        """
        Summiert die Beträge aller OrderServicePhases.
        """
        return sum(
            Decimal(phase.sum_total_amount_for_sum)
            for phase in self.order_service_phases.all()
            if phase.sum_total_amount_for_sum
        )

    @property
    def sum_total_rebate_service_phases(self):
        """
        Summiert die Rabattbeträge aller OrderServicePhases, die in die Gesamtsumme aufgenommen werden sollen.
        """
        return sum(
            phase.sum_rebate_amount
            for phase in self.order_service_phases.all()
            if phase.include_in_total_amount  # Nur wenn sie zur Gesamtsumme gehören
        )

    @property
    def total_line_items(self):
        """
        Summiert die Beträge aller OrderLineItems.
        """
        return sum(
            Decimal(item.amount)
            for item in self.line_items.all()
            if item.amount
        )

    @property
    def total_flat_fees(self):
        """
        Summiert die Beträge aller FlatFees.
        """
        return sum(
            Decimal(flat_fee.amount)
            for flat_fee in self.flat_fees.all()
            if flat_fee.amount
        )

    @property
    def total_additional_costs(self):
        """
        Berechnet die zusätzlichen Kosten basierend auf dem Prozentsatz von additional_costs.
        """
        base_amount = self.total_service_phases + self.total_line_items + self.total_flat_fees
        return (Decimal(self.additional_costs) * base_amount / 100) if self.additional_costs else Decimal(0)

    @property
    def total_km_costs(self):
        """
        Berechnet die Gesamtkosten basierend auf km und km_cost.
        """
        return Decimal(self.km) * Decimal(self.km_cost) if self.km and self.km_cost else Decimal(0)

    @property
    def total_net(self):
        """
        Berechnet die Gesamtnetto-Summe.
        """
        return (
                self.total_service_phases
                + self.total_line_items
                + self.total_flat_fees
                + self.total_additional_costs
                + self.total_km_costs
        )

    @property
    def total_vat(self):
        """
        Berechnet die Mehrwertsteuer basierend auf der Netto-Summe und dem Mehrwertsteuersatz.
        """
        return (self.total_net * Decimal(self.vat.rate) / 100) if self.vat and self.vat.rate else Decimal(0)

    @property
    def total_gross(self):
        """
        Berechnet die Gesamtsumme (Brutto).
        """
        return self.total_net + self.total_vat


    def __str__(self):
        return f"{self.nr} | {self.customer.name}"

# Besondere Leistungen
class OrderLineItem(GcAbstractModel):
    """
    Represents a specific line item within an order, typically denoting additional
    services or costs.

    Attributes:
        order (Order): The project associated with this line item.
        name (str): The name or description of the line item.
        amount (Decimal): The cost of this line item in Euros.

    Each `OrderLineItem` is a distinct service or cost entry related to a project phase,
    which may not be included in standard project fees but are added separately.
    """
    order = models.ForeignKey(
        'Order',
        on_delete=models.CASCADE,
        related_name="line_items",
        verbose_name="Projekt"
    )
    name = models.TextField(
        null=True,
        blank=True,  # muss bei  PauschalProjekt leer bleiben
        verbose_name="Bezeichnung",
        help_text="Beschreibung der Position. Sie können hier Textformatierungen anwenden."
    )
    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Betrag (€)",
        help_text="Betrag für diese Position in Euro."
    )

    def __str__(self):
        # Hole alle line_items der zugehörigen Order, sortiert nach ID (oder einem anderen Kriterium)
        related_items = self.order.line_items.all().order_by('id')

        # Finde den Index des aktuellen Objekts
        index = list(related_items).index(self) + 1  # +1 für 1-basiertes Zählen

        # Gib den Index als Teil des Strings zurück
        return f"#{index}"

    class Meta:
        verbose_name = "Besondere Leistungen"
        verbose_name_plural = "Besondere Leistung"

# Leistungsphasen
class OrderServicePhase(GcAbstractModel):
    """
    Represents a specific service phase within an order, with custom configuration options.

    Attributes:
        order (Order): The project associated with this service phase.
        service_phase (ServicePhase): The predefined service phase.
        name (str): The name or description of this service phase.
        percent (Decimal): The percentage to apply within this service phase.
        rebate (Decimal): A specific rebate percentage for this phase.
        exclude_from_total_amount (bool): If True, excludes this phase from the total amount.
        exclude_from_rebate (bool): If True, excludes this phase from rebate calculations.
        weight (int): A weight for ordering the phases.

    Methods:
        total_amount(): Calculates the total amount for this phase based on `percent` and
            project fees.
    """
    order = models.ForeignKey(
        'Order',
        on_delete=models.CASCADE,
        related_name='order_service_phases',
        verbose_name="Projekt"
    )
    service_phase = models.ForeignKey(
        'ServicePhase',
        on_delete=models.CASCADE,
        null=True,
        blank=True,  # muss bei  PauschalProjekt leer bleiben
        verbose_name="Leistungsphase",
        related_name="order_service_phases"
    )
    # Felder ähnlich wie OrderLineItem, jedoch mit `percent` anstelle von `amount`
    name = models.TextField(
        null=True,
        blank=True,  # muss bei  PauschalProjekt leer bleiben
        verbose_name="Bezeichnung",
        help_text="Beschreibung der Leistungsphase."
    )
    percent = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        null=True,
        blank=True,  # muss bei  PauschalProjekt leer bleiben
        verbose_name="Prozentwert",
        help_text="Prozentwert für diese Phase"
    )
    rebate = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Rabatt (%)",
        help_text="Spezieller Rabatt für diese LPH"
    )
    # Neue Felder für die Einstellungen
    include_in_total_amount = models.BooleanField(
        default=True,
        verbose_name="Summe",
        help_text="Diese Position von der Gesamtsumme auschließen? Dann deaktivieren!"
    )
    @property
    def fee_group(self):
        return self.service_phase.fee_group

    @property
    def fee_cost(self):
        """
        Holt die fee_costs der zugehörigen FeeGroup aus OrderFeeGroup
        """
        if not self.fee_group:
            return None

        # Suche nach der passenden OrderFeeGroup
        order_fee_group = self.order.order_fee_groups.filter(fee_group=self.fee_group).first()

        return order_fee_group.fee_costs if order_fee_group else None

    weight = models.PositiveIntegerField(_("weight"), default=0, db_index=True)  # Feld für die Sortierung

    @property
    def sum_amount(self):
        """
        Berechnet die Basissumme für diese Leistungsphase.
        """
        if self.fee_cost:
            return (self.percent / 100) * self.fee_cost if self.percent else 0
        else:
            return 0

    @property
    def sum_rebate_amount(self):
        """
        Berechnet den Rabattbetrag für diese Phase.
        """
        return self.sum_amount * (self.rebate / 100) if self.rebate else 0

    @property
    def sum_total_amount(self):
        """
        Berechnet die Gesamtsumme, inklusive Rabatt.
        """
        return self.sum_amount - self.sum_rebate_amount

    @property
    def sum_total_amount_for_sum(self):
        """
        Gibt die Gesamtsumme zurück, falls sie zur Gesamtsumme des Projekts hinzugefügt werden soll.
        """
        return self.sum_total_amount if self.include_in_total_amount else 0

    @property
    def sum_total_amount_without_rebate_for_sum(self):
        """
        Berechnet die Gesamtsumme ohne Rabatt, falls include_in_total_amount True ist.
        """
        return self.sum_amount if self.include_in_total_amount else 0

    # Django Unfold own method for setting the name of the inline
    def get_inline_title(self):
        return f"{self.service_phase.lph} {self.fee_group.name}"

    def __str__(self):
        return f"{self.service_phase.lph}"

    class Meta:
        verbose_name = "Projekt Leistungsphase"
        verbose_name_plural = "Projekt Leistungsphasen"
        ordering = ['service_phase__fee_group__name', 'service_phase__lph', 'weight']

# Zuordnung der Honorarsumme je Zone (Architektur, Tragwerksplanung)
class OrderFeeGroup(GcAbstractModel):
    order = models.ForeignKey(
        'Order',
        on_delete=models.CASCADE,
        related_name='order_fee_groups',
        verbose_name="Projekt"
    )
    fee_group = models.ForeignKey(
        'FeeGroup',
        on_delete=models.CASCADE,
        verbose_name="Honorargruppe"
    )
    eligible_costs = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Anrechenbare Kosten (€)"
    )
    fee_costs = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True,
        verbose_name="Honorarsumme (€)"
    )

    class Meta:
        verbose_name = "Projekt Honorargruppe"
        verbose_name_plural = "Projekt Honorargruppen"
        unique_together = ('order', 'fee_group')  # Eine FeeGroup darf pro Order nur einmal vorkommen

    def __str__(self):
        return f"{self.order.name} - {self.fee_group.name}"

# Pauschalen
class FlatFee(GcAbstractModel):
    """
    Represents a flat fee that can be freely added to an Order.

    Attributes:
        order (Order): The project this flat fee is associated with.
        name (str): The name or description of the flat fee (e.g., "Consultation Fee").
        amount (Decimal): The amount of the flat fee in Euros.
    """
    order = models.ForeignKey(
        'Order',
        on_delete=models.CASCADE,
        related_name="flat_fees",
        verbose_name="Projekt"
    )
    name = models.TextField(
        max_length=100,
        verbose_name="Name der Pauschale",
        help_text="Description of the flat fee"
    )
    amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        verbose_name="Betrag (€)",
        help_text="Amount for this flat fee in Euros"
    )

    def __str__(self):
        return f"{self.order.nr} - {self.name} ({self.amount} €)"

    class Meta:
        verbose_name = "Pauschale"
        verbose_name_plural = "Pauschalen"

# Aufgaben für MA
class Task(GcAbstractModel):
    STATUS_CHOICES = [
        ('open', 'Offen'),
        ('booked', 'Abgerechnet'),
    ]

    name = models.CharField(
        max_length=100,
        verbose_name="Aufgabenname"  # Kurz und prägnant für den Namen der Aufgabe
    )
    description = models.TextField(
        blank=True,
        null=True,
        verbose_name="Beschreibung"  # Standardmäßige Bezeichnung für Beschreibungen
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='created',
        verbose_name="Status"  # Einfacher und klarer Begriff
    )
    order = models.ForeignKey(
        'Order',
        related_name='order_tasks',
        on_delete=models.CASCADE,
        verbose_name="Projekt"  # Klar für den verknüpften Auftrag
    )
    tags = models.ManyToManyField(
        'Tag',
        blank=True,
        related_name='tasks',
        verbose_name="Tags"
    )
    document = models.ForeignKey(  # Hinzufügen der Beziehung zu Document
        'Document',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,  # Tasks bleiben bestehen, auch wenn das Dokument gelöscht wird
        related_name='tasks',
        verbose_name="Dokument"
    )

    def __str__(self):
        return f"{self.order.nr} {self.name}"

    class Meta:
        verbose_name = "Aufgabe"  # Singularform für das Modell
        verbose_name_plural = "Aufgaben"  # Pluralform für das Modell

    def clean(self):
        if not self.order:
            raise ValidationError('Task must be associated with an Order.')

    def copy_task(self):
        logger.info(f"Copying Task [ID: {self.id}, Name: {self.name}, Order ID: {self.order.id}].")

        try:
            new_task = Task(
                description=self.description,
                status=self.status,
                order=self.order,
            )
            new_task.save()
            logger.info(f"Successfully created copy of Task [Old ID: {self.id}, New ID: {new_task.id}].")
            return new_task
        except Exception as e:
            logger.exception(f"Error copying Task [ID: {self.id}]: {e}")
            raise


# Zeiterfassung per Aufgabe MA
class TaskPosition(GcAbstractModel):
    STATUS_CHOICES = Task.STATUS_CHOICES

    task = models.ForeignKey(
        Task,
        on_delete=models.CASCADE,
        related_name='task_positions',
        verbose_name="Aufgabe"  # Task the position is related to
    )
    hours_worked = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        verbose_name="Geleistete Stunden"  # Hours worked on the task
    )
    task_position_date = models.DateField(
        default=timezone.now,
        verbose_name="Datum"  # The date of the task position entry
    )
    distance_in_km = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        verbose_name="Fahrtkosten (in km)",  # Travel distance in kilometers
        null=True,
        blank=True
    )
    description = models.TextField(
        blank=True,
        null=True,
        verbose_name="Bemerkung"  # Optional remark for the task position
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='open',
        verbose_name="Status",
        editable=True  # Status is not editable
    )
    document = models.ForeignKey(
        'Document',  # Verknüpfung zum Dokument
        on_delete=models.SET_NULL,
        null=True,  # TaskPosition kann vorerst kein Dokument haben
        blank=True,
        related_name='task_positions',  # Rückwärtsverknüpfung
        verbose_name="Verknüpftes Dokument"
    )

    def __str__(self):
        # Zwecks Suchergebnisse bei Zeiterfassung
        return f"{self.task.order.nr} {self.task.name}"


    def abstract_created_by__full_name(self):
        return f"{self.created_by.last_name} {self.created_by.first_name}"




""" Tags """

def generate_random_color():
    """Generiere eine zufällige Farbe im hexadezimalen Format"""
    return "#{:06x}".format(random.randint(0, 0xFFFFFF))

class Tag(GcAbstractModel):
    name = models.CharField(max_length=100, unique=True, verbose_name="Tag-Name")
    color = RGBColorField(
        default=generate_random_color,  # Generiere eine zufällige Farbe beim Erstellen
        verbose_name="Farbe"
    )

    def color_display(self):
        """Zeigt die Farbe im Admin an"""
        return format_html(
            '<span style="background-color: {}; padding: 5px 10px; border-radius: 3px;">{}</span>',
            self.color,
            self.name
        )
    color_display.short_description = "Farbe"

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Tag"
        verbose_name_plural = "Tags"


""" zugferd """
from django.db import models

class ZugferdField(GcAbstractModel):
    name = models.CharField(max_length=200, unique=True)
    label = models.CharField(max_length=200, blank=True, null=True)
    group = models.CharField(max_length=200, blank=True, null=True)
    data_type = models.CharField(max_length=100, blank=True, null=True)
    profile = models.CharField(
        max_length=50,
        choices=[("BASIC", "Basic"), ("EN16931", "Comfort"), ("EXTENDED", "Extended")],
        default="BASIC"
    )
    target_xpath = models.CharField(max_length=500, blank=True, null=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.name} ({self.profile})"