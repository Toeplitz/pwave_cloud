# pwave_cloud

# VOLUME MANAGEMENT
docker volume create --name pwave_volume
docker volume ls
docker volume rm pwave_volume

# GET A SHELL IN DOCKER container
docker exec -i -t pwave_cloud /bin/bash 


docker volume inspect pwave_volume


# docker build . --no-cache -t pwave_cloud
docker build . -t pwave_cloud
docker run -d -p 8080:50051 pwave_cloud


REBUILDING:
./rebuild_docker.sh

LOGGING:
docker logs pwave_cloud -f


KUBERNETES:
# https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/


# ADMIN 
kubectl describe nodes dwarf

kubectl get pods --all-namespaces

# ON NODE
kubeadm join --token 079e5b.a38ecca88332c52d 192.168.1.200:6443



# STARTING POD AND SERVICE
kubectl run --image=pwave-image pwave-cloud --port=50051 --generator=run-pod/v1
kubectl expose deployment pwave-cloud --port=8080 --name=pwave-http

kubectl describe services pwave-http

kubectl get po

kubectl exec -ti nginx-app-5jyvm -- /bin/sh    
kubectl logs -f nginx-app-zibvs

# Guide for auth with GCR
https://ryaneschinger.com/blog/using-google-container-registry-gcr-with-minikube/

# TEst with echo server
 curl -d 'foo' 192.168.1.200:30301 -H 'Host: foo.bar.com'


sudo docker run -d -v select_vol:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server


https://buoyant.io/2017/04/19/a-service-mesh-for-kubernetes-part-ix-grpc-for-fun-and-profit/

