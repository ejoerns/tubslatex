# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Kompiliert Testfiles
#
include ../../Makefile.include

TESTFILES = $(shell ls test*.tex)

.PHONY: clean cleantemp test $(TESTFILES)

test: $(TESTFILES:%.tex=%.pdf) cleantemp

%.pdf: %.tex
	$(ECHO) -n 'Running test $<...'
	@$(PDFLATEX) --interaction batchmode $< > /dev/null && echo '[OK]' || (echo '[FAILED]' && false)

cleantemp:
	$(RM) -f *.log *.aux *.out *~ *.toc

clean: cleantemp
	$(RM) -f *.pdf

