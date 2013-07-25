#!/bin/bash

LFTPURL=http://mirror.lagis.at/pub/grml
GEOURL=http://download.grml.org
DESTDIR="../pxelinux.cfg"
ISOs=`lftp $LFTPURL -e 'ls;quit' 2> /dev/null | 
  awk '{ print $5; }' | 
  grep -v ^$ | 
  grep \\.iso$ |
  sort -t_ -k2 -r`
ARCHS="x86_64 i386"

(echo MENU TITLE GRML Linux
for ISO in $ISOs; do
#  HUMANNAME="GRML `echo ${ISO/\.iso/} | cut -d_ -f2` - `echo ${ISO/grml/} | cut -d- -f1`-bit"

  ISOURL="$GEOURL/$ISO"

  echo LABEL $ISO
#  echo  MENU LABEL $HUMANNAME
  echo  LINUX memdisk
  echo  INITRD $ISOURL
  echo  APPEND iso
done
) > ${DESTDIR}/grml.cfg
