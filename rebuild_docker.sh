#!/bin/bash
imageName=pwave_image
containerName=pwave_cloud

docker build -t $imageName -f Dockerfile  .

echo Delete old container...
docker rm -f $containerName

echo Run new container...
docker run -d -p 8080:50051 --name $containerName $imageName

