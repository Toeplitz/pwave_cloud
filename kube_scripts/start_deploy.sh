#!/bin/bash

#kubectl create -f pod.yaml --validate=false
kubectl create -f gce-ingress-controller.yaml --validate=false
kubectl create -f gce-tls-ingress.yaml --validate=false
kubectl create -f pwave-cloud.yaml --validate=false
#kubectl autoscale deployment pwave-cloud --cpu-percent=70 --min=1 --max=10
