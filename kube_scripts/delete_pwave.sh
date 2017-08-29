#!/bin/bash

#kubectl delete po pwave-cloud
#kubectl delete services pwave-cloud
#kubectl delete deployment pwave-cloud
#kubectl delete hpa pwave-cloud
#kubectl delete rc pwave-cloud
#kubectl delete ing pwave-ingress

#kubectl delete -f http-svc.yaml
#kubectl delete -f pwave-cloud.yaml
#kubectl delete -f gce-tls-ingress.yaml
#kubectl delete -f gce-ingress-controller.yaml

kubectl delete -f nginx-tcp-ingress-controller.yaml
kubectl delete -f nginx-tcp-ingress-configmap.yaml
#kubectl delete -f http-svc.yaml
kubectl delete -f pwave-cloud.yaml



kubectl get po
kubectl get services

