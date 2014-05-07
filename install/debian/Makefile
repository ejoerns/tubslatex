# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt deb-Datei ...
include ../../Makefile.include

VERSION := $(TUBSLATEX_FULLVERSION)
DEBVERSION := $(TUBSLATEX_DEBVERSION)

# Distribution the package is designed for
DIST = debian
# Version of deb package
DISTVERSION = 0$(DIST)4

# Installations-Verzeichnisse
INSTALLPATH = /usr/local/share/texmf
DOCPATH = /usr/share/doc/texlive-tubs
# Lintian Override Path
LINOVRDPATH = /usr/share/lintian/overrides

all: build deb

deb: copy
	$(ECHO) -n "Creating deb archive 'texlive-tubs_$(VERSION)$(DIST).deb'..."
	$(FAKEROOT) dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb $(SILENT)
	$(ECHO) -e '$(OK_STRING)'

copy: clean structure fetch

build:
	$(MAKE) -C $(INSTALL_RAW_DIR)

structure:
	$(ECHO) -n "Generating structure..."
	$(MKDIR) -p texlive-tubs
	$(MKDIR) -p texlive-tubs/DEBIAN
	$(MKDIR) -p texlive-tubs$(INSTALLPATH)
	$(MKDIR) -p texlive-tubs$(DOCPATH)
	$(MKDIR) -p texlive-tubs$(LINOVRDPATH)
	$(ECHO) -e '$(OK_STRING)'

fetch:
	$(ECHO) -n "Copying tex files..."
	$(CP) -r $(INSTALL_RAW_DIR)/tex texlive-tubs$(INSTALLPATH)/.
	$(CP) -r $(INSTALL_RAW_DIR)/doc texlive-tubs$(INSTALLPATH)/.
	$(CP) -r $(INSTALL_RAW_DIR)/fonts texlive-tubs$(INSTALLPATH)/.
	$(ECHO) -e '$(OK_STRING)'
	$(ECHO) -n "Creating deb archive files..."
	$(CAT) control.template | sed 's/CONTROLVERSION/$(DEBVERSION)-$(DISTVERSION)/g' | \
	$(SED) 's/INSTALLSIZE/'"`du -sk --apparent-size texlive-tubs | awk  '{print $$1}' `"'/g' > control
	$(CP) lintian-overrides-texlive-tubs texlive-tubs$(LINOVRDPATH)/texlive-tubs
	$(CP) control postinst prerm postrm templates texlive-tubs/DEBIAN/.
	chmod 755 texlive-tubs/DEBIAN/postinst texlive-tubs/DEBIAN/prerm texlive-tubs/DEBIAN/postrm
	chmod 644 texlive-tubs/DEBIAN/templates
	$(CP) changelog.Debian.template changelog.Debian
	$(CP) changelog.template changelog
	$(GZIP) -9f changelog
	$(GZIP) -9f changelog.Debian
	$(CP) copyright changelog.gz changelog.Debian.gz texlive-tubs$(DOCPATH)/.
	$(Q)find texlive-tubs/usr ! -type d -exec chmod 644 {} \;
	$(Q)find texlive-tubs/usr -type d -exec chmod 755 {} \;
	$(ECHO) -e '$(OK_STRING)'

cleantemp:
	$(RM) -f *~

clean: cleantemp
	$(ECHO) -en 'Cleaning...'
	$(RM) -rf texlive-tubs
	$(RM) -f *.otf
	$(RM) -f texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
	$(ECHO) -e '$(OK_STRING)'

install:
	$(ECHO) -en 'Installing...'
	sudo dpkg -i texlive-tubs_$(TUBSLATEX_VERSION)$(DIST).deb
