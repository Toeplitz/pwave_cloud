#!/bin/bash

kubeadm reset

kubeadm init --pod-network-cidr=192.168.1.0/24 --token-ttl 0
mkdir -p /home/ms/.kube 
cp /etc/kubernetes/admin.conf /home/ms/.kube/config 
chown ms:ms /home/ms/.kube/config     
#kubectl apply -f http://docs.projectcalico.org/v2.4/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"
kubectl taint nodes --all node-role.kubernetes.io/master-



