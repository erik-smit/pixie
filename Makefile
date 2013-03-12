
GENSCRIPTS  = $(notdir $(wildcard scripts/*.sh))
SRCFILES    = $(wildcard *.src)
CPP=            /usr/bin/cpp
DEST=           ../pxelinux.cfg
PRINTF=         /usr/bin/printf
RM=             /bin/rm
SED=            /bin/sed
SHELL := $(SHELL) -e

vpath %.sh scripts

OBJECTS := $(addprefix $(DEST)/, $(patsubst %.sh,%.cfg,$(GENSCRIPTS)))
OBJECTS := $(OBJECTS) $(addprefix $(DEST)/, $(patsubst %.src,%.cfg,$(SRCFILES)))

TAB!=           ${PRINTF} "\t"

all: $(OBJECTS)

clean: 
	-rm -f $(OBJECTS)

$(DEST)/%.cfg: %.sh
	$<

$(DEST)/%.cfg: %.src
	${CPP} -traditional-cpp $^ \
	| ${SED} -e '/^[ ${TAB}]*#/d' -e '/^$$/d' > $@


