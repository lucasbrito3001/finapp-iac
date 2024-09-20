#!/bin/bash

# create istio namespace
kubectl create ns istio-system

# add istio helm repository
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

# install istio base and istiod
helm upgrade --install istio-base istio/base -n istio-system --create-namespace --set defaultRevision=default
helm upgrade --install istiod istio/istiod -n istio-system --wait

# install grafana
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/addons/grafana.yaml

# istall prometheus
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/addons/prometheus.yaml
