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



