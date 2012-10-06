# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt nexus-Paket und Dokumentation
#
include ../../Makefile.include

# Dateien
STYLIST = nexus.sty
DTXLIST = nexus.dtx
INSFILE = nexus.ins


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
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean build files..."
	$(RM) -rf *.sty *.pdf
	$(ECHO) -e '$(OK_STRING)'
