# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt deb-Datei ...

VERSION = undefined
DIST = debian

# Verzeichnisse
REPODIR = ../..
INSTALLPATH = usr/share/texmf-texlive

RAWTREE = $(REPODIR)/install/rawtree

all: build copy deb

copy: clean structure fetch

deb:
	sudo dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb

build:
	make -C $(RAWTREE)

structure:
	mkdir -p texlive-tubs
	mkdir -p texlive-tubs/DEBIAN
	mkdir -p texlive-tubs/$(INSTALLPATH)

fetch:
	cp control postinst prerm postrm texlive-tubs/DEBIAN/.
	cp -r $(RAWTREE)/tex texlive-tubs/$(INSTALLPATH)/.
	cp -r $(RAWTREE)/doc texlive-tubs/$(INSTALLPATH)/.
	cp -r $(RAWTREE)/fonts texlive-tubs/$(INSTALLPATH)/.

clean:
	rm -rf texlive-tubs
	rm -f *.otf
	rm -f texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb

install:
	sudo dpkg -i texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
