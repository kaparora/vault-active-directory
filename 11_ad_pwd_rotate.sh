#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
#login as alice from security roup
vault login -method=ldap username=alice password=P@ssword1
#setup my-app credentials for rotation by defining the role
#provide a ttl and max ttl
vault write ad/roles/my-application \
      service_account_name="my-application@hashicorp.example" \
      ttl=15s \
      max_ttl=30s
#read new creds
vault read ad/creds/my-application
#read new creds again, smae will be returned until the ttl is reached
vault read ad/creds/my-application
