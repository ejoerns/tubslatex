# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt PDFs und entfernt anschliessend erzeugte Dateien,
# die nicht benoetigt werden
#

PDFLIST=tubslttr2_example.pdf

all: $(PDFLIST) clean

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -f *.log *.aux *~ *.toc
