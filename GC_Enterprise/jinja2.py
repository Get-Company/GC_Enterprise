# jinja2.py
from datetime import datetime
import locale
from decimal import Decimal, ROUND_HALF_EVEN

from jinja2 import Environment
from django.contrib.staticfiles.storage import staticfiles_storage
from django.urls import reverse

def format_currency(value):
    """Format a number as currency in Euro with two decimals, thousands separator, and round half-even."""
    try:
        # Konvertiere in Decimal für exakte kaufmännische Rundung
        value = Decimal(value).quantize(Decimal("0.01"), rounding=ROUND_HALF_EVEN)

        # Formatierte Ausgabe mit Tausendertrennzeichen und zwei Dezimalstellen
        formatted_value = f"{value:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")
        return f"{formatted_value} €"
    except (ValueError, TypeError):
        # Falls das Formatieren fehlschlägt, gib den Wert ohne Formatierung zurück
        return f"{value} €"

def german_date(value, date_format="%A, den %d. %B %Y"):
    """
    Format a date in German locale.
    :param value: The datetime object to be formatted
    :param date_format: The format string for strftime
    :return: Formatted date string
    """
    # Set locale to German
    try:
        locale.setlocale(locale.LC_TIME, 'de_DE.UTF-8')
    except locale.Error:
        locale.setlocale(locale.LC_TIME, 'de_DE')

    # Sicherstellen, dass `value` ein datetime-Objekt ist
    if isinstance(value, datetime):  # oder datetime.datetime für Präzision
        return value.strftime(date_format)

    # Falls `value` kein datetime-Objekt ist, gib eine Fehlermeldung oder den Originalwert zurück
    return f"Invalid date: {value}" if value else ""

def environment(**options):
    env = Environment(**options)
    env.globals.update({
        'static': staticfiles_storage.url,
        'url': reverse,
    })
    # Registriere den neuen Filter
    env.filters['currency'] = format_currency
    env.filters['german_date'] = german_date
    return env