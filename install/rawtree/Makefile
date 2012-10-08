# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufruf von 'make' erzeugt Verzeichnisbaum
#   Aufruf von 'make copy' kopiert lediglich (bereits erzeugte) Dateien
#   Aufruf von 'make zip' erzeugt gepackte zip
#   Aufruf von 'make fontinstall' installiert Font-Dateien (zu Testzwecken)
#
include ../../Makefile.include

# Do not print commands
.SILENT: all

VERSION = $(TUBSLATEX_FULLVERSION)


.PHONY: build copy-pre copy-generated copy-other copy-doc font clean zip

all: font build copy

build: build-src build-doc

build-src:
	$(MAKE) -C $(CDBASE_DIR) src
	$(MAKE) -C $(BEAMER_DIR) src
	$(MAKE) -C $(LETTER_DIR) src
	$(MAKE) -C $(NEXUS_DIR) src
	$(MAKE) -C $(REPORT_DIR) src

build-doc:
	$(MAKE) -C $(CDBASE_DIR) doc
	$(MAKE) -C $(BEAMER_DIR) doc
	$(MAKE) -C $(LETTER_DIR) doc
	$(MAKE) -C $(NEXUS_DIR) doc
	$(MAKE) -C $(REPORT_DIR) doc
	$(MAKE) -C $(DOCUMENTATION_DIR)
	
copy: copy-pre copy-generated copy-other copy-doc

copy-pre:
	$(MKDIR) -p tex/latex/tubs
	$(MKDIR) -p doc/latex/tubs


copy-generated:
	$(ECHO) -en 'Copying generated files...'
	$(CP) -r $(NEXUS_BUILDDIR)/*.sty  tex/latex/tubs/.
	$(CP) -r $(CDBASE_BUILDDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(BEAMER_BUILDDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(LETTER_BUILDDIR)/*.cls tex/latex/tubs/.
	$(CP) -r $(LETTER_BUILDDIR)/*.lco tex/latex/tubs/.
	$(CP) -r $(REPORT_BUILDDIR)/*.cls tex/latex/tubs/.
	$(CP) -r $(REPORT_BUILDDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(REPORT_BUILDDIR)/*.clo tex/latex/tubs/.
	$(ECHO) -e '$(OK_STRING)'

# directly copy all other needed files
copy-other:
	$(ECHO) -en 'Copying other files...'
	$(CP) -r $(CDBASE_SRCDIR)/logos tex/latex/tubs/.
	$(CP) -r $(BEAMER_SRCDIR)/defaulttitlepicture.jpg tex/latex/tubs/.
	$(CP) -r $(NEXUS_SRCDIR)/*.fd tex/latex/tubs/.
	$(ECHO) -e '$(OK_STRING)'


copy-doc:
	$(ECHO) -en 'Copying documentation files...'
	$(CP) -r $(NEXUS_BUILDDIR)/*.pdf  doc/latex/tubs/.
	$(CP) -r $(CDBASE_BUILDDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(BEAMER_BUILDDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(LETTER_BUILDDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(REPORT_BUILDDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(DOCUMENTATION_BUILDDIR)/*.pdf    doc/latex/tubs/.
	$(ECHO) -e '$(OK_STRING)'

font:
	$(MAKE) -C $(BASEDIR)/nexus fonts
	$(ECHO) -en 'Copying font files...'
	$(CP) -r $(BASEDIR)/nexus/fonts .
	$(ECHO) -e '$(OK_STRING)'


# Lokale Font-Installtion zu Testzwecken
fontinstall:
	$(ECHO) -en 'Installing font files...'
	$(CP)  -r fonts ~/texmf/tex/.
	touch /etc/texmf/updmap.d/10local.cfg
	$(ECHO) "Using sys variants"
	/usr/bin/getnonfreefonts-sys --force --verbose arial-urw
	$(ECHO) "Adding map file for NexusProSans"
	/usr/bin/updmap-sys --nomkmap --nohash --enable Map=NexusProSans.map
	$(ECHO) "Adding map file for NexusProSerif"
	/usr/bin/updmap-sys --nomkmap --nohash --enable Map=NexusProSerif.map
	$(ECHO) "running updmap-sys"
	/usr/bin/updmap-sys
	$(ECHO) -e '$(OK_STRING)'

# zippen
zip: font build copy
	$(ECHO) -en 'Compressing all files...'
	$(ZIP) -r tubslatex_$(VERSION).tds.zip tex doc fonts $(SILENT)
	$(ECHO) -e '$(OK_STRING)'

cleantemp:
	$(ECHO) -en 'Cleaning temporary files...'
	$(RM) -f *~
	$(ECHO) -e '$(OK_STRING)'

# Aufräumen
clean: cleantemp
	$(ECHO) -en 'Cleaning generated files...'
	$(RM) -rf tex
	$(RM) -rf doc
	$(RM) -rf fonts
	$(RM) -rf tubslatex_$(VERSION).zip
	$(ECHO) -e '$(OK_STRING)'

# Kombilate löschen
rclean:
	$(ECHO) 'Cleaning recursive...'
	$(MAKE) -C $(CDBASE_FETCHDIR) clean
	$(MAKE) -C $(BEAMER_FETCHDIR) clean
	$(MAKE) -C $(LETTER_FETCHDIR) clean
	$(MAKE) -C $(NEXUS_FETCHDIR) clean
	$(MAKE) -C $(BASEDIR)/report/src/ clean
	$(MAKE) -C $(DOC_FETCHDIR) clean
