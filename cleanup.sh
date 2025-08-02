#!/bin/bash

# Define container names
SQL_CONTAINER_NAME="devproj_sql"
JOOMLA_CONTAINER_NAME="devproj_joomla"

# Stop the containers if they are running
echo "Stopping containers..."
docker stop $SQL_CONTAINER_NAME
docker stop $JOOMLA_CONTAINER_NAME

# Remove the containers
echo "Removing containers..."
docker rm $SQL_CONTAINER_NAME
docker rm $JOOMLA_CONTAINER_NAME

# Remove all unused volumes
echo "Removing unused volumes..."
docker volume prune -f

# Remove all unused networks
echo "Removing unused networks..."
docker network prune -f

# Remove all images (optional, uncomment if needed)
echo "Removing all images..."
docker rmi $(docker images -q)

echo "Cleanup completed."
