#!/bin/bash

DESTDIR="../pxelinux.cfg"
DISTROS="7"
ARCHS="x86_64"

(echo MENU TITLE RedHat Enterprise Linux;
for DISARCH in $ARCHS; do
  echo MENU BEGIN $DISARCH
    for DISTRO in $DISTROS; do
      BASEURL="http://mirror.oxilion.nl/rhel/beta/${DISTRO}/${DISARCH}"
      INSTURL="$BASEURL/os"
      PXEURL="$BASEURL/os/images/pxeboot"
      KSURL="http://pixie.zylon.net/kickstart"
      echo LABEL Scientific${DISTRO}${DISARCH}
      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Interactive
      echo  KERNEL $PXEURL/vmlinuz
      echo  INITRD $PXEURL/initrd.img
#      echo LABEL Scientific${DISTRO}${DISARCH}-ks-md0-sda1-sdb1
#      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Kickstart /dev/md0 '(/dev/sd[ab]1)'
#      echo  KERNEL $PXEURL/vmlinuz 
#      echo  INITRD $PXEURL/initrd.img
#      echo  APPEND ks=$KSURL/Scientific/$DISTRO/$DISARCH/md0-sda1-sdb1.cfg ksdevice=bootif
#      echo  IPAPPEND 2
#      echo LABEL Scientific${DISTRO}${DISARCH}-ks-sda1
#      echo  MENU LABEL Scientific ${DISTRO} ${DISARCH} - Kickstart /dev/sda1
#      echo  KERNEL $PXEURL/vmlinuz 
#      echo  INITRD $PXEURL/initrd.img
#      echo  APPEND ks=$KSURL/Scientific/$DISTRO/$DISARCH/sda1.cfg ksdevice=bootif
#      echo  IPAPPEND 2
  done
  echo MENU END
done
) > ${DESTDIR}/rhel7.cfg

