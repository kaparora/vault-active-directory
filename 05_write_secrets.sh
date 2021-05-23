#!/bin/sh

set -e

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#disable secrets mount if already active
vault secrets disable secret

#enables kv secrets engine
vault secrets enable -version=1 -path=secret kv 

#write a secret under security
vault kv put secret/security/my-secret some-secret=s3cr3t

#write a secret under engineering
vault kv put secret/engineering/my-application my-value=4n0th3rs3cr3t