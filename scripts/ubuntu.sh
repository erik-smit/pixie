#!/bin/bash

BASEURL="http://nl.archive.ubuntu.com/ubuntu/dists/"
DESTDIR="../pxelinux.cfg"
DISTROS=`lftp $BASEURL -e 'ls;quit' 2> /dev/null | awk '{ print $5; }' | grep -v ^$`
ARCHS="amd64 i386"

(echo MENU TITLE Ubuntu Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="${BASEURL}/${DISTRO}/main/installer-${DISARCH}/current/images"
      CONFIGURL="${URL}/pxelinux.cfg/default"

      # Ubuntu provides alternate netboot packages, based on kernel of later Ubuntu release, for hardware-support. Take latest.
      NETBOOTVARIANT=`lftp $URL -e 'ls;quit' 2> /dev/null | awk '{ print $5; }' | grep netboot | tail -n1`

      if ! `echo $NETBOOTVARIANT | grep -q netboot`; then
        continue
      fi

      URL="${URL}/${NETBOOTVARIANT}"
      echo LABEL Ubuntu ${DISTRO} ${DISARCH}
      echo  CONFIG ${CONFIGURL}
      echo  APPEND ${URL}/
  done
  echo MENU END
done
) > ${DESTDIR}/ubuntu.cfg
