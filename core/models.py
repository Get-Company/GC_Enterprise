from django.db import models
from django.contrib.auth.models import User
from django.db.models import PositiveIntegerField
from django.utils import timezone
from simple_history.models import HistoricalRecords


class GcAbstractModel(models.Model):
    created_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='created_%(class)s',
        verbose_name="Erstellt von",
        null=True,  # Erlaubt leere Werte, um später den aktuellen Benutzer zu setzen
        blank=True  # Macht es im Admin-Interface optional
    )
    updated_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        null=True,
        blank=True,
        related_name='updated_%(class)s',
        verbose_name="Aktualisiert von"
    )
    created_at = models.DateTimeField(
        verbose_name="Erstellt am",
        null=True,  # Erlaubt das Feld leer zu lassen
        blank=True  # Erlaubt das Feld im Admin-Formular leer zu lassen
    )
    updated_at = models.DateTimeField(
        verbose_name="Aktualisiert am",
        null=True,
        blank=True
    )


    # Historisierung hinzufügen
    history = HistoricalRecords(inherit=True)  # `inherit=True` aktiviert die Historie für alle abgeleiteten Klassen


    def save(self, *args, **kwargs):
        # Prüfe, ob der Benutzer im `_history_user`-Attribut gesetzt ist
        user = getattr(self, '_history_user', None)

        # Setze `created_by` und `created_at` nur beim ersten Speichern
        if not self.pk:
            if user:
                self.created_by = user
            if not self.created_at:
                self.created_at = timezone.now()

        # Setze `updated_by` und `updated_at` immer
        if user:
            self.updated_by = user
        self.updated_at = timezone.now()

        super().save(*args, **kwargs)  # Speichere das Objekt

    class Meta:
        abstract = True



