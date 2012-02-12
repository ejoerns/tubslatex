# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Dokumentation und ruft Makefile fuer Doku-Beispiele auf
#
# Bekannte Probleme:
# - Aktualisierungen in examples fuehren nicht zur
#   Neukompilierung von tubsdocguide.

DOCFILE = tubsdocguide.pdf
EXAMPLEDIR = examples

# autovars
DOCSRC := $(shell ls *.tex)

# programs
MAKE = make
PDFLATEX = pdflatex
BIBTEX = bibtex
MAKEGLOSSARIES = makeglossaries

.PHONY: clean cleantemp examples

all: examples $(DOCFILE)

$(DOCFILE): $(DOCSRC)
	$(PDFLATEX) $(basename $@ .pdf).tex
	bibtex $(basename $@ .pdf)
	makeglossaries $(basename $@ .pdf)
	makeindex general
	makeindex cmd
	makeindex option
	$(PDFLATEX) $(basename $@ .pdf).tex

examples:
	$(MAKE) -C $(EXAMPLEDIR)

cleantemp:
	rm -f *.log *.aux *~ *.toc

clean: cleantemp
	rm -f *.pdf
	$(MAKE) -C $(EXAMPLEDIR) clean
