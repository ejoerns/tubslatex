# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt verschiedene tubslatex-Klassen, -Pakete und weitere Dateien,
# sowie Dokumentation
#

# Dateien
CLSLIST := build/tubsartcl.cls build/tubsreprt.cls build/tubsbook.cls build/tubsleaflet.cls build/tubsposter.cls
CLOLIST := 
STYLIST := build/tubsbox.sty build/tubsstyle.sty build/tubstypearea.sty
GENLIST = $(CLOLIST) $(CLSLIST) $(STYLIST)
DTXLIST = tubsbox.dtx tubsdoc.dtx tubsflowfram.dtx tubsfont.dtx tubshead.dtx tubsposter.dtx tubsstyle.dtx tubstitlepage.dtx tubstypearea.dtx
INSFILE = tubs.ins

# Programme
LATEX = latex
PDFLATEX = pdflatex

.PHONY: cleantemp clean

all: init src doc

init:
	mkdir -p build

src: $(GENLIST)

doc: $(DTXLIST:%.dtx=%.pdf) cleantemp

$(GENLIST): $(DTXLIST)
	$(LATEX) $(INSFILE)

%.pdf: %.dtx
	$(PDFLATEX) $<
	$(PDFLATEX) $<

cleantemp:
	rm -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup

clean: cleantemp
	rm -f build/*.clo build/*.cls build/*.sty *.pdf
