# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Testfiles
#

MAKE = make
PDFLATEX = pdflatex
BIBTEX = bibtex
MAKEGLOSSARIES = makeglossaries

.PHONY: clean cleantemp


TESTFILES := titlepageTest.pdf

test: $(TESTFILES)

%.pdf: %.tex
	$(PDFLATEX) $<

cleantemp:
	rm -f *.log *.aux *~ *.toc

clean: cleantemp
	rm -f *.pdf
	$(MAKE) -C $(EXAMPLEDIR) clean

