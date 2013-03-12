#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="quantal precise oneiric natty maverick lucid hardy"
ARCHS="amd64 i386"

(echo MENU BEGIN Ubuntu Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://nl.archive.ubuntu.com/ubuntu/dists/${DISTRO}/main/installer-${DISARCH}/current/images/netboot/"
      echo LABEL Ubuntu ${DISTRO} 
echo  CONFIG ${URL}pxelinux.cfg/default
echo  APPEND ${URL}
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/ubuntu.cfg

