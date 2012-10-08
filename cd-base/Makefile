# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt cd-base-Pakete und Dokumentation
#
include ../Makefile.include

SRCDIR = src
BUILDDIR = build


# Dateien
STYLIST = tubscolors.sty tubslogo.sty
DTXLIST = tubscolors.dtx tubslogo.dtx
INSFILE = cd-base.ins

# prefix with '$(SRCDIR)/'
DTXLIST := $(patsubst %,$(SRCDIR)/%,$(DTXLIST))
INSLIST := $(patsubst %,$(SRCDIR)/%,$(INSLIST))


.PHONY: cleantemp clean

all: src cleantemp

src: $(STYLIST)

doc: $(DTXLIST:$(SRCDIR)/%.dtx=%.pdf)

$(STYLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: $(SRCDIR)/%.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -en 'Cleaning temporary files...'
	$(RM) -f *~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -en 'Cleaning generated files...'
	$(RM) -f *.sty *.pdf
	$(ECHO) -e '$(OK_STRING)'
