## Environment Variables

### General MariaDB Configuration

- MYSQL_UID: The user ID for the MySQL service.
- MYSQL_GID: The group ID for the MySQL service.

### Backup DB Configuration

- BACKUP_DB: The name of the database to back up.
- BACKUP_DB_ROOT_PASSWORD: The root password for the MariaDB instance that is being backed up.

### Target Database Configuration

- TARGET_DB_HOST: The hostname or IP address of the target MariaDB database.
- TARGET_DB: The name of the target database where the backup will be restored.
- TARGET_DB_ROOT_PASSWORD: The root password for the target MariaDB database.

### Other Configuration

- TABLES: Specifies the tables to be included in the backup. This should be set even if not all tables are to be backed up. Should be a valid JSON string.
