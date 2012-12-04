#!/bin/bash

DESTDIR="../pxelinux.cfg/generated"
DISTROS="6x"
ARCHS="x86_64 i386"

(echo MENU BEGIN Scientific;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      URL="http://nl.mirror.eurid.eu/scientific/${DISTRO}/${DISARCH}/os/images/pxeboot"
      echo LABEL Scientific ${DISTRO} ${DISARCH}
      echo  KERNEL $URL/vmlinuz
      echo  INITRD $URL/initrd.img
  done
  echo MENU END
done
echo MENU END
) > ${DESTDIR}/scientific.cfg

