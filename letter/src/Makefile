# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt letter-Pakete und Dokumentation
#

# Dateien
GENLIST = tubs.lco tubslttr2.dtx
DTXLIST = tubslttr2.dtx
INSFILE = tubslttr.ins

# Programme
LATEX = latex
PDFLATEX = pdflatex

.PHONY: cleantemp clean

all: src doc

src: $(GENLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp

$(GENLIST): $(DTXLIST)
	$(LATEX) $(INSFILE)

%.pdf: %.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<

cleantemp:
	rm -f *~ *.aux *.log *.glo *.idx *.out *.backup

clean: cleantemp
	rm -f *.lco *.cls *.pdf
