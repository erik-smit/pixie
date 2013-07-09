#!/bin/bash

BASEURL=http://download.opensuse.org/distribution/
DESTDIR="../pxelinux.cfg"
DISTROS=`lftp $BASEURL -e 'ls;quit' 2> /dev/null | awk '{ print $5; }' | grep -v ^$`
ARCHS="x86_64 i386"

(echo MENU BEGIN OpenSUSE GNU/Linux
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      REPOURL="${BASEURL}/${DISTRO}/repo/oss"
      LOADURL="${BASEURL}/${DISTRO}/repo/oss/boot/${DISARCH}/loader"
      LINUX="${LOADURL}/linux"
      INITRD="${LOADURL}/initrd"

      if curl -I -s ${LINUX} | head -n1 | grep -qv "HTTP/1.1 200"; then
        continue
      fi

      echo LABEL OpenSUSE ${DISTRO} ${DISARCH}
      echo  LINUX ${LINUX} splash=silent vga=0x314 showopts install=${REPOURL}
      echo  INITRD ${INITRD}

#      echo  CONFIG ${LOADURL}/isolinux.cfg
#      echo  APPEND ${LOADURL}/
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/opensuse.cfg

