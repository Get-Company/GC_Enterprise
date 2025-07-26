from pprint import pprint

from django.contrib import admin
from django.contrib.admin import AdminSite
from django.contrib.auth.models import User, Group
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.admin import GroupAdmin as BaseGroupAdmin
from django.db import models
from django.http import HttpRequest
from django.shortcuts import redirect, render
from django.urls import reverse_lazy
from django.utils.translation import gettext_lazy as _
from import_export.admin import ImportExportModelAdmin, ExportMixin
from django import forms
from simple_history.admin import SimpleHistoryAdmin
from tinymce.widgets import TinyMCE
from unfold.admin import ModelAdmin, TabularInline, StackedInline
from unfold.contrib.import_export.forms import ImportForm, SelectableFieldsExportForm
from unfold.decorators import action

admin.site.unregister(User)
admin.site.unregister(Group)

@admin.register(User)
class UserAdmin(BaseUserAdmin, ModelAdmin):
    pass

@admin.register(Group)
class GroupAdmin(BaseGroupAdmin, ModelAdmin):
    pass

class GcAbstractCore:
    list_display = []

    formfield_overrides = {
        # Verwende TinyMCE für das `description`-Feld
        models.TextField: {'widget': TinyMCE()},
    }


class GcAbstractModelAdmin(GcAbstractCore, ModelAdmin, SimpleHistoryAdmin):
    # Verwaltungsdetails-Fieldset, das in jedem Child-Admin hinzugefügt wird
    base_fieldsets = (
        ('Verwaltungsdetails', {
            'fields': ('created_by', 'updated_by', 'created_at', 'updated_at'),
            'classes': ('tab',)  # Einklappbar
        }),
    )

    compressed_fields = True # Default: False
    list_filter_submit = True  # Submit button at the bottom of the filter
    warn_unsaved_form = True  # Default: False


    """ Template for custom actions on various places in the views """
    # Custom actions
    # actions_list = ["changelist_action"]  # Displayed above the results list
    # actions_row = ["changelist_row_action"]  # Displayed in a table row in results list
    # actions_detail = ["changeform_action"]  # Displayed at the top of for in object detail
    # actions_submit_line = ["changeform_submitline_action"]  # Displayed near save in object detail
    #
    # @action(
    #     description=_("Changelist action"),
    #     url_path="changelist-action",
    #     permissions=["changelist_action"])
    # def changelist_action(self, request: HttpRequest):
    #     # Drucke die Parameter des request-Objekts
    #     self.message_user(request, "Die Aktion 'changelist_action' wurde ausgeführt. Siehe print in console")
    #     # print("Request parameters in changelist_action:")
    #     # pprint(vars(request))
    #
    #     # Gib die gleiche Changelist-Seite zurück
    #     return redirect(
    #         reverse_lazy("admin:orders_document_changelist")
    #     )
    # def has_changelist_action_permission(self, request: HttpRequest):
    #     return True
    #
    # @action(
    #     description=_("Changelist row action"),
    #     permissions=["changelist_row_action"],
    #     url_path="changelist-row-action",
    #     attrs={"target": "_blank"}
    # )
    # def changelist_row_action(self, request: HttpRequest, object_id):
    #     self.message_user(request, f'Die Aktion "changelist_row_action" wurde ausgeführt. Die Id {object_id} wurde übermittelt')
    #     # print("Request parameters in changelist_row_action:")
    #     # pprint(vars(request))
    #     # Gib die gleiche Changelist-Seite zurück
    #     return redirect(
    #         reverse_lazy("admin:orders_document_changelist")
    #     )
    # def has_changelist_row_action_permission(self, request: HttpRequest, object_id = None):
    #     return True
    #
    # @action(
    #     description=_("Changeform action"),
    #     url_path="changeform-action",
    #     attrs={"target": "_blank"},
    #     permissions=["changeform_action"]
    # )
    # def changeform_action(self, request: HttpRequest, object_id: int):
    #     self.message_user(request, f'Die Aktion "changeform_action" wurde ausgeführt. Die Id {object_id} wurde übermittelt')
    #     # print("Request parameters in changeform_action:")
    #     # pprint(vars(request))
    #     # Gib die gleiche Changelist-Seite zurück
    #     return redirect(
    #         reverse_lazy("admin:orders_document_changelist")
    #     )
    # def has_changeform_action_permission(self, request: HttpRequest, object_id):
    #     return True
    #
    # @action(
    #     description=_("Changeform submitline action"),
    #     permissions=["changeform_submitline_action"]
    # )
    # def changeform_submitline_action(self, request: HttpRequest, obj):
    #     """
    #     If instance is modified in any way, it also needs to be saved, since this handler is invoked after instance is saved.
    #     """
    #     self.message_user(request, f'Die Aktion "changeform_submitline_action" wurde ausgeführt. Das Object {obj} wurde übermittelt')
    #     # print("Request parameters in changeform_submitline_action:")
    #     # pprint(vars(request))
    #     pprint(obj)
    #     # Gib die gleiche Changelist-Seite zurück
    #     return redirect(
    #         reverse_lazy("admin:orders_document_changelist")
    #     )
    # def has_changeform_submitline_action_permission(self, request: HttpRequest, object_id):
    #     return True

    # Benutzer setzen für `django-simple-history`
    def save_model(self, request, obj, form, change):
        obj._history_user = request.user  # Setze den Benutzer für die Historie
        super().save_model(request, obj, form, change)

    def save_formset(self, request, form, formset, change):
        for form in formset.forms:
            form.instance._history_user = request.user  # Setze den Benutzer in Inline-Formularen
        super().save_formset(request, form, formset, change)

    def get_fieldsets(self, request, obj=None):
        """Erweitert die Fieldsets um die base_fieldsets"""
        # Hole die Fieldsets des Child-Admin, falls vorhanden
        fieldsets = super().get_fieldsets(request, obj)

        # Kombiniere die Fieldsets des Child-Admins mit den Verwaltungsdetails
        return list(fieldsets) + list(self.base_fieldsets)


class GcAbstractTabularInline(GcAbstractCore, TabularInline):
    tab = True
    list_horizontal_scrollbar_top = True

    exclude = ('created_by', 'updated_by','created_at', 'updated_at')

    # Definiere eine `Callable`, um den vollen Namen anzuzeigen
    @admin.display(description="Bearbeitet von")
    def abstract__created_by__full_name(self, obj):
        if obj.created_by:
            return f"{obj.created_by.last_name} {obj.created_by.first_name}"
        return "Unbekannt"

    # Formfield Overrides für das Inline
    formfield_overrides = {
        models.TextField: {"widget": TinyMCE},
    }

class GcAbstractStackedInline(GcAbstractCore, StackedInline):
    tab = True

    exclude = ('created_by', 'updated_by','created_at', 'updated_at')


    # Definiere eine `Callable`, um den vollen Namen anzuzeigen
    @admin.display(description="Bearbeitet von")
    def abstract__created_by__full_name(self, obj):
        if obj.created_by:
            return f"{obj.created_by.last_name} {obj.created_by.first_name}"
        return "Unbekannt"

class GcAbstractImportExportModelAdmin(GcAbstractModelAdmin, ImportExportModelAdmin, ExportMixin):
    import_form_class = ImportForm
    export_form_class = SelectableFieldsExportForm

