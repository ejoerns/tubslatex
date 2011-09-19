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

.PHONY: doc cleandoc movedoc

all: doc

ins: ins-pre ins-tex ins-post

ins-pre:
	mkdir -p build

ins-tex: $(INSLIST)

%.ins:
	echo "XXX" $@
	TEXINPUTS=`dirname $@`/:$$TEXINPUTS latex $@

ins-post:
	mkdir -p _tex/latex/tubs
	mv build/* .
	rm -r build
	mv *.sty *.cls *.lco *.clo _tex/latex/tubs/.
	rm *.log

font:

doc: $(DTXLIST) $(TUBSDOC) cleandoc movedoc

# Dokumentation aus dtx-Dateien
%.dtx:
	TEXINPUTS=`dirname $@`/:$$TEXINPUTS pdflatex $@
# Dokumentation aus tex-Dateien
%.tex:
	TEXINPUTS=../.:`dirname $@`/:$$TEXINPUTS pdflatex $@

# %.ins:
# 	latex $@
#	pdflatex $(BASEDIR)/cd-base/src/tubslogo.dtx
#	pdflatex $(BASEDIR)/cd-base/src/tubscolors.dtx

cleandoc:
	rm -f $(LATEXGEN)	

movedoc:
	mkdir -p _doc/latex/tubs
	mv *.pdf _doc/latex/tubs/.

clean:
	rm -f _tex
	rm -f _doc
