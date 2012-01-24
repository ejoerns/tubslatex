# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt deb-Datei ...

VERSION = undefined
DEBVERSION = undefined

# Distribution the package is designed for
DIST = debian
# Version of deb package
DISTVERSION = 0$(DIST)2

# Verzeichnisse
REPODIR = ../..
INSTALLPATH = usr/share/texmf-texlive

RAWTREE = $(REPODIR)/install/rawtree

all: build copy deb

copy: clean structure fetch

deb:
	fakeroot dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb

build:
	make -C $(RAWTREE)

structure:
	mkdir -p texlive-tubs
	mkdir -p texlive-tubs/DEBIAN
	mkdir -p texlive-tubs/$(INSTALLPATH)
	mkdir -p texlive-tubs/usr/share/doc/texlive-tubs

fetch:
	cp -r $(RAWTREE)/tex texlive-tubs/$(INSTALLPATH)/.
	cp -r $(RAWTREE)/doc texlive-tubs/$(INSTALLPATH)/.
	cp -r $(RAWTREE)/fonts texlive-tubs/$(INSTALLPATH)/.
	cat control.template | sed 's/CONTROLVERSION/$(DEBVERSION)-$(DISTVERSION)/g' | \
	sed 's/INSTALLSIZE/'"`du -sk --apparent-size texlive-tubs | awk  '{print $$1}' `"'/g' > control
	cp control postinst prerm postrm texlive-tubs/DEBIAN/.
	cp changelog.Debian.template changelog.Debian
	cp changelog.template changelog
	gzip -9f changelog
	gzip -9f changelog.Debian
	cp copyright changelog.gz changelog.Debian.gz texlive-tubs/usr/share/doc/texlive-tubs/.

clean:
	rm -rf texlive-tubs
	rm -f *.otf
	rm -f texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb

install:
	sudo dpkg -i texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
