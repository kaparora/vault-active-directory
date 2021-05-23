#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#create  a policy for priviledge user check-in checkout
vault policy write priviledge-user vault/policies/priviledge-user-policy.hcl
# cretae a policy for password rotataion  for my-app's creds
vault policy write my-app vault/policies/my-app-policy.hcl

#assign the above policies to engineering ldap group
vault write auth/ldap/groups/engineering policies=engineering,priviledge-user,my-app