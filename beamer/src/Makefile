# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt beamer-Pakete und Dokumentation
#

# Dateien
STYLIST = beamercolorthemetubs.sty beamerfontthemetubs.sty beamerinnerthemetubs.sty beamerouterthemetubs.sty beamerthemetubs.sty tubsbeamersizes.sty
DTXLIST = beamercolorthemetubs.dtx beamerfontthemetubs.dtx beamerinnerthemetubs.dtx beamerouterthemetubs.dtx beamerthemetubs.dtx tubsbeamersizes.dtx
INSFILE = tubsbeamer.ins

# Programme
LATEX = latex
PDFLATEX = pdflatex

.PHONY: cleantemp clean

all: src doc

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp

$(STYLIST): $(DTXLIST)
	$(LATEX) $(INSFILE)

%.pdf: %.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<

cleantemp:
	rm -f *~ *.aux *.log *.glo *.idx *.out *.backup

clean: cleantemp
	rm -f *.sty *.pdf
