#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="6x"
ARCHS="x86_64 i386"

(echo MENU TITLE Scientific Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      BASEURL="http://nl.mirror.eurid.eu/scientific/${DISTRO}/${DISARCH}"
      INSTURL="$BASEURL/os"
      PXEURL="$BASEURL/os/images/pxeboot"
      KSURL="http://pixie.zylon.net/kickstart"
      echo LABEL Scientific${DISTRO}${DISARCH}
      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Interactive
      echo  KERNEL $PXEURL/vmlinuz
      echo  INITRD $PXEURL/initrd.img
      echo LABEL Scientific${DISTRO}${DISARCH}-ks-md0-sda1-sdb1
      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Kickstart /dev/md0 '(/dev/sd[ab]1)'
      echo  KERNEL $PXEURL/vmlinuz ks=$KSURL/Scientific/$DISTRO/$DISARCH/md0-sda1-sdb1.cfg ksdevice=eth0
      echo  INITRD $PXEURL/initrd.img
      echo LABEL Scientific${DISTRO}${DISARCH}-ks-sda1
      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Kickstart /dev/sda1
      echo  KERNEL $PXEURL/vmlinuz ks=$KSURL/Scientific/$DISTRO/$DISARCH/sda1.cfg ksdevice=eth0
      echo  INITRD $PXEURL/initrd.img
  done
  echo MENU END
done
) > ${DESTDIR}/scientific.cfg

