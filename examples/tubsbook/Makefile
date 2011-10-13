PDFLIST=tubsbook_example.pdf

all: $(PDFLIST) clean

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

clean:
	rm -f *.log *.aux *~ *.toc
