# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt fuer alle Beispiele PDFs und packt alle relevanten Dateien
# als zip-Datei.
#

TUBSLATEX_VERSION = 0.3-alpha2

DOCUMENTATION_DIR = doc
DOCUMENTATION_PDF = tubsdocguide.pdf
EXAMPLE_DIR = examples
EXAMPLE_ZIP = tubslatex_examples.zip

MAKE = make

.PHONY: mkdir documentation examples

release: mkdir documentation examples

mkdir:
	mkdir -p Website/$(TUBSLATEX_VERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)
	cp $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_VERSION)/.

examples:
	$(MAKE) -C $(EXAMPLE_DIR)
	cp $(EXAMPLE_DIR)/$(EXAMPLE_ZIP) Website/$(TUBSLATEX_VERSION)/.
