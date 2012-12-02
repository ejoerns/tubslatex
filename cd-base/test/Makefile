# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Kompiliert Testfiles
#
include ../../Makefile.include

.PHONY: clean cleantemp

TESTFILES = $(shell ls test*.tex)

test: $(TESTFILES:%.tex=%.pdf) cleantemp

%.pdf: %.tex
	$(ECHO) 'Running test $<...'
	@$(PDFLATEX) --interaction batchmode $< > /dev/null || ( echo '[FAILED]' || true )
# 	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	rm -f *.log *.aux *.out *~ *.toc

clean: cleantemp
	rm -f *.pdf

