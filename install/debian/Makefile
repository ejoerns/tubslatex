# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt deb-Datei ...
include ../../Makefile.include

VERSION := $(TUBSLATEX_VERSION)
DEBVERSION := $(TUBSLATEX_DEBVERSION)

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
	$(ECHO) -n "Creating deb archive..."
	$(FAKEROOT) dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb $(SILENT)
	$(ECHO) -e '$(OK_STRING)'

build:
	$(MAKE) -C $(RAWTREE)

structure:
	$(ECHO) -n "Generating structure..."
	$(MKDIR) -p texlive-tubs
	$(MKDIR) -p texlive-tubs/DEBIAN
	$(MKDIR) -p texlive-tubs/$(INSTALLPATH)
	$(MKDIR) -p texlive-tubs/usr/share/doc/texlive-tubs
	$(ECHO) -e '$(OK_STRING)'

fetch:
	$(ECHO) -n "Copying tex files..."
	$(CP) -r $(RAWTREE)/tex texlive-tubs/$(INSTALLPATH)/.
	$(CP) -r $(RAWTREE)/doc texlive-tubs/$(INSTALLPATH)/.
	$(CP) -r $(RAWTREE)/fonts texlive-tubs/$(INSTALLPATH)/.
	$(ECHO) -e '$(OK_STRING)'
	$(ECHO) -n "Creating deb archive files..."
	$(CAT) control.template | sed 's/CONTROLVERSION/$(DEBVERSION)-$(DISTVERSION)/g' | \
	$(SED) 's/INSTALLSIZE/'"`du -sk --apparent-size texlive-tubs | awk  '{print $$1}' `"'/g' > control
	$(CP) control postinst prerm postrm texlive-tubs/DEBIAN/.
	$(CP) changelog.Debian.template changelog.Debian
	$(CP) changelog.template changelog
	$(GZIP) -9f changelog
	$(GZIP) -9f changelog.Debian
	$(CP) copyright changelog.gz changelog.Debian.gz texlive-tubs/usr/share/doc/texlive-tubs/.
	$(ECHO) -e '$(OK_STRING)'

clean:
	$(ECHO) -en 'Cleaning...'
	$(RM) -rf texlive-tubs
	$(RM) -f *.otf
	$(RM) -f texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
	$(ECHO) -e '$(OK_STRING)'

install:
	$(ECHO) -en 'Installing...'
	sudo dpkg -i texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
