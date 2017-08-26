#!/bin/bash
imageName=pwave-image
containerName=pwave-cloud

docker build -t $imageName -f Dockerfile  .

echo Delete old container...
docker rm -f $containerName

echo Run new container...
#docker run -d -p 8080:50051 --name $containerName $imageName
docker run -d -p 8080:50051 -it -v pwave_volume:/pwave_volume:ro --name $containerName $imageName

docker logs pwave-cloud -f

