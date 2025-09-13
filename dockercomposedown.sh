#!/bin/bash

sudo docker compose --env-file .env.docker-compose -f docker-compose-airflow.yaml down
