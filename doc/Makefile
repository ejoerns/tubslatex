# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Dokumentation und ruft Makefile fuer Doku-Beispiele auf
#
# Bekannte Probleme:
# - Aktualisierungen in examples fuehren nicht zur
#   Neukompilierung von tubsdocguide.
include ../Makefile.include

DOCFILE = tubsdocguide.pdf
EXAMPLEDIR = examples

# autovars
DOCSRC := $(shell ls *.tex)

.PHONY: clean cleantemp examples

all: examples $(DOCFILE)

$(DOCFILE): $(DOCSRC)
	$(PDFLATEX)  $(PDFLATEX_SILENT) $(basename $@ .pdf).tex $(SILENT)
	$(BIBTEX) $(basename $@ .pdf) $(SILENT)
	$(MAKEGLOSSARIES) $(basename $@ .pdf) $(SILENT)
	$(MAKEINDEX) general $(SILENT)
	$(MAKEINDEX) cmd $(SILENT)
	$(MAKEINDEX) option $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $(basename $@ .pdf).tex $(SILENT)

examples:
	$(MAKE) -C $(EXAMPLEDIR)

cleantemp:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean build files..."
	$(RM) -rf *.pdf
	$(ECHO) -e '$(OK_STRING)'
	$(MAKE) -C $(EXAMPLEDIR) clean
