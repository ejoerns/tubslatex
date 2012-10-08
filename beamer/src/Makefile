# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt beamer-Pakete und Dokumentation
#
include ../../Makefile.include

# Dateien
STYLIST = beamercolorthemetubs.sty beamerfontthemetubs.sty beamerinnerthemetubs.sty beamerouterthemetubs.sty beamerthemetubs.sty tubsbeamersizes.sty
DTXLIST = beamercolorthemetubs.dtx beamerfontthemetubs.dtx beamerinnerthemetubs.dtx beamerouterthemetubs.dtx beamerthemetubs.dtx tubsbeamersizes.dtx
INSFILE = tubsbeamer.ins
TEXDOCFILE = tubsbeamerdoc.tex


.PHONY: cleantemp clean

all: src

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf) $(TEXDOCFILE:%.tex=%.pdf) cleantemp

$(TEXDOCFILE:%.tex=%.pdf):
	$(ECHO) -n 'Generating main documentation $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $(TEXDOCFILE) $(SILENT)
	$(MAKEINDEX) -q -s gind.ist -o tubsbeamerdoc.ind tubsbeamerdoc.idx $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $(TEXDOCFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

$(STYLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: %.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
# 	makeindex -s gind.ist -o $(basename $< .dtx).ind $(basename $< .dtx).idx
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -en 'Cleaning generated files...'
	$(RM) -f *~ *.aux *.log *.glo *.idx *.out *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -en 'Cleaning temporary files...'
	$(RM) -f *.sty *.pdf
	$(ECHO) -e '$(OK_STRING)'
