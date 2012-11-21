# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt verschiedene tubslatex-Klassen, -Pakete und weitere Dateien,
# sowie Dokumentation
#
include ../Makefile.include

SRCDIR = src
BUILDDIR = build

# Dateien
CLSLIST := tubsartcl.cls tubsreprt.cls tubsbook.cls tubsleaflet.cls tubsposter.cls
CLOLIST := tubsa040pt.clo tubsa1scifi25pt.clo tubsa313pt.clo tubsa411pt.clo tubsa511pt.clo tubslang11pt.clo
CLOLIST += tubsa0scifi40pt.clo tubsa218pt.clo tubsa3scifi13pt.clo tubsa49pt.clo tubsa59pt.clo tubslang9pt.clo
CLOLIST += tubsa125pt.clo tubsa2scifi18pt.clo tubsa410pt.clo tubsa510pt.clo tubslang10pt.clo
STYLIST := tubsbox.sty tubsstyle.sty tubstypearea.sty
GENLIST = $(CLOLIST) $(CLSLIST) $(STYLIST)
DTXLIST = tubsbox.dtx tubsdoc.dtx tubsflowfram.dtx tubsfont.dtx tubshead.dtx tubsposter.dtx tubsstyle.dtx tubstitlepage.dtx tubstypearea.dtx
INSFILE = tubs.ins

# prefix with '$(SRCDIR)/'
DTXLIST := $(patsubst %,$(SRCDIR)/%,$(DTXLIST))
INSFILE := $(patsubst %,$(SRCDIR)/%,$(INSFILE))


# Programme
.PHONY: cleantemp clean

all: src

src: init $(GENLIST)

init:
	$(MAKE) -C $(BASEDIR) versiondtx

doc: $(DTXLIST:$(SRCDIR)/%.dtx=%.pdf) cleantemp

$(GENLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(Q)TEXINPUTS=.//:$$TEXINPUTS $(VLATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: $(SRCDIR)/%.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(Q)TEXINPUTS=.//:$$TEXINPUTS $(VPDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(Q)TEXINPUTS=.//:$$TEXINPUTS $(VPDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ *~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean generated files..."
	$(RM) -rf *.cls *.sty *.clo *.pdf
	$(ECHO) -e '$(OK_STRING)'
