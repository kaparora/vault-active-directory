#!/bin/sh

#create users and groups for our AD tests
#user alice is part of security group
#use bob is part of engineering
docker exec samba-domain /setup/create-users-groups.sh