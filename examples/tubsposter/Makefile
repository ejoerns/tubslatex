PDFLIST=tubsposter_example.pdf scifiposter_example.pdf bulletin_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

cleantemp:
	rm -f *.log *.aux *~ *.toc *.backup

clean: cleantemp
	rm -f $(PDFLIST)

.PHONY: cleantemp clean
