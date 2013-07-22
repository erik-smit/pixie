#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="6"
ARCHS="x86_64 i386"

(echo MENU TITLE PUIAS Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      BASEURL="http://nl.mirror.eurid.eu/puias/${DISTRO}/${DISARCH}"
      INSTURL="$BASEURL/os"
      PXEURL="$BASEURL/os/images/pxeboot"
      KSURL="http://pixie.zylon.net/kickstart"
      echo LABEL PUIAS${DISTRO}${DISARCH}
      echo  MENU LABEL PUIAS ${DISTRO} ${DISARCH} - Interactive
      echo  KERNEL $PXEURL/vmlinuz
      echo  INITRD $PXEURL/initrd.img
      echo LABEL PUIAS${DISTRO}${DISARCH}-ks-md0-sda1-sdb1
      echo  MENU LABEL PUIAS ${DISTRO} ${DISARCH} - Kickstart /dev/md0 '(/dev/sd[ab]1)'
      echo  KERNEL $PXEURL/vmlinuz ks=$KSURL/PUIAS/$DISTRO/$DISARCH/md0-sda1-sdb1.cfg ksdevice=eth0
      echo  INITRD $PXEURL/initrd.img
      echo LABEL PUIAS${DISTRO}${DISARCH}-ks-sda1
      echo  MENU LABEL PUIAS ${DISTRO} ${DISARCH} - Kickstart /dev/sda1
      echo  KERNEL $PXEURL/vmlinuz ks=$KSURL/PUIAS/$DISTRO/$DISARCH/sda1.cfg ksdevice=eth0
      echo  INITRD $PXEURL/initrd.img
  done
  echo MENU END
done
) > ${DESTDIR}/puias.cfg

