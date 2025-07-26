# Docker Setup for GC Enterprise

This guide explains how to set up the MariaDB and Adminer Docker environment for GC Enterprise.

## Prerequisites

- Docker and Docker Compose installed on your system
- Python environment with the required dependencies

## Setup Steps

### 1. Install Dependencies

First, install the required Python dependencies:

```bash
pip install -r requirements.txt
```

### 2. Start Docker Containers

Start the MariaDB and Adminer containers:

```bash
docker-compose up -d
```

This will start:
- MariaDB database server on port 3306
- Adminer (database management tool) on port 8080

### 3. Wait for Database Initialization

Wait a few seconds for the MariaDB database to initialize. You can check the logs with:

```bash
docker-compose logs mariadb
```

### 4. Run Migrations

Apply the database migrations to set up the schema:

```bash
python manage.py migrate
```

### 5. Import Database Backup

Import the database backup from the JSON fixture file:

```bash
python manage.py loaddata db_backup.json
```

### 6. Access the Application

Your Django application should now be connected to the MariaDB database. You can start the development server:

```bash
python manage.py runserver
```

### 7. Access Adminer

You can access Adminer at http://localhost:8080 with these credentials:
- System: MySQL
- Server: mariadb
- Username: gc_user
- Password: gc_password
- Database: gc_enterprise

## Reverting to SQLite (if needed)

If you need to revert to SQLite:

1. Update the .env file:
   - Change DB_ENGINE back to django.db.backends.sqlite3
   - Change DB_NAME back to db.sqlite3

2. Remove the OPTIONS section from the DATABASES configuration in settings.py

3. Stop the Docker containers:
   ```bash
   docker-compose down
   ```

4. Run migrations again to set up the SQLite database:
   ```bash
   python manage.py migrate
   ```

5. Import the data backup:
   ```bash
   python manage.py loaddata db_backup.json
   ```