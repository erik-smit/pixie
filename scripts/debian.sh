#!/bin/bash

BASEURL="http://ftp.nl.debian.org/debian/dists/"
DESTDIR="../pxelinux.cfg"
DISTROS=`lftp $BASEURL -e 'ls;quit' 2> /dev/null | awk '{ print $3; }' | grep -v -- - | grep -v ^$`
ARCHS="amd64 i386"

(echo MENU TITLE Debian Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="${BASEURL}/${DISTRO}/main/installer-${DISARCH}/current/images/netboot"
      CONFIGURL="${URL}/pxelinux.cfg/default"

      if curl -I -s ${CONFIGURL} | head -n1 | grep -qv "HTTP/1.1 200"; then
        continue
      fi

      echo LABEL Debian ${DISTRO} ${DISARCH}
      echo  CONFIG ${CONFIGURL}
      echo  APPEND ${URL}/
  done
  echo MENU END
done
) > ${DESTDIR}/debian.cfg
