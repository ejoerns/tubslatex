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

# Basis-Verzeichnis des Repositories
BASEDIR=../..

#Verzeichnisse aus denen Inhalte kopiert werden müssen
CDBASE_FETCHDIR = $(BASEDIR)/cd-base/src
BEAMER_FETCHDIR = $(BASEDIR)/beamer/src
LETTER_FETCHDIR = $(BASEDIR)/letter/src
NEXUS_FETCHDIR  = $(BASEDIR)/nexus
REPORT_FETCHDIR = $(BASEDIR)/report/src/build
DOC_FETCHDIR = $(BASEDIR)/doc

.PHONY: build copy-pre copy-generated copy-other copy-doc font clean zip

all: font build copy

build: build-src build-doc

build-src:
	$(MAKE) -C $(CDBASE_FETCHDIR) src
	$(MAKE) -C $(BEAMER_FETCHDIR) src
	$(MAKE) -C $(LETTER_FETCHDIR) src
	$(MAKE) -C $(NEXUS_FETCHDIR) src
	$(MAKE) -C $(BASEDIR)/report/src/ src

build-doc:
	$(MAKE) -C $(CDBASE_FETCHDIR) doc
	$(MAKE) -C $(BEAMER_FETCHDIR) doc
	$(MAKE) -C $(LETTER_FETCHDIR) doc
	$(MAKE) -C $(NEXUS_FETCHDIR) doc
	$(MAKE) -C $(BASEDIR)/report/src/ doc
	$(MAKE) -C $(DOC_FETCHDIR)
	
copy: copy-pre copy-generated copy-other copy-doc

copy-pre:
	$(MKDIR) -p tex/latex/tubs
	$(MKDIR) -p doc/latex/tubs


copy-generated:
	$(CP) -r $(NEXUS_FETCHDIR)/*.sty  tex/latex/tubs/.
	$(CP) -r $(CDBASE_FETCHDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(BEAMER_FETCHDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(LETTER_FETCHDIR)/*.cls tex/latex/tubs/.
	$(CP) -r $(LETTER_FETCHDIR)/*.lco tex/latex/tubs/.
	$(CP) -r $(REPORT_FETCHDIR)/*.cls tex/latex/tubs/.
	$(CP) -r $(REPORT_FETCHDIR)/*.sty tex/latex/tubs/.
	$(CP) -r $(REPORT_FETCHDIR)/*.clo tex/latex/tubs/.


# directly copy all other needed files
copy-other:
	$(CP) -r $(CDBASE_FETCHDIR)/logos tex/latex/tubs/.
	$(CP) -r $(BEAMER_FETCHDIR)/defaulttitlepicture.jpg tex/latex/tubs/.
	$(CP) -r $(NEXUS_FETCHDIR)/src/*.fd tex/latex/tubs/.


copy-doc:
	$(CP) -r $(NEXUS_FETCHDIR)/*.pdf  doc/latex/tubs/.
	$(CP) -r $(CDBASE_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(BEAMER_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(LETTER_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(REPORT_FETCHDIR)/../*.pdf doc/latex/tubs/.
	$(CP) -r $(DOC_FETCHDIR)/*.pdf    doc/latex/tubs/.

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
