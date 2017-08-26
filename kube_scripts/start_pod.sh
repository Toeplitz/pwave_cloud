#!/bin/bash

kubectl run --image=https://hub.docker.com/r/toeplitz/pwave_cloud pwave-cloud --port=50051 
kubectl get po

