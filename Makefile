# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
#

TUBSLATEX_VERSION = 0.3-alpha2

# Verzeichnisse und Dateien
DOCUMENTATION_DIR = doc
DOCUMENTATION_PDF = tubsdocguide.pdf
EXAMPLE_DIR = examples
EXAMPLE_ZIP = tubslatex_examples.zip
CDBASE_SRCDIR = cd-base/src
BEAMER_SRCDIR = beamer/src
LETTER_SRCDIR = letter/src
NEXUS_SRCDIR = nexus/src
REPORT_SRCDIR = report/src
ALL_SRCDIRS = $(CDBASE_SRCDIR) $(BEAMER_SRCDIR) $(LETTER_SRCDIR) $(NEXUS_SRCDIR) $(REPORT_SRCDIR)

# Programme
MAKE = make

.PHONY: clean mkdir documentation examples source sourcedoc

release: mkdir documentation examples source

mkdir:
	mkdir -p Website/$(TUBSLATEX_VERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)
	cp $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_VERSION)/.

examples:
	$(MAKE) -C $(EXAMPLE_DIR)
	cp $(EXAMPLE_DIR)/$(EXAMPLE_ZIP) Website/$(TUBSLATEX_VERSION)/.

source:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i src; done

sourcedoc:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i doc; done

clean:
	$(MAKE) -C $(NEXUS_SRCDIR) clean
	$(MAKE) -C $(CDBASE_SRCDIR) clean
	$(MAKE) -C $(BEAMER_SRCDIR) clean
	$(MAKE) -C $(LETTER_SRCDIR) clean
	$(MAKE) -C $(REPORT_SRCDIR) clean
