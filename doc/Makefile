# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Dokumentation und ruft Makefile fuer Doku-Beispiele auf
#
# Bekannte Probleme:
# - Aktualisierungen in examples fuehren nicht zur
#   Neukompilierung von tubsdocguide.
include ../Makefile.include

DOCFILE = tubsdocguide.pdf
EXAMPLEDIR = ../examples
DOC_EXAMPLEDIR = examples

# autovars
DOCSRC := $(shell ls *.tex)

.PHONY: clean cleantemp examples

all: cleantemp examples $(DOCFILE)

$(DOCFILE): $(DOCSRC)
	$(ECHO) -n "Compiling documentation..."
	$(PDFLATEX)  $(PDFLATEX_SILENT) $(basename $@ .pdf).tex $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Running bibtex..."
	$(BIBTEX) $(basename $@ .pdf) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Running makeglossaries..."
	$(MAKEGLOSSARIES) $(basename $@ .pdf) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Generating index 'general'..."
	$(MAKEINDEX) -q general $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Generating index 'cmd'..."
	$(MAKEINDEX) -q cmd $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Generating index 'option'..."
	$(MAKEINDEX) -q option $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'
	$(ECHO) -n "Recompiling documentation twice..."
	$(PDFLATEX) $(PDFLATEX_SILENT) $(basename $@ .pdf).tex $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $(basename $@ .pdf).tex $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

examples:
	$(MAKE) -C $(EXAMPLEDIR)
	$(MAKE) -C $(DOC_EXAMPLEDIR)

cleantemp:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean build files..."
	$(RM) -rf *.pdf
	$(ECHO) -e '$(OK_STRING)'
	$(MAKE) -C $(EXAMPLEDIR) clean
