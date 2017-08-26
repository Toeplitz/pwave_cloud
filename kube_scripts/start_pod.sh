#!/bin/bash

kubectl run --image=gcr.io/pwave-cloud/github-toeplitz-pwave-cloud:latest pwave-cloud --port=50051 
kubectl get po

