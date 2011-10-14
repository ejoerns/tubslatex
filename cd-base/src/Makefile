# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt cd-base Pakete und Dokumentation
#

# Dateien
STYLIST = tubscolors.sty tubslogo.sty
DTXLIST = tubscolors.dtx tubslogo.dtx
INSFILE = cd-base.ins

# Programme
LATEX = latex
PDFLATEX = pdflatex

.PHONY: cleantemp clean

all: src doc cleantemp

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf)

$(STYLIST): $(DTXLIST)
	$(LATEX) $(INSFILE)

%.pdf: %.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<

cleantemp:
	rm -f *.aux *.glo *.idx *.out *.backup

clean: cleantemp
	rm -f *~ *.sty
