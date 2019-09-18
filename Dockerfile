# syntax = docker/dockerfile:experimental

FROM ubuntu:bionic

RUN apt-get update \
 && apt-get -y install \
      build-essential devscripts debhelper gnupg2 passwd \
 && groupadd -g 1000 build \
 && useradd -g build -u 1000 -s /bin/bash -m build

RUN apt-get -y install \
      libboost-dev \
      libboost-program-options-dev \
      libboost-filesystem-dev \
      libboost-system-dev \
      libpcre3-dev \
      libprotobuf-dev \
      libssl-dev \
      libzookeeper-mt-dev \
      openjdk-8-jdk-headless \
      protobuf-compiler \
      python

# NOTE: Keep .git directory as git command is executed in GNUmakefile.
# Do not include .git and debian directories into origin tarball.
# Include gtest directory (git submodule) into origin tarball.

COPY --chown=build:build RAMCloud.git.tar.gz gpg-passphrase /home/build/
RUN cd /home/build && tar xf RAMCloud.git.tar.gz
COPY --chown=build:build debian /home/build/RAMCloud/debian/
RUN chown -R build:build /home/build

USER build

WORKDIR /home/build/RAMCloud
RUN mv ../RAMCloud.git.tar.gz ../ramcloud_$(dpkg-parsechangelog -S version | cut -d - -f 1).orig.tar.gz \
 && dpkg-buildpackage -i -S -us -uc | tee ../ramcloud_$(dpkg-parsechangelog -S version)_build.log

RUN dpkg-buildpackage -b -us -uc 2>&1 | tee -a ../ramcloud_$(dpkg-parsechangelog -S version)_build.log

RUN lintian | tee -a ../ramcloud_$(dpkg-parsechangelog -S version)_build.log

ARG GPGKEY
RUN --mount=type=secret,id=gpgsiningkey,target=/home/build/.gpg-sign-subkey,uid=1000,gid=1000 \
    --mount=type=secret,id=gpgpassphrase,target=/home/build/.gpgpassphrase,uid=1000,gid=1000 \
 gpg --batch --pinentry-mode loopback \
     --passphrase-file /home/build/.gpgpassphrase \
     --import /home/build/.gpg-sign-subkey \
 && debsign -k$GPGKEY -p/home/build/gpg-passphrase | tee -a ../ramcloud_$(dpkg-parsechangelog -S version)_build.log \
 && rm -rf /home/build/.gnupg

RUN gzip -9 ../ramcloud_$(dpkg-parsechangelog -S version)_build.log

USER root
