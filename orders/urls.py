from django.urls import path, include
from rest_framework.routers import DefaultRouter

from . import views
from .views import OrderViewSet, TaskViewSet

router = DefaultRouter()
router.register(r'orders', OrderViewSet)
router.register(r'tasks', TaskViewSet)

urlpatterns = [
    path('log-test/', views.log_test, name='log_test'),  # Neue Route zum Testen von Logs
    path('', include(router.urls)),  # Router-Routen
]
