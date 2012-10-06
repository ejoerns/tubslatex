# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt cd-base-Pakete und Dokumentation
#
include ../../Makefile.include

# Dateien
STYLIST = tubscolors.sty tubslogo.sty
DTXLIST = tubscolors.dtx tubslogo.dtx
INSFILE = cd-base.ins

.PHONY: cleantemp clean

all: src doc cleantemp

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf)

$(STYLIST): $(DTXLIST)
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
	$(RM) -f *.sty
	$(ECHO) -e '$(OK_STRING)'
