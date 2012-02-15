PDFLIST=tubsreprt_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

cleantemp:
	rm -f *.log *.aux *~ *.toc

clean: cleantemp
	rm -f $(PDFLIST)

.PHONY: cleantemp clean
