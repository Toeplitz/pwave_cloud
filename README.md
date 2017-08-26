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
kubeadm join --token e8a09f.c4dfbe610c1a2634 192.168.1.200:6443


# STARTING POD AND SERVICE
kubectl run --image=pwave-image pwave-cloud --port=50051 --generator=run-pod/v1
kubectl expose deployment pwave-cloud --port=8080 --name=pwave-http

kubectl describe services pwave-http

kubectl get po

kubectl exec -ti nginx-app-5jyvm -- /bin/sh    
kubectl logs -f nginx-app-zibvs


