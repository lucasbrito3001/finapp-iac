#!/bin/bash

NAMESPACE=$1
POSTGRES_USER_PASSWORD=$2
CUSTOM_USER_PASSWORD=$3

if [ $# -ne 3 ]; then
  echo "Error to use the script, needs to pass the required arguments"
  echo "Usage: $0 <namespace> <postgres_user_password> <custom_user_password>"
  exit 1
fi

POSTGRES_USER_PASSWORD_BASE64=$(echo $RABBITMQ_PASSWORD | base64 -w 0)
CUSTOM_USER_PASSWORD_BASE64=$(echo $CUSTOM_USER_PASSWORD | base64 -w 0)

kubectl create ns $NAMESPACE || true

kubectl create secret generic postgresql-passwords-secret -n $NAMESPACE \
  --from-literal=postgres-password=$POSTGRES_USER_PASSWORD_BASE64 \
  --from-literal=password=$CUSTOM_USER_PASSWORD_BASE64 \
  --from-literal=replication-password=$CUSTOM_USER_PASSWORD_BASE64

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade postgresql --install -n $NAMESPACE -f ./yamls/values.yaml --version 15.5.22 bitnami/postgresql