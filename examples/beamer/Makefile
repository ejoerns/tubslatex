# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt PDFs und entfernt anschliessend erzeugte Dateien,
# die nicht benoetigt werden
#

PDFLIST = beamer_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

cleantemp:
	rm -f *.log *.aux *~ *.toc *.backup *.snm *.nav *.out *.vrb

clean: cleantemp
	rm -f $(PDFLIST)

.PHONY: cleantemp clean
