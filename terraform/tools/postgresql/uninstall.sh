#!/bin/bash

NAMESPACE=$1

helm uninstall postgresql -n $NAMESPACE
kubectl delete secret -n $NAMESPACE postgresql-passwords-secret

# sleep 20
# kubectl delete ns $NAMESPACE