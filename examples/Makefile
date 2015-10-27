# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt fuer alle Beispiele PDFs und packt alle relevanten Dateien
# als zip-Datei.
#
EXAMPLEDIRS = beamer tubsdoc tubsartcl tubsreprt tubsbook tubslttr2 tubsposter tubsleaflet


examples:
	for i in $(EXAMPLEDIRS); do make -C $$i; done

zip: examples
	$(ECHO) -n 'Compressing examples as zip...'
	$(ZIP) -FSr tubslatex_examples.zip $(EXAMPLEDIRS) -i "**/*.tex" -i "**/*.pdf" -i "**/*.jpg" -i "**/*.lco" $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

png:
	for i in $(EXAMPLEDIRS); do make png -C $$i 

clean:
	for i in $(EXAMPLEDIRS); do make -C $$i clean; done

include ../Makefile.include
