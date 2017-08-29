#!/bin/bash

kubeadm reset

kubeadm init --config kubeadm.yaml
mkdir -p /home/ms/.kube 
cp /etc/kubernetes/admin.conf /home/ms/.kube/config 
chown ms:ms /home/ms/.kube/config     
#kubectl apply -f http://docs.projectcalico.org/v2.4/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl create secret docker-registry gcr-json-key --docker-server=https://gcr.io --docker-username=_json_key --docker-password="$(cat /home/ms/Downloads/pwave-cloud-249b1dc68b06.json)" --docker-email=balony@gmail.com
sleep 5
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gcr-json-key"}]}'



