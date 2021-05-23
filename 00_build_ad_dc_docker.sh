#!/bin/sh

#build download and build samba domain controller by @fmstrat
mkdir -p ad-dc/builds
cd ad-dc/builds
git clone https://github.com/Fmstrat/samba-domain.git
cd samba-domain
docker build -t samba-domain .
docker scan samba-domain --accept-license
