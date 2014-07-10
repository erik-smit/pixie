#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="7 6 5"
ARCHS="x86_64 i386"

(echo MENU TITLE CentOS;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://ftp.tudelft.nl/centos.org/${DISTRO}/os/${DISARCH}/images/pxeboot"
      if ! wget --quiet --output-document=/dev/null $URL 2> /dev/null; then 
        continue; fi
      echo LABEL CentOS ${DISTRO} ${DISARCH}
      echo  KERNEL $URL/vmlinuz
      echo  INITRD $URL/initrd.img
  done
  echo MENU END
done
) > ${DESTDIR}/centos.cfg

