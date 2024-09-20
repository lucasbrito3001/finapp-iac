#!/bin/bash

NAMESPACE=$1

helm uninstall grafana -n $NAMESPACE
kubectl delete secret -n $NAMESPACE grafana-admin-secret