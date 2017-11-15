#!/bin/bash

kubectl create -f /home/ms/git/istio-0.2.12/install/kubernetes/istio.yaml
kubectl create -f /home/ms/git/istio-0.2.12/install/kubernetes/istio-initializer.yaml
kubectl apply -f /home/ms/git/istio-0.2.12/install/kubernetes/addons/prometheus.yaml
kubectl apply -f /home/ms/git/istio-0.2.12/install/kubernetes/addons/grafana.yaml

# From https://istio.io/docs/reference/config/traffic-rules/destination-policies.html
#istioctl create -f lb.yaml

## Istio dashboard
# kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &
#
# http://localhost:3000/dashboard/db/istio-dashboard 
#


