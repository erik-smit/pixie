#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="6 5"
ARCHS="x86_64 i386"

(echo MENU TITLE Fedora Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://ftp.tudelft.nl/centos.org/${DISTRO}/os/${DISARCH}/images/pxeboot"
      echo LABEL Fedora ${DISTRO} ${DISARCH}
      echo  KERNEL $URL/vmlinuz
      echo  INITRD $URL/initrd.img
  done
  echo MENU END
done
) > ${DESTDIR}/fedora.cfg

