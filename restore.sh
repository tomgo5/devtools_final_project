#!/bin/bash

# Define variables
MYSQL_CONTAINER_NAME="devproj_sql"
JOOMLA_CONTAINER_NAME="devproj_joomla"
BACKUP_DIR="./backup_dir"  # Directory to store backups
MYSQL_DATABASE="joomla_db"
MYSQL_USER="joomla_user"
MYSQL_PASSWORD="secretpassword"
MYSQL_ROOT_PASSWORD="my-secret-pw"


# Restore the database
echo "Restoring database..."
docker exec "$MYSQL_CONTAINER_NAME" sh -c "exec mysqladmin -u$MYSQL_USER -p$MYSQL_PASSWORD create $MYSQL_DATABASE || true"
gunzip <"$BACKUP_DIR/my-joomla.backup.sql.gz" | docker exec -i "$MYSQL_CONTAINER_NAME" sh -c "exec mysql -h $MYSQL_CONTAINER_NAME -uroot -p$MYSQL_ROOT_PASSWORD --force $MYSQL_DATABASE"

if [ $? -eq 0 ]; then
    echo "Database restored successfully."
else
    echo "Failed to restore database."
fi


# Restore Joomla files
echo "Restoring Joomla files..."
docker cp $BACKUP_DIR/joomla_backup/. $JOOMLA_CONTAINER_NAME:/var/www/html

if [ $? -eq 0 ]; then
    echo "Joomla files restored successfully."
else
    echo "Failed to restore Joomla files."
fi


echo "Restore process completed."
