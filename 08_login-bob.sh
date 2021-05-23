#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200

#Login as bob who is in the engineering group
vault login -method=ldap username=bob password=P@ssword1

#bob can list the secrets
vault list secret

vault list secret/security

#bob cannot read secrets under security
vault read secret/security/my-secret || true

#bob can read engineering secrest
vault list secret/engineering 

vault read secret/engineering/my-application

#bob can write engineering secrets
vault write secret/engineering/new-application my-value=some-value
