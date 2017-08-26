#!/bin/bash

kubectl run --image=gcr.io/pwave-cloud/github-toeplitz-pwave-cloud:5d6b6466995c0ec7695641b7c17885f576dd513a pwave-cloud --port=50051 
kubectl get po

