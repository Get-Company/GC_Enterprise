# orders/admin.py
from datetime import timedelta, date, datetime
from pprint import pprint

from django.contrib import admin
from django import forms
from django.db import models
from django.db.models import Q, Min, Max
from django.http import HttpResponse, HttpRequest
from django.shortcuts import redirect
from django.template.loader import render_to_string
from django.urls import reverse_lazy
from django.utils.safestring import mark_safe

from unfold.contrib.filters.admin import RangeDateFilter, FieldTextFilter, RangeDateTimeFilter, \
    MultipleRelatedDropdownFilter, DropdownFilter, MultipleChoicesDropdownFilter
from unfold.decorators import action

from core.admin import GcAbstractModelAdmin, GcAbstractTabularInline, GcAbstractStackedInline, \
    GcAbstractImportExportModelAdmin
from .models import Order, Document, Task, Vat, Tag, DocumentType, TaskPosition, FeeGroup, \
    ServicePhase, OrderLineItem, OrderServicePhase, FlatFee, OrderFeeGroup
from django.utils.translation import gettext_lazy as _
from django.contrib import messages


class DocumentInline(GcAbstractTabularInline):
    model = Document
    extra = 0  # Anzahl der zusätzlichen leeren Felder für neue Dokumente
    fields = ('document_type','updated_at')
    readonly_fields = ('document_type','updated_at')

class TaskInline(GcAbstractTabularInline):
    model = Task
    extra = 0
    fields = ('name', 'status')

class TaskPositionInline(GcAbstractTabularInline):
    model = TaskPosition
    fields = ('task', 'hours_worked', 'abstract__created_by__full_name', 'date', 'status')
    extra = 0  # Keine leeren Felder, nur verknüpfte anzeigen
    readonly_fields = ('abstract__created_by__full_name', )
    verbose_name = "Zeiterfassung"
    verbose_name_plural = "Zeiterfassungen MA"

class OrderFeeGroupInline(GcAbstractTabularInline):
    model = OrderFeeGroup
    extra = 0  # Anzahl der leeren Felder für neue Einträge
    fields = ('fee_group', 'eligible_costs', 'fee_costs')
    autocomplete_fields = ['fee_group']  # Falls FeeGroup groß ist, Autocomplete nutzen

class OrderServicePhaseInline(GcAbstractStackedInline):
    model = OrderServicePhase
    ordering_field = "service_phase"  # Legt das Feld für die Sortierung fest
    hide_ordering_field = False  # Blendet das Feld in der UI aus
    list_display = ["weight",]
    fields = ('service_phase', 'name', 'percent','rebate', 'include_in_total_amount', 'sum_total_amount',)  # Zeige nur die relevanten Felder ohne exclude-Felder
    readonly_fields = ('fee_group', 'sum_total_amount',)
    extra = 0
    autocomplete_fields = ['service_phase']

class OrderLineItemInline(GcAbstractStackedInline):
    model = OrderLineItem
    extra = 1  # Anzahl der leeren Felder für neue Positionen
    fields = ('name', 'amount')

class FlatFeeInline(GcAbstractTabularInline):
    model = FlatFee
    extra = 1
    fields = ('name', 'amount')




""" Order """

@admin.register(Order)
class OrderAdmin(GcAbstractImportExportModelAdmin):
    list_display = GcAbstractImportExportModelAdmin.list_display + ['nr', 'customer', 'company', 'total_net', 'updated_at']
    search_fields = ('nr', 'customer__name', 'company__name', 'start_date')
    list_filter = (
        ('customer', MultipleRelatedDropdownFilter),
        ('company', MultipleRelatedDropdownFilter),
        ('start_date', RangeDateFilter),
        ('created_at', RangeDateFilter)
    )

    # Enable autocomplete for the 'customer' fields
    autocomplete_fields = ['customer']
    change_form_after_template = "admin/orders/sums_for_project_table_layout.html"
    readonly_fields = ('total_net',)
    inlines = [OrderFeeGroupInline, OrderServicePhaseInline, OrderLineItemInline, FlatFeeInline, TaskInline, DocumentInline]


    # Anzeige der Inlines wird basierend auf den gespeicherten FeeGroups gesteuert

    fieldsets = (
        ('Projekt Details', {
            'fields': ('nr', 'name', 'customer', 'company', 'additional_costs',
                       'vat', 'hourly_rate', 'flat_rate', 'km_cost', 'km'),
            'classes': ('tab',)
        }),
        ('Beschreibung', {
            'fields': ('description',),
            'classes': ('tab',)
        }),
        ('Projektdatum', {
            'fields': ('start_date', 'end_date'),
            'classes': ('tab',)
        }),
    )


    def get_readonly_fields(self, request, obj=None):
        if obj:  # Wenn eine Bestellung bearbeitet wird
            return self.readonly_fields + ('created_at', 'updated_at')
        return self.readonly_fields

