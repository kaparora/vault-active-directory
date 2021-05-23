#!/bin/sh
#stop and remove samba domain controller containers if already running

docker stop samba-domain
docker rm samba-domain

docker network rm dev-network

#start samba domain controller 
docker network create dev-network

rm samba/config/smb.conf

location=$(pwd)

docker run --name samba-domain \
    --network dev-network \
    -p 389:389 -p 636:636 \
    -e DOMAIN=hashicorp.example \
    -e DOMAINPASS=P@ssword1 \
    -e INSECURELDAP="true" \
    -v ${location}/samba/config:/etc/samba/external \
    -v ${location}/samba/setup:/setup \
    samba-domain &