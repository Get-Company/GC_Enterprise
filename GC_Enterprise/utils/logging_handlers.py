import logging
from datetime import datetime
import os

class DailyFileHandler(logging.FileHandler):
    def __init__(self, log_dir, *args, **kwargs):
        self.log_dir = log_dir
        self.current_date = datetime.now().strftime('%Y-%m-%d')
        log_file = self._get_log_file()
        super().__init__(log_file, *args, **kwargs)

    def _get_log_file(self):
        """Generiere den Dateipfad basierend auf dem aktuellen Datum."""
        return os.path.join(self.log_dir, f"log_{self.current_date}.log")

    def emit(self, record):
        """Aktualisiere den Dateinamen, wenn sich das Datum geändert hat."""
        new_date = datetime.now().strftime('%Y-%m-%d')
        if new_date != self.current_date:
            self.current_date = new_date
            self.baseFilename = self._get_log_file()
        super().emit(record)
