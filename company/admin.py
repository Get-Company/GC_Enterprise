from django.contrib import admin

from core.admin import GcAbstractModelAdmin, GcAbstractTabularInline
from customers.models import CustomerContact
from .models import Company, Contact, Bank, SocialMedia, OrderCounter

class BankInline(GcAbstractTabularInline):
    model = Bank
    extra = 1

class SocialMediaInline(GcAbstractTabularInline):
    model = SocialMedia
    extra = 1

class OrderCounterInline(GcAbstractTabularInline):
    model = OrderCounter
    extra = 0
    fields = ('year', 'counter')  # Zeigt nur das Jahr und den Zähler an
    readonly_fields = ('year', 'counter')  # Setzt die Felder auf nur anzeigen (read-only)
    can_delete = False  # Verhindert das Löschen von Einträgen

    def has_add_permission(self, request, obj=None):
        # Verhindert das Hinzufügen von neuen OrderCounter-Einträgen über das Admin-Interface
        return False


@admin.register(Company)
class CompanyAdmin(GcAbstractModelAdmin):

    fieldsets = (
        ('Firmendetails', {  # Dieser Abschnitt bleibt standardmäßig geöffnet
            'fields': ('name', 'vat_id', 'court_register', 'court', 'street', 'postal_code', 'city', 'country')
        }),
        ('Kontaktdetails', {  # Kontaktinformationen und Ansprechpartner
            'fields': ('phone_number', 'email', 'website', 'fax_number', 'logo', 'signature', 'contact_person'),
            'classes': ('collapse',)  # Einklappbar
        }),
        ('Auftragsnummer Einstellungen', {  # Neue Sektion für Präfix und Suffix
            'fields': ('prefix', 'suffix'),
            'classes': ('collapse',)  # Einklappbar
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['name', 'vat_id', 'created_by', 'updated_by']
    search_fields = ('name', 'vat_id', 'city', 'country')
    inlines = [BankInline, SocialMediaInline, OrderCounterInline]

@admin.register(OrderCounter)
class OrderCounterAdmin(GcAbstractModelAdmin):
    list_display = GcAbstractModelAdmin.list_display + ['company', 'year', 'counter']  # Zeigt die Felder an
    search_fields = ('company__name', 'year')  # Ermöglicht die Suche nach Firma und Jahr
    list_filter = ('year', 'company')  # Filteroptionen für Firma und Jahr

@admin.register(Bank)
class BankAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Bankdetails', {  # Hauptdetails zur Bank
            'fields': ('company', 'name', 'iban', 'bic'),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['name', 'iban', 'bic']
    search_fields = ('name', 'iban', 'bic')

@admin.register(Contact)
class ContactAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Kontaktdetails', {  # Hauptdetails zum Ansprechpartner
            'fields': ('first_name', 'last_name', 'role', 'email', 'phone_number'),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['first_name', 'last_name', 'role', 'email', 'phone_number']
    search_fields = ('first_name', 'last_name', 'role')

@admin.register(SocialMedia)
class SocialMediaAdmin(GcAbstractModelAdmin):
    fieldsets = (
        ('Social Media Details', {  # Hauptdetails zur Social-Media-Plattform
            'fields': ('company', 'platform', 'url'),
            'classes': ('tab',)
        }),
    )
    list_display = GcAbstractModelAdmin.list_display + ['platform',]
    search_fields = ('platform',)

