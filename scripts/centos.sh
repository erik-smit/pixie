#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="6 5"
ARCHS="x86_64 i386"

(
echo MENU TITLE CentOS

BASEURL="http://ftp.tudelft.nl/centos.org/7/os/x86_64"
PXEURL="${BASEURL}/images/pxeboot"
echo LABEL CentOS 7 x86_64
echo  KERNEL $PXEURL/vmlinuz
echo  INITRD $PXEURL/initrd.img
echo  APPEND inst.repo=$BASEURL

for DISARCH in $ARCHS; do
  for DISTRO in $DISTROS; do
    BASEURL="http://ftp.tudelft.nl/centos.org/${DISTRO}/os/${DISARCH}"
    PXEURL="${BASEURL}/images/pxeboot"
    echo LABEL CentOS ${DISTRO} ${DISARCH}
    echo  KERNEL $URL/vmlinuz
    echo  INITRD $URL/initrd.img
    echo  APPEND repo=$BASEURL
  done
done
) > ${DESTDIR}/centos.cfg

