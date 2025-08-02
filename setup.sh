#!/bin/bash

# Define variables
NETWORK_NAME="devproj_network"
MYSQL_CONTAINER_NAME="devproj_sql"
JOOMLA_CONTAINER_NAME="devproj_joomla"
MYSQL_ROOT_PASSWORD="my-secret-pw"
MYSQL_DATABASE="joomla_db"
MYSQL_USER="joomla_user"
MYSQL_PASSWORD="secretpassword"

# Create a Docker network
echo "Creating Docker network: $NETWORK_NAME"
docker network create $NETWORK_NAME

# Run the MySQL container
echo "Starting MySQL container: $MYSQL_CONTAINER_NAME"
docker run --name $MYSQL_CONTAINER_NAME \
  --network $NETWORK_NAME \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_DATABASE=$MYSQL_DATABASE \
  -e MYSQL_USER=$MYSQL_USER \
  -e MYSQL_PASSWORD=$MYSQL_PASSWORD \
  -d \
  -p 3306:3306 \
  mysql:latest

# Check if the MySQL container is running
if [ "$(docker ps -q -f name=$MYSQL_CONTAINER_NAME)" ]; then
    echo "MySQL container is running successfully."
else
    echo "Failed to start MySQL container."
fi

# Run the Joomla container
echo "Starting Joomla container: $JOOMLA_CONTAINER_NAME"
docker run --name $JOOMLA_CONTAINER_NAME \
  --network $NETWORK_NAME \
  -e JOOMLA_DB_HOST=$MYSQL_CONTAINER_NAME\
  -e JOOMLA_DB_USER=$MYSQL_USER \
  -e JOOMLA_DB_PASSWORD=$MYSQL_PASSWORD \
  -e JOOMLA_DB_NAME=$MYSQL_DATABASE \
  -d \
  -p 8080:80 \
  joomla:latest

# Check if the Joomla container is running
if [ "$(docker ps -q -f name=$JOOMLA_CONTAINER_NAME)" ]; then
    echo "Joomla container is running successfully."
else
    echo "Failed to start Joomla container."
fi

echo "Setup completed: MySQL and Joomla are running."
