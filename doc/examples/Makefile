# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Doku-Beispiele
#

EXAMPLELIST = backstyles.pdf titlestyles.pdf article_landscape.pdf leaflet.pdf example_vars.pdf posterstyle_standard.pdf posterstyle_scifi.pdf posterstyle_bulletin.pdf gausssegments.tex

PDFLATEX = pdflatex

all: $(EXAMPLELIST) cleantemp

%.pdf: %.tex
	$(PDFLATEX) $<
	$(PDFLATEX) $<

cleantemp:
	rm -f *.log *.aux *~ *.toc


clean: cleantemp
	rm -f $(EXAMPLELIST)

.PONY: clean cleantemp
