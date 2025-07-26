import os

from django.core.exceptions import ValidationError
from django.db import models
from phonenumber_field.modelfields import PhoneNumberField

from core.models import GcAbstractModel

# Benutzerdefinierte Validierungsfunktion für Bilddateien
def validate_image_extension(value):
    ext = os.path.splitext(value.name)[1]  # Dateiendung der hochgeladenen Datei
    valid_extensions = ['.jpg', '.jpeg', '.png', '.gif']
    if ext.lower() not in valid_extensions:
        raise ValidationError(f'Nur die folgenden Dateiformate sind erlaubt: {", ".join(valid_extensions)}')


class Company(GcAbstractModel):
    name = models.CharField(
        max_length=255,
        verbose_name="Firmenname"  # Kurz und verständlich für den Namen der Firma
    )
    vat_id = models.CharField(
        max_length=50,
        verbose_name="USt-IdNr."  # Abkürzung für Umsatzsteuer-Identifikationsnummer (VAT ID)
    )
    court_register = models.CharField(
        max_length=50,
        verbose_name="Handelsregister",
        null=True,
        blank=True,
    )
    court = models.CharField(
        max_length=255,
        verbose_name="Gericht",
        null=True,
        blank=True,
    )
    street = models.CharField(
        max_length=255,
        verbose_name="Straße"  # Kurz und gebräuchlich für die Straße
    )
    postal_code = models.CharField(
        max_length=20,
        verbose_name="PLZ"  # Übliche Abkürzung für Postleitzahl
    )
    city = models.CharField(
        max_length=100,
        verbose_name="Stadt"  # Eindeutig und verständlich
    )
    country = models.CharField(
        max_length=100,
        verbose_name="Land"  # Klar für die Ländereingabe
    )
    phone_number = PhoneNumberField(
        verbose_name="Telefonnummer"
    )
    fax_number = PhoneNumberField(
        verbose_name="Faxnummer",
        null=True,
        blank=True,
    )
    email = models.EmailField(
        verbose_name="E-Mail"  # Standardfeld für E-Mail-Adressen
    )
    website = models.URLField(
        blank=True,
        null=True,
        verbose_name="Webseite"  # Klare Bezeichnung für die optionale Website der Firma
    )
    logo = models.ImageField(
        upload_to='company/company_logos/',
        blank=True,
        null=True,
        verbose_name="Firmenlogo",  # Verständlich und gebräuchlich für das hochgeladene Firmenlogo
        validators=[validate_image_extension]  # Validierung für erlaubte Bildformate
    )
    signature = models.ImageField(
        upload_to='company/company_logos/',
        blank=True,
        null=True,
        verbose_name="Unterschriftenbild",  # Verständlich und gebräuchlich für das hochgeladene Firmenlogo
        validators=[validate_image_extension]  # Validierung für erlaubte Bildformate
    )
    contact_person = models.ForeignKey(
        'Contact',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        verbose_name="Ansprechpartner"  # Klar für die Kontaktperson der Firma
    )
    prefix = models.CharField(
        max_length=5,
        blank=True,
        null=True,
        verbose_name="Auftragsnummer-Präfix",
        help_text="Beispiel: 'W-' für 'W-xxxxxxx'"
    )
    suffix = models.CharField(
        max_length=5,
        blank=True,
        null=True,
        verbose_name="Auftragsnummer-Suffix",
        help_text="Beispiel: '-XYZ' für  'xxxxxxx-XYZ'"
    )

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Firma"  # Singularform für das Modell
        verbose_name_plural = "Firmen"  # Pluralform für das Modell

class OrderCounter(GcAbstractModel):
    company = models.ForeignKey('Company', on_delete=models.CASCADE, verbose_name="Firma")
    year = models.PositiveIntegerField(verbose_name="Jahr")
    counter = models.PositiveIntegerField(default=0, verbose_name="Zähler")

    class Meta:
        unique_together = ('company', 'year')  # Sicherstellen, dass pro Firma und Jahr nur ein Zähler existiert
        verbose_name = "Auftragszähler"
        verbose_name_plural = "Auftragszähler"

class Contact(GcAbstractModel):
    first_name = models.CharField(
        max_length=100,
        verbose_name="Vorname"  # Klar und gebräuchlich für den Vornamen
    )
    last_name = models.CharField(
        max_length=100,
        verbose_name="Nachname"  # Klar und gebräuchlich für den Nachnamen
    )
    role = models.CharField(
        max_length=100,
        verbose_name="Rolle"  # Klar für die Rolle im Unternehmen, z.B. 'Vertriebsleiter', 'Support'
    )
    email = models.EmailField(
        verbose_name="E-Mail"  # Standard für das E-Mail-Feld
    )
    phone_number = PhoneNumberField(
        verbose_name="Telefonnummer"  # Deutliche Bezeichnung für die Telefonnummer
    )

    def __str__(self):
        return f"{self.first_name} {self.last_name} - {self.role}"

    class Meta:
        verbose_name = "Ansprechpartner"  # Singularform für das Modell
        verbose_name_plural = "Ansprechpartner"  # Pluralform für das Modell

class Bank(GcAbstractModel):
    company = models.ForeignKey(
        'Company',
        on_delete=models.CASCADE,
        related_name='banks',
        verbose_name="Firma"  # Klar und verständlich für die verknüpfte Firma
    )
    iban = models.CharField(
        max_length=34,
        verbose_name="IBAN"  # Standardbegriff für IBAN
    )
    bic = models.CharField(
        max_length=11,
        verbose_name="BIC/SWIFT"  # Standardbegriff für BIC oder SWIFT-Code
    )
    name = models.CharField(
        max_length=100,
        verbose_name="Bankname"  # Klar und präzise für den Namen der Bank
    )

    def __str__(self):
        return f"{self.company.name} Bank Details"

    class Meta:
        verbose_name = "Bank"  # Singularform für das Modell
        verbose_name_plural = "Banken"  # Pluralform für das Modell

class SocialMedia(GcAbstractModel):
    company = models.ForeignKey(
        'Company',
        on_delete=models.CASCADE,
        related_name='socials',
        verbose_name="Firma"  # Kurz und klar für die verknüpfte Firma
    )
    platform = models.CharField(
        max_length=100,
        verbose_name="Plattform"  # Klar für die Social-Media-Plattform, z.B. 'LinkedIn', 'Twitter'
    )
    url = models.URLField(
        verbose_name="URL"  # Standardbegriff für die URL der Plattform
    )

    def __str__(self):
        return f"{self.company.name} {self.platform} Account"

    class Meta:
        verbose_name = "Social Media"  # Singularform für das Modell
        verbose_name_plural = "Social Media"  # Pluralform für das Modell