@admin.register(OrderServicePhase)
class OrderServicePhaseAdmin(GcAbstractModelAdmin):
    list_display = GcAbstractModelAdmin.list_display + ['order', 'percent']
    search_fields = ['service_phase__fee_group__name', 'service_phase__lph', 'service_phase__name']




""" Vat """

@admin.register(Vat)
class VatAdmin(GcAbstractModelAdmin):
    list_display = GcAbstractModelAdmin.list_display + ['name', 'rate']
    fields = ('name', 'rate', 'is_default')




""" Task """

class TaskAdminForm(forms.ModelForm):
    class Meta:
        model = Task
        fields = '__all__'

    def clean(self):
        cleaned_data = super().clean()
        if not cleaned_data.get('order'):
            raise forms.ValidationError('Jede Aufgabe muss mit einem Projekt verknüpft sein.')
        return cleaned_data

@admin.register(Task)
class TaskAdmin(GcAbstractModelAdmin):
    autocomplete_fields = ['order']
    filter_horizontal = ['tags']

    fieldsets = (
        ('Aufgabendetails', {
            'fields': ('name', 'order')  # Remove VAT field
        }),
        ('Beschreibung', {
            'fields': ('description',),
            'classes': ('collapse',)
        }),
        ('Tags', {
            'fields': ('tags',),
            'classes': ('collapse',)
        }),
    )
    form = TaskAdminForm

    list_display = GcAbstractModelAdmin.list_display + ['name', 'order', 'status', 'created_at', 'updated_at']
    list_filter = (
        ('order', MultipleRelatedDropdownFilter),
        ('status', MultipleChoicesDropdownFilter),
        ('created_at', RangeDateFilter),
        ('updated_at', RangeDateFilter))
    search_fields = ('description', 'name', 'order__nr')

    actions = ['copy_tasks', 'set_status_open', 'set_status_booked']

    def get_search_results(self, request, queryset, search_term):
        """
        Custom search for the Task model to search by both task name and order number in TaskPosition
        """
        queryset, use_distinct = super().get_search_results(request, queryset, search_term)
        # Use Q object to search both task name and order number
        queryset = queryset.filter(Q(name__icontains=search_term) | Q(order__nr__icontains=search_term))
        return queryset, use_distinct

    def get_form(self, request, obj=None, **kwargs):
        form = super(TaskAdmin, self).get_form(request, obj, **kwargs)
        return form

    # Aktion: Aufgaben kopieren
    def copy_tasks(self, request, queryset):
        for task in queryset:
            copied_task = task.copy_task()
            self.message_user(request, f"Kopie der Aufgabe '{copied_task.description}' erstellt.")
    copy_tasks.short_description = "Ausgewählte Aufgaben kopieren"

    # Aktion: Status auf "Offen" setzen
    def set_status_open(self, request, queryset):
        queryset.update(status='open')
        self.message_user(request, "Status der ausgewählten Tasks wurde auf 'Offen' gesetzt.")
    set_status_open.short_description = "Ausgewählte Tasks auf 'Offen' setzen"

    # Aktion: Status auf "Abgerechnet" setzen
    def set_status_booked(self, request, queryset):
        queryset.update(status='booked')
        self.message_user(request, "Status der ausgewählten Tasks wurde auf 'Abgerechnet' gesetzt.")
    set_status_booked.short_description = "Ausgewählte Tasks auf 'Abgerechnet' setzen"

