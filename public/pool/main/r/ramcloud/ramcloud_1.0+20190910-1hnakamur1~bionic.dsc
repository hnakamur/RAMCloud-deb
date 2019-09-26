Format: 3.0 (quilt)
Source: ramcloud
Binary: ramcloud-server, ramcloud-client, ramcloud-dev, libramcloud-java
Architecture: any
Version: 1.0+20190910-1hnakamur1~bionic
Maintainer: Hiroaki Nakamura <hnakamur@gmail.com>
Homepage: https://github.com/PlatformLab/RAMCloud
Standards-Version: 4.1.2
Build-Depends: debhelper (>= 11), dh-systemd, libboost-dev, libboost-program-options-dev, libboost-filesystem-dev, libboost-system-dev, libpcre3-dev, libprotobuf-dev, libssl-dev, libzookeeper-mt-dev, openjdk-8-jdk-headless, protobuf-compiler, python
Package-List:
 libramcloud-java deb database optional arch=any
 ramcloud-client deb database optional arch=any
 ramcloud-dev deb database optional arch=any
 ramcloud-server deb database optional arch=any
Checksums-Sha1:
 e6f8dc55e6a2747eea0570cbf4cc045eff76c296 19017541 ramcloud_1.0+20190910.orig.tar.gz
 1120e6035c99d2ca603c8d67bbefc857c0c71f01 3656 ramcloud_1.0+20190910-1hnakamur1~bionic.debian.tar.xz
Checksums-Sha256:
 ddebf05491c290c949a7420444c05aba99f3667be96cf3ba3b6e98334c5e63b2 19017541 ramcloud_1.0+20190910.orig.tar.gz
 c41530bd874d97647ede9a322b982aaa8e28f83ce4d2173a7ce3bceed49f8f83 3656 ramcloud_1.0+20190910-1hnakamur1~bionic.debian.tar.xz
Files:
 ae79f2e0ac19aab96d035e674249e549 19017541 ramcloud_1.0+20190910.orig.tar.gz
 0a329de91f2d367eb0c36f3b14b041d9 3656 ramcloud_1.0+20190910-1hnakamur1~bionic.debian.tar.xz
