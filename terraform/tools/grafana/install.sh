#!/bin/bash

NAMESPACE=$1
GRAFANA_ADMIN_USER=$2
GRAFANA_ADMIN_PASSWORD=$3

if [ $# -ne 2 ]; then
  echo "Error to use the script, needs to pass the required arguments"
  echo "Usage: $0 <namespace> <grafana_admin_user> <grafana_admin_password>"
  exit 1
fi

kubectl create ns $NAMESPACE || true

kubectl create secret generic grafana-admin-secret \
  -n $NAMESPACE \
  --from-literal=admin-user=$GRAFANA_ADMIN_USER \
  --from-literal=admin-password=$GRAFANA_ADMIN_PASSWORD

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm upgrade grafana --install -n $NAMESPACE -f ./yamls/values.yaml --version 8.4.7 grafana/grafana