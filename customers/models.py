# customers/models.py
from company.models import Contact
from core.models import GcAbstractModel
from phonenumber_field.modelfields import PhoneNumberField
from django.db import models

class Customer(GcAbstractModel):
    name = models.CharField(
        max_length=200,
        verbose_name="Name"  # Klar und präzise für den Namen des Kunden
    )
    street = models.CharField(
        max_length=200,
        verbose_name="Straße"  # Klar und verständlich für die Straßenadresse
    )
    house_number = models.CharField(
        max_length=10,
        verbose_name="Hausnummer"  # Kurz und Eindeutig
    )
    postal_code = models.CharField(
        max_length=10,
        verbose_name="PLZ"  # Abkürzung für Postleitzahl (kurz und gebräuchlich)
    )
    city = models.CharField(
        max_length=100,
        verbose_name="Stadt"  # Standardbegriff für die Stadt
    )
    country = models.CharField(
        max_length=100,
        verbose_name="Land"  # Klare Bezeichnung für das Land
    )
    email = models.EmailField(
        verbose_name="E-Mail"  # Standard und verständlich
    )
    phone = PhoneNumberField(
        verbose_name="Telefon",  # Kurz und Klar
        region="DE"
    )
    vat_id = models.CharField(
        max_length=20,
        blank=True,
        null=True,
        verbose_name="USt-IdNr."  # Kurz für Umsatzsteuer-Identifikationsnummer
    )

    def get_default_contact(self):
        """Gibt den Standardkontakt des Kunden zurück oder False, falls kein Standardkontakt vorhanden ist."""
        default_contact = self.customer_contacts.filter(is_default=True).first()
        return default_contact if default_contact else False

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Kunde"  # Singularform für das Modell
        verbose_name_plural = "Kunden"  # Pluralform für das Modell


class CustomerContact(GcAbstractModel):
    customer = models.ForeignKey(
        Customer,
        on_delete=models.CASCADE,
        related_name="customer_contacts",
        verbose_name="Kunde"
    )
    name = models.CharField(max_length=100, verbose_name="Name")
    phone = models.CharField(max_length=20, verbose_name="Telefon", blank=True, null=True)
    email = models.EmailField(verbose_name="E-Mail", blank=True, null=True)
    position = models.CharField(max_length=100, verbose_name="Position", blank=True, null=True)  # Optional, Position des Kontakts
    is_default = models.BooleanField(default=False, verbose_name="Standardkontakt")

    def save(self, *args, **kwargs):
        # Wenn is_default auf True gesetzt ist, stelle sicher, dass kein anderer Kontakt für diesen Kunden Standard ist
        if self.is_default:
            CustomerContact.objects.filter(customer=self.customer, is_default=True).update(is_default=False)
        elif not CustomerContact.objects.filter(customer=self.customer, is_default=True).exists():
            # Wenn noch kein Standardkontakt für diesen Kunden vorhanden ist, setze diesen Kontakt als Standard
            self.is_default = True

        super().save(*args, **kwargs)
    def __str__(self):
        return f"{self.name} - {self.customer.name}"

    class Meta:
        verbose_name = "Kundenkontakt"
        verbose_name_plural = "Kundenkontakte"

