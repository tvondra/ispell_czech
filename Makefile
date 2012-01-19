.SUFFIXES:
.SUFFIXES: .hash .dict .cat
.PRECIOUS: %.dict

LANGUAGE	= czech
ISPELLDIR	= $(TOPDIR)/usr/lib/ispell
CZECHSOURCES	= cat/hlavni.cat cat/nepravid.cat cat/nesklon.cat \
			cat/zajmena.cat cat/cislovk.cat cat/prislovc.cat \
			cat/predlozk.cat cat/spojky.cat cat/citoslov.cat \
			cat/castice.cat cat/zkratky.cat cat/nezaraz.cat \
			cat/krestni.cat cat/prijmeni.cat cat/narstjaz.cat \
			cat/obce.cat cat/geogr.cat cat/jmena.cat \
			cat/hovor.cat cat/chybej.cat

all: $(LANGUAGE).hash

czech.hash: czech.dict
	buildhash $(LANGUAGE).dict $(LANGUAGE).affix $(LANGUAGE).hash

install: hash
	[ -d $(ISPELLDIR) ] || mkdir -p $(ISPELLDIR)
	install -o 0 -g 0 -m 644 ./$(LANGUAGE).affix $(ISPELLDIR)
	install -o 0 -g 0 -m 644 ./$(LANGUAGE).hash $(ISPELLDIR)
	rm -f ./$(LANGUAGE).hash

czech.dict: $(CZECHSOURCES)
	rm -f czech.dict
	perl glob.p $(CZECHSOURCES) | LC_ALL=C sort -u > czech.dict

clean:
	rm -Rf *.hash *.dict