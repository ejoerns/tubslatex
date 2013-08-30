# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt PDFs und entfernt anschliessend erzeugte Dateien,
# die nicht benoetigt werden
#
include ../../Makefile.include

PDFLIST = beamer_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	$(ECHO) -n 'Compiling example file $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(RM) -f *.log *.aux *~ *.toc *.backup *.snm *.nav *.out *.vrb

clean: cleantemp
	$(RM) -f $(PDFLIST)

.PHONY: cleantemp clean