@admin.register(TaskPosition)
class TaskPositionAdmin(GcAbstractModelAdmin):
    """
    Admin-Ansicht für das TaskPosition-Modell.

    Funktionen:
    - Automatisches Setzen eines Standardfilters ("Von-Datum") auf das heutige Datum beim ersten Laden der Seite.
    - Benutzer können den Filter anpassen oder entfernen.
    - Nur Administratoren (Superuser) sehen alle Einträge; andere Benutzer sehen nur ihre eigenen Einträge.
    """
    list_display = GcAbstractModelAdmin.list_display + ['task', 'hours_worked', 'task_position_date', 'distance_in_km', 'status', 'created_by', 'created_at']
    list_filter = (
        ('task_position_date', RangeDateFilter),
        ('task__order', MultipleRelatedDropdownFilter),
        ('created_by', MultipleRelatedDropdownFilter),
        ('updated_at', RangeDateTimeFilter),
    ) # Filter by task and status
    search_fields = ('task__order__nr', 'task__name')  # Search by task, description, or user
    autocomplete_fields = ['task',]
    list_editable = ('hours_worked', 'task_position_date', 'distance_in_km', 'status')
    list_display_links = ('task',)
    list_after_template = "admin/task_positions/sum_for_user.html"
    list_filter_submit = True

    # Inherited fieldsets including 'Verwaltungsdetails' from GcAbstractModelAdmin
    fieldsets = (
        ("Aufgaben Positionen", {
            'fields': ('task', 'hours_worked', 'task_position_date', 'distance_in_km', 'description', 'status')
        }),
    )

    def changelist_view(self, request, extra_context=None):
        """
       Überschreibt die Standard-`changelist_view`, um einen Standardfilter für das heutige Datum
       dynamisch hinzuzufügen, wenn der Filter nicht explizit gesetzt ist.

       Funktionsweise:
       - Überprüft, ob der GET-Parameter `task_position_date_from` existiert.
       - Falls nicht vorhanden, wird das heutige Datum im lokalen Format (`dd.mm.yyyy`) als Standardwert gesetzt.
       - Markiert den Filter mit `default_filter=1`, um zu verhindern, dass der Filter erneut hinzugefügt wird, wenn
         der Benutzer ihn später entfernt.

       Args:
           request (HttpRequest): Die HTTP-Anfrage des Benutzers.
           extra_context (dict, optional): Zusätzliche Kontextdaten (nicht verwendet).

       Returns:
           HttpResponse: Weiterleitung mit dem Standardfilter oder die reguläre `changelist_view`.
       """
        query_set = self.get_queryset(request)
        # Berechnung der gefilterten Stunden
        queryset = query_set
        total_hours_worked = queryset.aggregate(total_hours=models.Sum('hours_worked'))['total_hours'] or 0

        # Berechnung des Zeitraums
        date_range = queryset.aggregate(
            start_date=Min('task_position_date'),
            end_date=Max('task_position_date')
        )
        start_date = date_range['start_date']
        end_date = date_range['end_date']

        # Zusätzliche Informationen an den Kontext übergeben
        if not extra_context:
            extra_context = {}
        extra_context['total_hours_worked'] = total_hours_worked
        extra_context['start_date'] = start_date
        extra_context['end_date'] = end_date

        # Prüfen, ob der Filter für "task_position_date" bereits gesetzt ist
        if 'task_position_date_from' not in request.GET:
            # Heutiges Datum als Standardwert setzen
            today_str = date.today().strftime('%d.%m.%Y')  # Django Admin verwendet lokales Format
            query = request.GET.copy()
            query['task_position_date_from'] = today_str
            query['default_filter'] = '1'  # Markiere, dass der Standardfilter gesetzt wurde
            return redirect(f'{request.path}?task_position_date_from={today_str}')
        return super().changelist_view(request, extra_context=extra_context)

    def get_queryset(self, request):
        """
        Überschreibt das Standard-Queryset, um Benutzerfilter und Berechtigungen anzuwenden.

        Funktionsweise:
        - Filtert die Einträge basierend auf dem aktuellen Benutzer:
            - Superuser sehen alle Einträge.
            - Normale Benutzer sehen nur ihre eigenen Einträge.
        - Wenn der Filter `task_position_date_from` gesetzt ist, wird der `task_position_date`-Filter angewendet:
            - Der Datumswert aus GET wird vom lokalen Format (`dd.mm.yyyy`) ins Datenbankformat (`YYYY-MM-DD`) umgewandelt.
            - Ungültige Datumswerte werden ignoriert.

        Args:
            request (HttpRequest): Die HTTP-Anfrage des Benutzers.

        Returns:
            QuerySet: Gefiltertes Queryset basierend auf Benutzer und GET-Parametern.
        """

        # Hol alle Einträge
        queryset = TaskPosition.objects.all()

        # Nur Chef (superuser) sieht alle Einträge
        if not request.user.is_superuser:
            queryset = queryset.filter(created_by=request.user)

        # Standardfilter auf heute setzen, nur wenn der user nicht explizit "alle" wählt
        if 'task_position_date_from' in request.GET:
            date_from = request.GET.get('task_position_date_from')
            try:
                date_from_parsed = datetime.strptime(date_from, '%d.%m.%Y').date()
                queryset = queryset.filter(task_position_date__gte=date_from_parsed)
            except ValueError:
                pass

        if 'task_position_date_to' in request.GET:
            date_to = request.GET.get('task_position_date_to')
            try:
                date_to_parsed = datetime.strptime(date_to, '%d.%m.%Y').date()
                queryset = queryset.filter(task_position_date__lte=date_to_parsed)
            except ValueError:
                pass

        return queryset




""" Document """

class DocumentAdminForm(forms.ModelForm):
    class Meta:
        model = Document
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Nur offene Tasks des Projekts zur Auswahl anzeigen
        if self.instance and self.instance.order:
            self.fields['tasks'].queryset = Task.objects.filter(order=self.instance.order, status='open')


