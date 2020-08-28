#!/bin/bash

echo "---------------------------------------------------------"
echo "Getting running containers"
echo "---------------------------------------------------------"
RUNNING_CONTAINERS=$(/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    ps -q --filter ancestor={{ practicum_image }}:1.0)

echo "---------------------------------------------------------"
echo "Stopping running containers"
echo "---------------------------------------------------------"
/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    container stop $RUNNING_CONTAINERS;:;

echo "---------------------------------------------------------"
echo "Searching containers that use image"
echo "---------------------------------------------------------"
CONTAINERS=$(/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    container ls -aq --filter ancestor={{ practicum_image }}:1.0)

echo "---------------------------------------------------------"
echo "Deleting containers that use image"
echo "---------------------------------------------------------"
/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    container rm $CONTAINERS;:;

echo "---------------------------------------------------------"
echo "Deleting image"
echo "---------------------------------------------------------"
/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    image rm {{ practicum_image }}:1.0;:;

echo "---------------------------------------------------------"
echo "Deleting local image"
echo "---------------------------------------------------------"
/usr/bin/docker image rm {{ practicum_image }}:1.0;:;

echo "---------------------------------------------------------"
echo "Building image"
echo "---------------------------------------------------------"
/usr/bin/docker build -f {{ practicum_path }}/Dockerfile -t {{ practicum_image }}:1.0 {{ practicum_path }}

echo "---------------------------------------------------------"
echo "Exporting image"
echo "---------------------------------------------------------"
/usr/bin/docker save {{ practicum_image }}:1.0 | /usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    load

echo "---------------------------------------------------------"
echo "Starting container"
echo "---------------------------------------------------------"
/usr/bin/docker \
    --tlsverify \
    --tlscacert=/etc/docker/ca.pem \
    --tlscert=/etc/docker/client-cert.pem \
    --tlskey=/etc/docker/client-key.pem \
    -H=10.0.3.20:2376 \
    run -d -p 80:80 {{ practicum_image }}:1.0 