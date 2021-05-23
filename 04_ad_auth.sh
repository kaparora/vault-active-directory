#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#disable ldap auth method if already enabled
vault auth disable ldap

#enable ldap auth method
vault auth enable ldap

#configure ldap auth method

vault write auth/ldap/config \
  binddn="cn=alice,cn=Users,dc=hashicorp,dc=example" \
  bindpass="P@ssword1" \
  url="ldap://samba-domain:389" \
  userdn="cn=Users,dc=hashicorp,dc=example" \
  userattr="sAMAccountName" \
  groupdn="cn=Users,dc=hashicorp,dc=example" \
  groupattr="cn"


