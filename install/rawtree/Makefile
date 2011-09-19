# This makefile is made to generate  documentation from all .dtx files

BASEDIR=../..
LATEXGEN = *.aux *.log *.ins *.idx *.out *.glo *.toc

DTXLIST = $(BASEDIR)/cd-base/src/*.dtx
DTXLIST += $(BASEDIR)/report/src/*.dtx
DTXLIST += $(BASEDIR)/letter/src/*.dtx
DTXLIST += $(BASEDIR)/beamer/src/*.dtx
DTXLIST += $(BASEDIR)/nexus/src/*.dtx
# tubs-Dokumentation
TUBSDOC = $(BASEDIR)/doc/tubsdocguide.tex
# ins-Dateien
INSLIST = $(BASEDIR)/cd-base/src/cd-base.ins
INSLIST += $(BASEDIR)/report/src/tubs.ins
INSLIST += $(BASEDIR)/letter/src/tubslttr.ins
INSLIST += $(BASEDIR)/beamer/src/tubsbeamer.ins
INSLIST += $(BASEDIR)/nexus/src/nexus.ins

.PHONY: doc doc-clean doc-move

all: ins copy font doc


# generate .sty .cls and other files
ins: ins-pre ins-tex ins-post

ins-pre:
	mkdir -p build

ins-tex: $(INSLIST)

%.ins:
	echo "XXX" $@
	TEXINPUTS=`dirname $@`/:$$TEXINPUTS latex $@

ins-post:
	mkdir -p tex/latex/tubs
	mv build/* .
	rm -r build
	mv *.sty *.cls *.lco *.clo tex/latex/tubs/.
	rm *.log


# directly copy all other needed files
copy:
	mkdir -p tex/latex/tubs
	cp -r $(BASEDIR)/cd-base/src/TUBraunschweig-rgb.pdf tex/latex/tubs/.
	cp -r $(BASEDIR)/cd-base/src/logos tex/latex/tubs/.
	cp -r $(BASEDIR)/beamer/src/defaulttitlepicture.jpg tex/latex/tubs/.
	cp -r $(BASEDIR)/nexus/src/*.fd tex/latex/tubs/.


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


# generate doc
doc: $(DTXLIST) $(TUBSDOC) doc-clean doc-move
# Dokumentation aus dtx-Dateien
%.dtx:
	TEXINPUTS=`dirname $@`/:$$TEXINPUTS pdflatex $@
# Dokumentation aus tex-Dateien
%.tex:
	TEXINPUTS=../.:`dirname $@`/:$$TEXINPUTS pdflatex $@


doc-clean:
	rm -f $(LATEXGEN)	

doc-move:
	mkdir -p doc/latex/tubs
	mv *.pdf doc/latex/tubs/.


# Aufräumen
clean:
	rm -rf tex
	rm -rf doc
	rm -rf fonts
