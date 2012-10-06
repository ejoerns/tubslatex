# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt letter-Pakete und Dokumentation
#
include ../../Makefile.include

# Dateien
GENLIST = tubs.lco tubslttr2.cls
DTXLIST = tubslttr2.dtx
INSFILE = tubslttr.ins

.PHONY: cleantemp clean

all: src

src: $(GENLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp

$(GENLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: %.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -en 'Cleaning generated files...'
	$(RM) -f *~ *.aux *.log *.glo *.idx *.out *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -en 'Cleaning temporary files...'
	$(RM) -f *.lco *.cls *.pdf
	$(ECHO) -e '$(OK_STRING)'
