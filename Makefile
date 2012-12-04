# Makefile for preprocessing gpxelinux.0 menu config files
# WB 2010-07-14

CPP=            /usr/bin/cpp
DEST=           ../pxelinux.cfg/
CFGNAME=        ${DEST}default
PRINTF=         /usr/bin/printf
RM=             /bin/rm
SED=            /bin/sed
SRCNAME=        menu

TAB!=           ${PRINTF} "\t"

${CFGNAME}:     ${SRCNAME}.src
	${CPP} -traditional-cpp ${SRCNAME}.src \
	| ${SED} -e '/^[ ${TAB}]*#/d' -e '/^$$/d' > ${CFGNAME}
	${CPP} -traditional-cpp local.src \
	| ${SED} -e '/^[ ${TAB}]*#/d' -e '/^$$/d' > ${DEST}local.cfg
