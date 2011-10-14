# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt exe-Datei ...

VERSION = undefined

REPODIR = ../..
RAWTREE = $(REPODIR)/install/rawtree
MAKENSIS = wine ~/.wine/drive_c/Programme/NSIS/makensis.exe

all: build copy exe

copy: clean structure fetch

exe:
	cat tubslatexSetup_script.nsi | sed 's/REPLACEWITHVERSION/$(VERSION)/g' > tmp.nsi
	$(MAKENSIS) tmp.nsi
	rm tmp.nsi

build:
	make -C $(RAWTREE)

structure:
	mkdir -p data

fetch:
	mv $(RAWTREE)/tex data/.
	mv $(RAWTREE)/doc data/.
	mv $(RAWTREE)/fonts data/.

clean:
	rm -rf data

install:
	wine tubslatexSetup_$(VERSION).exe