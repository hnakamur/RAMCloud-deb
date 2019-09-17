#!/bin/sh

export DOCKER_BUILDKIT=1

docker build -t ramcloud-deb \
  --secret id=gpgsiningkey,src=my-gpg-sign-subkey \
  --secret id=gpgpassphrase,src=my-gpg-passphrase.txt \
  --build-arg GPG_FINGERPRINT=$GPG_FINGERPRINT \
  .
