#!/bin/bash

DESTDIR="../pxelinux.cfg/generated"
DISTROS="squeeze wheezy sid"
ARCHS="amd64 i386"

(echo MENU BEGIN Debian GNU/Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://ftp.nl.debian.org/debian/dists/${DISTRO}/main/installer-${DISARCH}/current/images/netboot/debian-installer/${DISARCH}/"
      echo LABEL Debian ${DISTRO} ${DISARCH}
echo  CONFIG ${URL}pxelinux.cfg/default
echo  APPEND ${URL}
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/debian.cfg

