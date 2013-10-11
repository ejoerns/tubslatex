# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt Doku-Beispiele
#
include ../../Makefile.include

EXAMPLELIST = backstyles.pdf titlestyles.pdf titlestyle_plain.pdf titlestyle_landscape.pdf article_landscape.pdf leaflet.pdf example_vars.pdf posterstyle_standard.pdf posterstyle_scifi.pdf posterstyle_bulletin.pdf gausssegments.pdf thecd.pdf
EXAMPLELIST += titelseite.pdf inhaltsseite.pdf inhaltsseite_hervorgehoben.pdf colorscheme1.pdf colorscheme2.pdf colorscheme3.pdf doc_layout.pdf stdposter_minimal.pdf module_split.pdf beamer_blocks.pdf
EXAMPLELIST += module_option_hierarchy.pdf tubsleaflet_order.pdf

.PONY: clean cleantemp

all: $(EXAMPLELIST) cleantemp

%.pdf: %.tex
	$(ECHO) -n 'Compiling example file $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

cleantemp:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

clean: cleantemp
	$(ECHO) -n "Clean build files..."
	$(RM) -f $(EXAMPLELIST)
	$(ECHO) -e '$(OK_STRING)'
