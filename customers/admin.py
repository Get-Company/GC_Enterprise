# customers/admin.py
from django.contrib import admin

from core.admin import GcAbstractModelAdmin, GcAbstractTabularInline
from .models import Customer, CustomerContact


class CustomerContactInline(GcAbstractTabularInline):  # Alternativ: StackedInline für detailliertere Ansicht
    model = CustomerContact
    extra = 1

@admin.register(Customer)
class CustomerAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Adresseninformationen', {  # Gruppe für Adressdaten
            'fields': ('name', 'street', 'house_number', 'postal_code', 'city', 'country'),
            'classes': ('tab',)
        }),
        ('Kontaktdetails', {  # Gruppe für die Kontaktinformationen
            'fields': ('email', 'phone', 'vat_id'),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['name', 'email', 'phone', 'street', 'city', 'country', 'vat_id', 'created_at', 'updated_at']
    search_fields = ('name', 'email', 'phone', 'vat_id')
    list_filter = (
        'city',
        'country'
    )
    inlines = [CustomerContactInline]

