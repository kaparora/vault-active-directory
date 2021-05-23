#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200

#login as Alice from security group
vault login -method=ldap username=alice password=P@ssword1
#disable if ad secrets engine is already enabled
vault secrets disable ad
#enable ad secrets engine
vault secrets enable ad

#configure the ad secrets engine, vault-reset use is a domain admin
vault write ad/config \
      binddn="cn=vault-reset,cn=Users,dc=hashicorp,dc=example" \
      bindpass=P@ssword1 \
      url=ldaps://samba-domain:636 \
      userdn="dc=hashicorp,dc=example" \
      insecure_tls=true

#setup checkout for priviledged users with the given names
#you can provide a ttl and max ttl
vault write ad/library/priviledge-user \
  service_account_names=privileged-account@hashicorp.example,privileged-account2@hashicorp.example \
  ttl=1h \
  max_ttl=8h \
  disable_check_in_enforcement=false

#checkout a priviledge user for ttl 30 min
vault write ad/library/priviledge-user/check-out ttl=30m

#check status of accounts part of priviledge users
vault read ad/library/priviledge-user/status

#checkout the second user
vault write -f ad/library/priviledge-user/check-out 
#try to checkout one more time, 
#should fail as the 2 available accounts are already checked out
vault write -f ad/library/priviledge-user/check-out || true
#check status of accounts
vault read ad/library/priviledge-user/status
#checkin one of the accounts
vault write -f ad/library/priviledge-user/check-in service_account_names=privileged-account@hashicorp.example
#checkin the last checked out account
vault write -f ad/library/priviledge-user/check-in