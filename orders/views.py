from datetime import timedelta
from io import BytesIO

from django.db.models import Q
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, JsonResponse
from django.template.loader import render_to_string
from xhtml2pdf import pisa
from rest_framework import viewsets
from .models import Order, Task
from .serializers import OrderSerializer, TaskSerializer
import logging
class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

class TaskViewSet(viewsets.ModelViewSet):
    queryset = Task.objects.all()
    serializer_class = TaskSerializer


logger = logging.getLogger(__name__)

# Neue Logging-Test-View
def log_test(request):
    logger.debug("DEBUG-Log aus log_test wurde erzeugt.")
    logger.info("INFO-Log aus log_test wurde erzeugt.")
    logger.error("ERROR-Log aus log_test wurde erzeugt.")
    return HttpResponse("Logging-Test erfolgreich abgeschlossen!")

def dashboard_callback(request, context):
    # Beispielwerte für das Balkendiagramm
    chart_data = {
        "labels": ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"],
        "datasets": [
            {
                "label": "Example 1",
                "type": "line",
                "data": [13, 8, 15, 9, 14, 7, 22],
                "backgroundColor": "#f0abfc",
                "borderColor": "#f0abfc"
            },
            {
                "label": "Example 2",
                "data": [[1, 16], [1, 11], [1, 20], [1, 14], [1, 17], [1, 11], [1, 26]],
                "backgroundColor": "#9333ea"
            },
            {
                "label": "Example 3",
                "data": [[-1, -27], [-1, -20], [-1, -20], [-1, -14], [-1, -11], [-1, -20], [-1, -12]],
                "backgroundColor": "#f43f5e"
            }
        ]
    }
    context.update({
        "custom_variable": "value",
        "chart": chart_data  # Übergabe der Chart-Daten ans Template
    })

    return context
