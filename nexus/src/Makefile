# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt nexus-Paket und Dokumentation
#

# Dateien
STYLIST = nexus.sty
DTXLIST = nexus.dtx
INSFILE = nexus.ins

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
	rm -f *~ *.aux *.log *.glo *.idx *.out *.backup

clean: cleantemp
	rm -f *.sty *.pdf
