# signals.py
from django.db.models.signals import pre_save
from django.dispatch import receiver
from .models import Order

@receiver(pre_save, sender=Order)
def set_unique_nr_pre_save(sender, instance, **kwargs):
    # Prüfe, ob die `nr` bereits gesetzt ist, um eine erneute Generierung zu vermeiden
    if not instance.nr:
        instance.nr = instance.generate_unique_nr()
