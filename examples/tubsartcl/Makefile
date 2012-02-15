PDFLIST=tubsartcl_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

cleantemp:
	rm -f *.log *.aux *~ *.toc

clean:
	rm -f $(PDFLIST)

.PHONY: cleantemp clean
