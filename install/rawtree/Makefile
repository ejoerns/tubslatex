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

build:
	make -C $(CDBASE_FETCHDIR) src
	make -C $(BEAMER_FETCHDIR) src
	make -C $(LETTER_FETCHDIR)
	make -C $(NEXUS_FETCHDIR)
	make -C $(BASEDIR)/report/src/
	make -C $(DOC_FETCHDIR)

copy: copy-pre copy-generated copy-other copy-doc

copy-pre:
	mkdir -p tex/latex/tubs
	mkdir -p doc/latex/tubs


copy-generated:
	cp -r $(NEXUS_FETCHDIR)/*.sty  tex/latex/tubs/.
	cp -r $(CDBASE_FETCHDIR)/*.sty tex/latex/tubs/.
	cp -r $(BEAMER_FETCHDIR)/*.sty tex/latex/tubs/.
	cp -r $(LETTER_FETCHDIR)/*.cls tex/latex/tubs/.
	cp -r $(LETTER_FETCHDIR)/*.lco tex/latex/tubs/.
	cp -r $(REPORT_FETCHDIR)/*.cls tex/latex/tubs/.
	cp -r $(REPORT_FETCHDIR)/*.sty tex/latex/tubs/.
	cp -r $(REPORT_FETCHDIR)/*.clo tex/latex/tubs/.


# directly copy all other needed files
copy-other:
	cp -r $(CDBASE_FETCHDIR)/logos tex/latex/tubs/.
	cp -r $(BEAMER_FETCHDIR)/defaulttitlepicture.jpg tex/latex/tubs/.
	cp -r $(NEXUS_FETCHDIR)/*.fd tex/latex/tubs/.


copy-doc:
	cp -r $(NEXUS_FETCHDIR)/*.pdf  doc/latex/tubs/.
	cp -r $(CDBASE_FETCHDIR)/*.pdf doc/latex/tubs/.
	cp -r $(BEAMER_FETCHDIR)/*.pdf doc/latex/tubs/.
	cp -r $(LETTER_FETCHDIR)/*.pdf doc/latex/tubs/.
	cp -r $(REPORT_FETCHDIR)/../*.pdf doc/latex/tubs/.
	cp -r $(DOC_FETCHDIR)/*.pdf    doc/latex/tubs/.

OTFDEFAULT= --warn-missing --encoding=texnansx --feature=kern --feature=liga --feature=lnum --force

# generate fonts
font:
	$(ECHO) -en 'Generating font files...'
  # Serif
	cp $(BASEDIR)/nexus/otf-src/*.otf .
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted --slant=.167  $(OTFDEFAULT)  --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 

	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular  $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-BoldItalic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
	
	# Sans Serif
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Italic $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 

	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-BoldItalic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf
	$(ECHO) -e '$(OK_STRING)'

	$(ECHO) -en 'Copying font files...'
	mkdir -p fonts/enc/dvips/Fontshop/
	mv *.enc fonts/enc/dvips/Fontshop/

	mkdir -p fonts/map/dvips/Nexus/
	mv *.map fonts/map/dvips/Nexus/

	mkdir -p fonts/tfm/Nexus/
	mv *.tfm fonts/tfm/Nexus/

	mkdir -p fonts/vf/Nexus/
	mv *.vf  fonts/vf/Nexus/

	mkdir -p fonts/type1/Nexus/
	mv *.pfb fonts/type1/Nexus/

	rm *.otf
	
	$(ECHO) -e '$(OK_STRING)'

# Lokale Font-Installtion zu Testzwecken
fontinstall:
	$(ECHO) -en 'Installing font files...'
	cp  -r fonts ~/texmf/tex/.
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
	$(ZIP) -r tubslatex_$(VERSION).tds.zip tex doc fonts
	$(ECHO) -e '$(OK_STRING)'

# Aufräumen
clean:
	$(ECHO) -en 'Cleaning...'
	rm -rf tex
	rm -rf doc
	rm -rf fonts
	rm -rf tubslatex_$(VERSION).zip
	$(ECHO) -e '$(OK_STRING)'
	
rclean:
	$(ECHO) 'Cleaning recursive...'
	make -C $(CDBASE_FETCHDIR) clean
	make -C $(BEAMER_FETCHDIR) clean
	make -C $(LETTER_FETCHDIR) clean
	make -C $(NEXUS_FETCHDIR) clean
	make -C $(BASEDIR)/report/src/ clean
	make -C $(DOC_FETCHDIR) clean
