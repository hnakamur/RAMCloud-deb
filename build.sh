#!/bin/sh

set -e

if [ -z "$GPGKEY" ]; then
  echo "Please set GPGKEY environment variable" 1>&2
  exit 1
fi

export DOCKER_BUILDKIT=1

docker build -t ramcloud-deb \
  --secret id=gpgsiningkey,src=my-gpg-sign-subkey \
  --secret id=gpgpassphrase,src=my-gpg-passphrase.txt \
  --build-arg GPGKEY=$GPGKEY \
  .
