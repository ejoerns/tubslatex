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

VERSION = undefined

# Basis-Verzeichnis des Repositories
BASEDIR=../..

#Verzeichnisse aus denen Inhalte kopiert werden müssen
CDBASE_FETCHDIR = $(BASEDIR)/cd-base/src
BEAMER_FETCHDIR = $(BASEDIR)/beamer/src
LETTER_FETCHDIR = $(BASEDIR)/letter/src
NEXUS_FETCHDIR  = $(BASEDIR)/nexus/src
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
	$(CP) -r $(NEXUS_FETCHDIR)/*.fd tex/latex/tubs/.


copy-doc:
	$(CP) -r $(NEXUS_FETCHDIR)/*.pdf  doc/latex/tubs/.
	$(CP) -r $(CDBASE_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(BEAMER_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(LETTER_FETCHDIR)/*.pdf doc/latex/tubs/.
	$(CP) -r $(REPORT_FETCHDIR)/../*.pdf doc/latex/tubs/.
	$(CP) -r $(DOC_FETCHDIR)/*.pdf    doc/latex/tubs/.

OTFDEFAULT = --warn-missing --encoding=texnansx --feature=kern --feature=liga --feature=lnum --force
OTFDEFAULT += --tfm-directory=fonts/tfm/Nexus/
OTFDEFAULT += --vf-directory=fonts/vf/Nexus/ 
OTFDEFAULT += --type1-directory=fonts/type1/Nexus/
OTFDEFAULT += --encoding-directory=fonts/enc/dvips/Fontshop/
SERIF_OPTS = --map-file=fonts/map/dvips/NexusProSerif.map
SANS_OPTS = --map-file=fonts/map/dvips/NexusProSans.map
# TODO..
SERIF_FONTLIST = NexusSerifPro-Regular NexusSerifPro-Italic NexusSerifPro-Bold NexusSerifPro-BoldItalic
SANS_FONTLIST = NexusSansPro-Regular NexusSansPro-Italic NexusSansPro-Bold NexusSansPro-BoldItalic
FONTLIST = $(SERIF_FONTLIST) $(SANS_FONTLIST)

# generate fonts
font: # $(FONTLIST)
# 	$(ECHO) '$(OTFDEFAULT)'
	$(ECHO) -en 'Generating font files...'
	$(MKDIR) -p fonts/enc/dvips/Fontshop/
	$(MKDIR) -p fonts/map/dvips/Nexus/
	$(MKDIR) -p fonts/tfm/Nexus/
	$(MKDIR) -p fonts/vf/Nexus/
	$(MKDIR) -p fonts/type1/Nexus/
  # Serif
	$(CP) $(BASEDIR)/nexus/otf-src/*.otf .
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SERIF_OPTS) NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted --slant=.167  $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-Regular.otf $(SILENT)

	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular  $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SERIF_OPTS) NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted --slant=.167  $(OTFDEFAULT) $(SERIF_OPTS) NexusSerifPro-Bold.otf $(SILENT)
	
	# Sans Serif
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Regular  $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Italic $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SANS_OPTS) NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167  $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-Regular.otf $(SILENT)

	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular  $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SANS_OPTS) NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167  $(OTFDEFAULT) $(SANS_OPTS) NexusSansPro-Bold.otf $(SILENT)

	$(RM) *.otf

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

# Aufräumen
clean:
	$(ECHO) -en 'Cleaning...'
	$(RM) -rf tex
	$(RM) -rf doc
	$(RM) -rf fonts
	$(RM) -rf tubslatex_$(VERSION).zip
	$(RM) -f *.tfm *.vf *.pfb *.otf *.enc *.map
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
