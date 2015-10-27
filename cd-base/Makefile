# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt cd-base-Pakete und Dokumentation
#

SRCDIR = src
BUILDDIR = build


# Dateien
STYLIST = tubscolors.sty tubslogo.sty
DTXLIST = tubscolors.dtx tubslogo.dtx
INSFILE = cd-base.ins

# prefix with '$(SRCDIR)/'
#DTXLIST := $(patsubst %,$(SRCDIR)/%,$(DTXLIST))
#INSLIST := $(patsubst %,$(SRCDIR)/%,$(INSLIST))

.PHONY: cleantemp clean test

all: src cleantemp

src: $(STYLIST) cleantemp

doc: $(DTXLIST:%.dtx=%.pdf)

test:
	$(MAKE) -C test

$(STYLIST): versiondtx $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(ECHO) "pwd is: '$(shell pwd)'"
	$(ECHO) "INSFILE is: '$(INSFILE)'"
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: %.dtx
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

include ../Makefile.include
