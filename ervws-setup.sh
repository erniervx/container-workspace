#!/bin/bash
SYS_USER="sysadmin"
SYS_GROUP="sysadmin"
SYS_UID=505
CONTAINER_NAME="ervws"
SERVICE_NAME="ervws"
IMAGE_NAME="ervws:v1"
CONTAINER_DATA_VOL="/home/user/shared:/mnt"
CONTAINER_SOCK_VOL="/var/run/docker.sock:/var/run/docker.sock"
TZ_CONFIG="America/Lima"

# Generate docker-compose.yml file
sed -e "s/SERVICE_NAME/${SERVICE_NAME}/g" -e "s/CONTAINER_NAME/${CONTAINER_NAME}/g" -e "s/IMAGE_NAME/${IMAGE_NAME}/g" -e "s#CONTAINER_DATA_VOL#${CONTAINER_DATA_VOL}#g" -e "s#CONTAINER_SOCK_VOL#${CONTAINER_SOCK_VOL}#g" docker-compose-tpl.yml > docker-compose.yml

# Generate Dockerfile file
sed -e "s/SYS_USER/${SYS_USER}/g" -e "s/SYS_GROUP/${SYS_GROUP}/g" -e "s/SYS_UID/${SYS_UID}/g" -e "s#TZ_CONFIG#${TZ_CONFIG}#g" Dockerfile-tpl > Dockerfile

docker build -t ${IMAGE_NAME} .
docker-compose up -d
