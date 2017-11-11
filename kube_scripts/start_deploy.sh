#!/bin/bash

#kubectl create -f pod.yaml --validate=false
#kubectl create -f gce-ingress-controller.yaml --validate=false
#kubectl create -f gce-tls-ingress.yaml --validate=false
#kubectl create -f pwave-cloud.yaml --validate=false

#kubectl create -f http-svc.yaml --validate=false
kubectl create -f pwave-cloud.yaml --validate=false

kubectl create -f nginx-tcp-ingress-configmap.yaml --validate=false
kubectl -n kube-system get configmap 
kubectl -n kube-system describe configmap nginx-tcp-ingress-configmap

kubectl create -f nginx-tcp-ingress-controller.yaml --validate=false
kubectl -n kube-system get rc
kubectl -n kube-system describe rc nginx-ingress-controller


#kubectl autoscale deployment pwave-cloud --cpu-percent=70 --min=1 --max=10
