#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200

#login as Alice, she is part of security group
vault login -method=ldap username=alice password=P@ssword1

#Alice can read all secrets as per her (security team's) policy
vault list secret

vault list secret/security

vault read secret/security/my-secret

vault list secret/engineering

vault read secret/engineering/my-application