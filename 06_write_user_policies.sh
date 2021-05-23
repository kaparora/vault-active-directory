#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#write security and engineering policy
vault policy write engineering vault/policies/engineering-policy.hcl
vault policy write security vault/policies/security-policy.hcl

#assign ldap group security the security policy
vault write auth/ldap/groups/security policies=security
#assign ldap group engineering the engineering policy
vault write auth/ldap/groups/engineering policies=engineering