#!/bin/bash

kubectl create -f pod.yaml --validate=false
#kubectl autoscale deployment pwave-cloud --cpu-percent=70 --min=1 --max=10
