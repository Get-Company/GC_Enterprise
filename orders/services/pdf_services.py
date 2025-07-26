from datetime import timedelta

from django.core.files.base import ContentFile
from django.core.files.storage import default_storage
from django.template.loader import render_to_string
from six import BytesIO
from xhtml2pdf import pisa


class PDFService:
    def create_pdf(self, order):
        print("PDFService.create_pdf", order)
        return True
        tasks = order.tasks.all()
        # Calculate sum for each task and total sum
        for task in tasks:
            # Netto-Betrag berechnen
            task.net_sum = round(task.hours_worked * order.hourly_rate, 2) if task.hours_worked else 0

            # Mehrwertsteuer berechnen
            if task.vat.rate > 0:
                task.vat_sum = round(task.net_sum * task.vat.rate / 100, 2)
            else:
                task.vat_sum = 0

            # Brutto-Betrag berechnen
            task.gross_sum = task.net_sum + task.vat_sum

        total_net_sum = sum(task.net_sum for task in tasks)
        total_vat = sum(task.vat_sum for task in tasks)
        total_gross_sum = total_net_sum + total_vat
        due_to = order.created_at + timedelta(days=30)

        # Render the HTML content for the PDF
        html_content = render_to_string('orders/order_pdf_template.html', {
            'order': order,
            'tasks': tasks,
            'total_net_sum': total_net_sum,
            'total_vat': total_vat,
            'total_gross_sum': total_gross_sum,
            'due_to': due_to
        })

        # Create a Bytes buffer
        pdf_buffer = BytesIO()

        # Create PDF from the HTML content
        pisa_status = pisa.CreatePDF(html_content, dest=pdf_buffer)

        if pisa_status.err:
            return None

        pdf_buffer.seek(0)
        customer_name_safe = order.customer.name.replace(' ', '_')
        file_name = f"{customer_name_safe}_{order.id}.pdf"
        file_content = ContentFile(pdf_buffer.getvalue())
        file_year = str(order.created_at.year)
        file_path = f'documents/{file_year}/{file_name}'

        # Correct path relative to MEDIA_ROOT
        relative_file_path = f'documents/{file_year}/{file_name}'

        # Save the file in the default storage
        saved_file_path = default_storage.save(relative_file_path, file_content)
        print(f"PDF saved in {saved_file_path}.")

        # Formatier-Methode für das Datum
        formatted_order_date = order.created_at.strftime("%d.%m.%Y")


        # Close the PDF buffer to release memory
        pdf_buffer.close()

        return relative_file_path