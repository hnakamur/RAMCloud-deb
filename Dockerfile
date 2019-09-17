# syntax = docker/dockerfile:experimental

FROM ubuntu:bionic

ARG GPG_FINGERPRINT

RUN apt-get update \
 && apt-get -y install \
      build-essential devscripts gnupg2 passwd \
 && groupadd -g 1000 build \
 && useradd -g build -u 1000 -m build

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

COPY --chown=build:build RAMCloud.git.tar.gz debian gpg-passphrase /home/build/

# NOTE: Keep .git directory as git command is executed in GNUmakefile.
# Do not include .git and debian directories into origin tarball.
# Include gtest directory (git submodule) into origin tarball.

USER build

RUN cd /home/build \
 && tar xf RAMCloud.git.tar.gz \
 && mv debian RAMCloud \
 && cd /home/build/RAMCloud \
 && upstream_version=$(dpkg-parsechangelog -S version | cut -d - -f 1) \
 && mv /home/build/RAMCloud.git.tar.gz /home/build/ramcloud_${upstream_version}.orig.tar.gz

RUN --mount=type=secret,id=gpgsecretkey,target=/home/build/.gpg-secret-key,uid=1000,gid=1000 \
    --mount=type=secret,id=gpgpassphrase,target=/home/build/.gpgpassphrase,uid=1000,gid=1000 \
 gpg --batch --pinentry-mode loopback \
     --passphrase-file /home/build/.gpgpassphrase \
     --import /home/build/.gpg-secret-key \
 && debuild --sign-key=$GPG_FINGERPRINT --sign-command=/home/build/gpg-passphrase \
 && gpg --batch --yes --delete-secret-keys $GPG_FINGERPRINT \
 && rm -rf /home/build/.gnupg

USER root
