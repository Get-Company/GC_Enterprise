from django.apps import AppConfig


class OrdersConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'orders'
    verbose_name = 'Projekte'

    def ready(self):
        import orders.signals  # Stellt sicher, dass das Signal geladen wird
