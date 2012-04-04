# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt fuer alle Beispiele PDFs und packt alle relevanten Dateien
# als zip-Datei.
#

EXAMPLEDIRS = beamer tubsartcl tubsreprt tubsbook tubslttr2 tubsposter

zip: examples
	zip -r tubslatex_examples.zip $(EXAMPLEDIRS)

examples:
	for i in $(EXAMPLEDIRS); do make -C $$i; done

png:
	for i in $(EXAMPLEDIRS); do make png -C $$i 

clean:
	for i in $(EXAMPLEDIRS); do make -C $$i clean; done