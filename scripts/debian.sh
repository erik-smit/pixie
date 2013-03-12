#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="squeeze wheezy sid"
ARCHS="amd64 i386"

(echo MENU BEGIN Debian GNU/Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://ftp.nl.debian.org/debian/dists/${DISTRO}/main/installer-${DISARCH}/current/images/netboot"
      echo LABEL Debian ${DISTRO} ${DISARCH}
echo  CONFIG ${URL}/debian-installer/${DISARCH}/pxelinux.cfg/default
echo  APPEND ${URL}/
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/debian.cfg

