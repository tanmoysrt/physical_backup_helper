#!/bin/bash


# Read the TABLES variable
TABLES_TO_RESTORE=($(jq -r '.[]' <<< "$TABLES"))  # For JSON array

# Output results for verification
echo "TABLES_TO_RESTORE: ${TABLES_TO_RESTORE[@]}"

# Create /backup directory
mkdir -p /backup

# Validate credentials of backup database
mysql -h "$BACKUP_DB_HOST" -u root -p"$BACKUP_DB_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Invalid credentials for backup database"
    exit 1
fi

# Validate credentials of target database
mysql -h "$TARGET_DB_HOST" -u root -p"$TARGET_DB_ROOT_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Invalid credentials for target database"
    exit 1
fi

# Dump each table or all databases based on ALL_TABLES
for table in "${TABLES_TO_RESTORE[@]}"; do
    echo "Copying table $table"
    mariadb-dump -u root -p"$BACKUP_DB_ROOT_PASSWORD" --databases "$BACKUP_DB" --tables $table | mysql -h "$TARGET_DB_HOST" -u root -p"$TARGET_DB_ROOT_PASSWORD" -D "$TARGET_DB"
done