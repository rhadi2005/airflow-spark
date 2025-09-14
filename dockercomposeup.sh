#!/bin/bash

source .env

echo "DOCKER_USERNAME=$(id -nu)" > .env.docker-compose
echo "DOCKER_USER=$(id -u):$(id -g)" >> .env.docker-compose
# echo "DOCKER_USER=$(id -u):1002" >> .env.docker-compose
echo "DOCKER_PORT=${DOCKER_PORT}" >> .env.docker-compose
echo "PORT=${PORT}" >> .env.docker-compose
echo "JUPYTER_PORT=${JUPYTER_PORT}" >> .env.docker-compose

echo "REDIS_PORT=${REDIS_PORT}" >> .env.docker-compose
echo "FLOWER_PORT=${FLOWER_PORT}" >> .env.docker-compose
echo "FLOWER_PORT=${FLOWER_PORT}" >> .env.docker-compose
echo "BATCHER_QUEUE=${BATCHER_QUEUE}" >> .env.docker-compose

echo "ORACLE_URL=${ORACLE_URL}" >> .env.docker-compose
echo "ORACLE_USERNAME=${ORACLE_USERNAME}" >> .env.docker-compose
echo "ORACLE_PASSWORD=${ORACLE_PASSWORD}" >> .env.docker-compose

echo "SPARK_LIB=${SPARK_LIB}" >> .env.docker-compose

echo "BASEDIR_HOST=${BASEDIR_HOST}" >> .env.docker-compose

echo "BASEDIR=${BASEDIR}" >> .env.docker-compose
echo "BASEDIR_STAGING=${BASEDIR_STAGING}" >> .env.docker-compose
echo "BASEDIR_BRONZE=${BASEDIR_BRONZE}" >> .env.docker-compose
echo "BASEDIR_SILVER=${BASEDIR_SILVER}" >> .env.docker-compose

echo "AIRFLOW_UID=${AIRFLOW_UID}" >> .env.docker-compose
echo "_AIRFLOW_WWW_USER_USERNAME=${_AIRFLOW_WWW_USER_USERNAME}" >> .env.docker-compose
echo "_AIRFLOW_WWW_USER_PASSWORD=${_AIRFLOW_WWW_USER_PASSWORD}" >> .env.docker-compose
echo "AIRFLOW_IMAGE_NAME=${AIRFLOW_IMAGE_NAME}" >> .env.docker-compose

export BASEDIR_HOST=${BASEDIR_HOST}

mkdir -p ${BASEDIR_HOST}
mkdir -p ${BASEDIR_HOST}/storeorder/staging
mkdir -p ${BASEDIR_HOST}/storeorder/bronze
mkdir -p ${BASEDIR_HOST}/storeorder/silver

chmod a+w -R ${BASEDIR_HOST} 2> /dev/null &

sudo docker compose --env-file .env.docker-compose -f docker-compose-airflow.yaml up ${1}

echo
# sudo docker compose ls | grep cgo
echo
# sudo docker ps | grep cgo
echo
# echo "sudo docker exec -it cgo-$(id -nu) bash"
echo

