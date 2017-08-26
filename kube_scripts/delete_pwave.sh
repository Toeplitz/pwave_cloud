#!/bin/bash

#kubectl delete po pwave-cloud
kubectl delete services pwave-cloud
kubectl delete deployment pwave-cloud
kubectl delete hpa pwave-cloud
kubectl delete rc pwave-cloud


kubectl get po
kubectl get services

