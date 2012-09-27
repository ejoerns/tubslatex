# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt beamer-Pakete und Dokumentation
#

# Dateien
STYLIST = beamercolorthemetubs.sty beamerfontthemetubs.sty beamerinnerthemetubs.sty beamerouterthemetubs.sty beamerthemetubs.sty tubsbeamersizes.sty
DTXLIST = beamercolorthemetubs.dtx beamerfontthemetubs.dtx beamerinnerthemetubs.dtx beamerouterthemetubs.dtx beamerthemetubs.dtx tubsbeamersizes.dtx
INSFILE = tubsbeamer.ins
TEXDOCFILE = tubsbeamerdoc.tex

# Programme
LATEX = latex
PDFLATEX = pdflatex

.PHONY: cleantemp clean

all: src doc

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp
	$(PDFLATEX) $(TEXDOCFILE)
	makeindex -s gind.ist -o tubsbeamerdoc.ind tubsbeamerdoc.idx	
	$(PDFLATEX) $(TEXDOCFILE)

$(STYLIST): $(DTXLIST)
	$(LATEX) $(INSFILE)

%.pdf: %.dtx
	$(PDFLATEX) $<
# 	makeindex -s gind.ist -o $(basename $< .dtx).ind $(basename $< .dtx).idx
	$(PDFLATEX) $<

cleantemp:
	rm -f *~ *.aux *.log *.glo *.idx *.out *.backup

clean: cleantemp
	rm -f *.sty *.pdf
