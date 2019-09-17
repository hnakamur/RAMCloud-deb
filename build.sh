#!/bin/sh

export DOCKER_BUILDKIT=1

docker build -t ramcloud-deb \
  --secret id=gpgsecretkey,src=my-gpg-secret-key \
  --secret id=gpgpassphrase,src=my-gpg-passphrase.txt \
  --build-arg GPG_FINGERPRINT=$GPG_FINGERPRINT \
  .