@admin.register(Document)
class DocumentAdmin(GcAbstractModelAdmin):
    list_display = GcAbstractModelAdmin.list_display + ['order', 'document_type', 'file_path', 'created_at', 'updated_at']
    # Suchfelder verbessert
    search_fields = (
        'order__nr',  # Projektnummer
        'order__customer__name',  # Kundennamen durchsuchen
        'document_type__name',  # Dokumenttyp durchsuchen (z. B. Rechnung)
        'introduction', 'description', 'conclusion' # Beschreibung durchsuchen
    )

    autocomplete_fields = ('order', 'document_type')  # Felder als Autocomplete definieren
    list_filter_submit = True
    list_filter = (
        ("order", MultipleRelatedDropdownFilter),
        ("document_type", MultipleRelatedDropdownFilter),   # Nach Dokumenttyp filtern
        ("order__customer", MultipleRelatedDropdownFilter),  # Nach Kunden filtern
        ("created_at", RangeDateTimeFilter)  # Nach Erstellungsdatum filtern
    )
    readonly_fields = ['variable_help_text',]

    fieldsets = (
        ('Dokumentdetails', {
            'fields': ('order','document_type', 'file_path'),
            'classes': ('tab',)
        }),
        ('Texte + Hilfe', {
            'fields': ('introduction', 'description', 'conclusion', 'variable_help_text' ),
            'classes': ('tab',)
        }),
    )

    actions_detail = ["create_pdf"]

    @action(
        description=_("PDF erstellen"),
        attrs={"style": "border-color: greenyellow;"},
        permissions=["create_pdf"]
    )
    def create_pdf(self, request: HttpRequest, object_id: int):
        try:
            # Abrufen der Dokument-Instanz
            document = Document.objects.get(pk=object_id)
            # Aufruf der create_pdf_for_document Methode
            pdf_path = document.create_pdf_for_document()

            # Überprüfung, ob die PDF-Erstellung erfolgreich war
            if pdf_path:
                self.message_user(request, f"PDF erfolgreich erstellt: {pdf_path}")
            else:
                self.message_user(request, "Fehler bei der PDF-Erstellung", level='error')

        except Document.DoesNotExist:
            self.message_user(request, "Dokument nicht gefunden", level='error')

        # Zurück zur Detailseite des Dokuments
        url_with_id = reverse_lazy("admin:orders_document_change", args=[object_id])
        return redirect(url_with_id)

    def has_create_pdf_permission(self, request: HttpRequest, object_id):
        return True

    def variable_help_text(self, obj=None):
        return mark_safe(render_to_string('admin/orders/document/document_variables_documentation.html'))
    variable_help_text.short_description = "Hilfe zu den Variablen"


@admin.register(DocumentType)
class DocumentTypeAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Dokumenttyp Details', {  # Hauptdetails zum Dokumenttype
            'fields': ('name', 'book_tasks',),
            'classes': ('tab',)
        }),
        ('Beschreibung', {  # Beschreibung zum Dokument
            'fields': ('description',),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['name', 'book_tasks', 'created_by', 'created_at']  # Verwaltungsfelder anzeigen
    search_fields = ('name',)
    list_filter = ('book_tasks',)




""" Tag"""

@admin.register(Tag)
class TagAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Tagdetails', {  # Hauptdetails zum Dokument
            'fields': ('name', 'color'),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['name', 'color_display']  # Zeigt die Farbe im Admin an
    search_fields = ('name',)




""" Fee """

@admin.register(FeeGroup)
class FeeGroupAdmin(GcAbstractImportExportModelAdmin):
    list_display = GcAbstractImportExportModelAdmin.list_display + ['name', 'created_at', 'updated_at']
    search_fields = ('name',)
    fieldsets = (
        ('Honorarklassen Gruppe Details', {
            'fields': ('name',),
            'classes': ('tab',)
        }),
    )

@admin.register(ServicePhase)
class ServicePhaseAdmin(GcAbstractImportExportModelAdmin):
    list_display = GcAbstractImportExportModelAdmin.list_display + ['fee_group', 'lph', 'name',  'percent']
    search_fields = ('fee_group__name', 'lph', 'name', )
    fieldsets = (
        ('Leistungsphase Details', {
            'fields': ('fee_group', 'lph', 'name', 'percent', 'description'),
            'classes': ('tab',)
        }),
    )

    # Define the custom action
    def copy_service_phases(self, request, queryset):
        """
        Custom admin action to duplicate selected ServicePhase objects.
        """
        copied_count = 0
        for obj in queryset:
            obj.pk = None  # Reset primary key to create a new instance
            obj.name = f"C_{obj.name}"  # Add a "C_" prefix to the name
            obj.save()  # Save the new object to the database
            copied_count += 1

        self.message_user(
            request, f"{copied_count} ServicePhase(s) successfully copied.",
            level=messages.SUCCESS
        )

    copy_service_phases.short_description = "Kopiere gewählte Elemente"

    # Register the action
    actions = ['copy_service_phases']
