# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt verschiedene tubslatex-Klassen, -Pakete und weitere Dateien,
# sowie Dokumentation
#
include ../../Makefile.include

# Dateien
CLSLIST := build/tubsartcl.cls build/tubsreprt.cls build/tubsbook.cls build/tubsleaflet.cls build/tubsposter.cls
CLOLIST := 
STYLIST := build/tubsbox.sty build/tubsstyle.sty build/tubstypearea.sty
GENLIST = $(CLOLIST) $(CLSLIST) $(STYLIST)
DTXLIST = tubsbox.dtx tubsdoc.dtx tubsflowfram.dtx tubsfont.dtx tubshead.dtx tubsposter.dtx tubsstyle.dtx tubstitlepage.dtx tubstypearea.dtx
INSFILE = tubs.ins

# Programme

.PHONY: cleantemp clean

# .SILENT: init clean cleantemp %.pdf

all: src

init:
# Make sure base files are generated
# make -C $(BASEDIR)/nexus/src src # todo: only nexus/
# make -C $(BASEDIR)/cd-base/src src
	$(ECHO) -n 'Create build directory...'
	$(MKDIR) -p $(BASEDIR)/report/src/build
	$(ECHO) -e '$(OK_STRING)'

src: init $(GENLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp

$(GENLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: %.dtx
	@echo -n 'Compiling doc for $<'...
	@pdflatex  $(PDFLATEX_SILENT) $< $(SILENT)
	@pdflatex  $(PDFLATEX_SILENT) $< $(SILENT)
	@echo -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean build files..."
	$(RM) -rf build *.pdf
	$(ECHO) -e '$(OK_STRING)'
