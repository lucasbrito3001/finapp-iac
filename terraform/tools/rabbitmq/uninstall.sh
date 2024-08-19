#!/bin/bash

NAMESPACE=rabbitmq

helm uninstall rabbitmq -n $NAMESPACE
kubectl delete secret -n $NAMESPACE rabbitmq-password-secret

# sleep 20
# kubectl delete ns $NAMESPACE