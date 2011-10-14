# This makefile is made to generate  documentation from all .dtx files
#
# Benutzung:
#   Aufruf von 'make' erzeugt Verzeichnisbaum
#   Aufruf von 'make zip' erzeugt gepackte zip
#

VERSION = 0.3-alpha1

# Basis-Verzeichnis des Repositories
BASEDIR=../..

#Verzeichnisse aus denen Inhalte kopiert werden müssen
CDBASE_FETCHDIR = $(BASEDIR)/cd-base/src
BEAMER_FETCHDIR = $(BASEDIR)/beamer/src
LETTER_FETCHDIR = $(BASEDIR)/letter/src
NEXUS_FETCHDIR  = $(BASEDIR)/nexus/src
REPORT_FETCHDIR = $(BASEDIR)/report/src/build
DOC_FETCHDIR = $(BASEDIR)/doc

.PHONY: build copy-pre copy-generated copy-other copy-doc font

all: buil copy font

build:
	make -C $(BASEDIR) generate

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
	cp -r $(REPORT_FETCHDIR)/*.pdf doc/latex/tubs/.
	cp -r $(DOC_FETCHDIR)/*.pdf    doc/latex/tubs/.

OTFDEFAULT= --warn-missing --encoding=texnansx --feature=kern --feature=liga --feature=lnum --force

# generate fonts
font:
	echo -e '\t -> Serif'
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
	echo -e '\t -> Sans Serif'
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Italic $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 

	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-BoldItalic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf

	echo -e 'Copying font files...'
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


# zippen
zip:
	zip -r tubslatex_$(VERSION).zip tex doc fonts

# Aufräumen
clean:
	rm -rf tex
	rm -rf doc
	rm -rf fonts
	rm -rf tubslatex_$(VERSION).zip
