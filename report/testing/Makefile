# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Testfiles
#
include ../../Makefile.include

MAKE = make
PDFLATEX = pdflatex
BIBTEX = bibtex
MAKEGLOSSARIES = makeglossaries
NO_COLOR    = \x1b[0m
ERROR_COLOR = \x1b[31;01m
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)

.PHONY: clean cleantemp


# TESTFILES := titlepageTest.pdf
TESTFILES = $(shell ls *.tex)

test: $(TESTFILES:%.tex=%.pdf) cleantemp

%.pdf: %.tex
	$(ECHO) 'Generating $<...'
	@$(PDFLATEX) --interaction batchmode $< > /dev/null || ( echo '[FAILED]' || true )
# 	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	rm -f *.log *.aux *.out *~ *.toc

clean: cleantemp
	rm -f *.pdf

