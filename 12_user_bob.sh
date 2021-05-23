#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
#login as user bob part of engineering
vault login -method=ldap username=bob password=P@ssword1
#engineering group can checkout the priviledge user
# and also access my-app password

#read my-app creds
vault read ad/creds/my-application

# check out the priviledge user
vault write -f ad/library/priviledge-user/check-out
