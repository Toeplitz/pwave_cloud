#!/bin/bash

kubectl delete -f /home/ms/istio-0.2.12/install/kubernetes/istio.yaml
kubectl delete -f /home/ms/istio-0.2.12/install/kubernetes/istio-initializer.yaml
kubectl delete -f /home/ms/istio-0.2.12/install/kubernetes/addons/prometheus.yaml
kubectl delete -f /home/ms/istio-0.2.12/install/kubernetes/addons/grafana.yaml

#istioctl delete -f lb.yaml
