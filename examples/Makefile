# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt fuer alle Beispiele PDFs und packt alle relevanten Dateien
# als zip-Datei.
#
include ../Makefile.include

EXAMPLEDIRS = beamer tubsdoc tubsartcl tubsreprt tubsbook tubslttr2 tubsposter tubsleaflet

zip: examples
	$(ECHO) -n 'Compressing examples as zip...'
	$(ZIP) -r tubslatex_examples.zip $(EXAMPLEDIRS) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

examples:
	for i in $(EXAMPLEDIRS); do make -C $$i; done

png:
	for i in $(EXAMPLEDIRS); do make png -C $$i 

clean:
	for i in $(EXAMPLEDIRS); do make -C $$i clean; done
