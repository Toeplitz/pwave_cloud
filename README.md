# pwave_cloud


# docker build . --no-cache -t pwave_cloud
docker build . -t pwave_cloud
docker run -d -p 8080:50051 pwave_cloud


REBUILDING:
./rebuild_docker.sh

LOGGING:
docker logs pwave_cloud -f



