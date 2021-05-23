#!/bin/sh
#stop and remove vault containers if already running

docker stop vault-demo-vault
docker rm vault-demo-vault

docker stop samba-domain
docker rm samba-domain

docker network rm dev-network

