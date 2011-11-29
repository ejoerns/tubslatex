PDFLIST=tubsposter_example.pdf scifiposter_example.pdf bulletin_example.pdf

all: $(PDFLIST) clean

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -f *.log *.aux *~ *.toc *.backup
