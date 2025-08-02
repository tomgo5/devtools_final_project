#!/bin/bash

# Define variables
MYSQL_CONTAINER_NAME="devproj_sql"
JOOMLA_CONTAINER_NAME="devproj_joomla"
BACKUP_DIR="./backup_dir"  # Directory to store backups
MYSQL_DATABASE="joomla_db"
MYSQL_USER="joomla_user"
MYSQL_PASSWORD="secretpassword"
MYSQL_ROOT_PASSWORD="my-secret-pw"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup MySQL database
echo "Backing up MySQL database..."
docker exec $MYSQL_CONTAINER_NAME sh -c 'exec mysqldump --all-databases -uroot -p$MYSQL_ROOT_PASSWORD'|gzip > $BACKUP_DIR/my-joomla.backup.sql.gz

if [ $? -eq 0 ]; then
    echo "MySQL backup completed successfully."
else
    echo "MySQL backup failed."
fi

# Backup Joomla files
echo "Backing up Joomla files..."
docker cp $JOOMLA_CONTAINER_NAME:/var/www/html/. $BACKUP_DIR/joomla_backup


if [ $? -eq 0 ]; then
    echo "Joomla files backup completed successfully."
else
    echo "Joomla files backup failed."
fi


echo "Backup process completed. Backups are stored in $BACKUP_DIR."
