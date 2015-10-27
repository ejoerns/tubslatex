PDFLIST=tubsbook_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	$(ECHO) -n 'Compiling example file $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(RM) -f *.log *.aux *~ *.toc

clean: cleantemp
	$(RM) -f $(PDFLIST)

.PHONY: cleantemp clean

include ../../Makefile.include
