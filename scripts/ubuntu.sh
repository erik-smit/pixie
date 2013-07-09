#!/bin/bash

BASEURL="http://nl.archive.ubuntu.com/ubuntu/dists/"
DESTDIR="../pxelinux.cfg"
DISTROS=`lftp $BASEURL -e 'ls;quit' 2> /dev/null | awk '{ print $5; }' | grep -v -- - | grep -v ^$`
ARCHS="amd64 i386"

(echo MENU BEGIN Ubuntu GNU/Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="${BASEURL}/${DISTRO}/main/installer-${DISARCH}/current/images/netboot"
      CONFIGURL="${URL}/pxelinux.cfg/default"

      if curl -I -s ${CONFIGURL} | head -n1 | grep -qv "HTTP/1.1 200"; then
        continue
      fi

      echo LABEL Ubuntu ${DISTRO} ${DISARCH}
      echo  CONFIG ${CONFIGURL}
      echo  APPEND ${URL}/
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/ubuntu.cfg
