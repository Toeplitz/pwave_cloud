#!/bin/bash

kubectl run --image=pwave-image pwave-cloud --port=50051 --generator=run-pod/v1
kubectl get po

