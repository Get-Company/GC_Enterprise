from rest_framework import serializers
from .models import Order, Task

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = ['id', 'description', 'status', 'hours_worked', 'created_at', 'updated_at']


class OrderSerializer(serializers.ModelSerializer):
    tasks = TaskSerializer(many=True)  # Nesting tasks inside the order

    class Meta:
        model = Order
        fields = ['id', 'customer', 'company', 'description', 'tasks', 'start_date', 'end_date', 'created_at', 'updated_at']
