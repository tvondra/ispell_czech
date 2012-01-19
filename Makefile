.SUFFIXES:
.SUFFIXES: .hash .a-z .cat
.PRECIOUS: %.a-z

LANGUAGE	= czech
ISPELLDIR	= $(TOPDIR)/usr/lib/ispell
CZECHSOURCES	= hlavni.cat nepravid.cat nesklon.cat zajmena.cat \
			cislovk.cat prislovc.cat predlozk.cat spojky.cat \
			citoslov.cat castice.cat zkratky.cat nezaraz.cat \
			krestni.cat prijmeni.cat narstjaz.cat \
			obce.cat geogr.cat jmena.cat hovor.cat chybej.cat

all: $(LANGUAGE).hash

.a-z.hash:
	buildhash $(LANGUAGE).a-z $(LANGUAGE).aff $(LANGUAGE).hash

install:
	[ -d $(ISPELLDIR) ] || mkdir -p $(ISPELLDIR)
	install -o 0 -g 0 -m 644 ./$(LANGUAGE).aff $(ISPELLDIR)
	install -o 0 -g 0 -m 644 ./$(LANGUAGE).hash $(ISPELLDIR)
	rm -f ./$(LANGUAGE).hash

czech.a-z: $(CZECHSOURCES)
	rm -f czech.a-z
	perl glob.p $(CZECHSOURCES) | LC_ALL=C sort -u > czech.a-z
