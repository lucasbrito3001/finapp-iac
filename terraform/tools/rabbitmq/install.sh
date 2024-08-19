#!/bin/bash

NAMESPACE=$1
RABBITMQ_PASSWORD=$2

if [ $# -ne 2 ]; then
  echo "Error to use the script, needs to pass the required arguments"
  echo "Usage: $0 <namespace> <rabbitmq_password>"
  exit 1
fi

kubectl create ns $NAMESPACE || true

kubectl create secret generic rabbitmq-password-secret -n $NAMESPACE --from-literal=rabbitmq-password=$RABBITMQ_PASSWORD 

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade rabbitmq --install -n $NAMESPACE -f ./yamls/values.yaml --version 14.6.5 bitnami/rabbitmq