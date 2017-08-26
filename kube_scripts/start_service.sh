#!/bin/bash

kubectl expose pod pwave-cloud --port=8080 --target-port=50051 --name pwave-http
kubectl describe services pwave-http

