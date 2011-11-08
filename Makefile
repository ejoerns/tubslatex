# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
# 

HG_REVISION = `hg tip --template '{rev}'`
TUBSLATEX_VERSION = 0.3-alpha3-r$(HG_REVISION)
TUBSLATEX_DEBVERSION = 1:0.3.0~r$(HG_REVISION)alpha3

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
INSTALL_RAW_DIR = install/rawtree
INSTALL_ZIP = tubslatex_$(TUBSLATEX_VERSION).zip
INSTALL_DEB_DIR = install/debian
INSTALL_DEB = texlive-tubs_$(TUBSLATEX_VERSION)debian.deb
INSTALL_WIN_DIR = install/windows
INSTALL_EXE = tubslatexSetup_$(TUBSLATEX_VERSION).exe

# Programme
MAKE = make

.PHONY: clean mkdir generate source sourcedoc documentation examples buildinstaller zip deb exe fetch

release: generate buildinstaller mkdir fetch

generate: source sourcedoc documentation examples

mkdir:
	mkdir -p Website/$(TUBSLATEX_VERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)

examples:
	$(MAKE) -C $(EXAMPLE_DIR)

source:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i src; done

sourcedoc:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i doc; done

buildinstaller: zip deb exe

zip:
	$(MAKE) -C $(INSTALL_RAW_DIR)
	$(MAKE) -C $(INSTALL_RAW_DIR) VERSION=$(TUBSLATEX_VERSION) zip
deb:
	$(MAKE) -C $(INSTALL_DEB_DIR) copy DEBVERSION=$(TUBSLATEX_DEBVERSION) deb
	$(MAKE) -C $(INSTALL_DEB_DIR) VERSION=$(TUBSLATEX_VERSION) deb
exe:
	$(MAKE) -C $(INSTALL_WIN_DIR) copy
	$(MAKE) -C $(INSTALL_WIN_DIR) VERSION=$(TUBSLATEX_VERSION) exe

fetch:
	cp $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_VERSION)/.
	cp $(EXAMPLE_DIR)/$(EXAMPLE_ZIP)     Website/$(TUBSLATEX_VERSION)/.
	cp $(INSTALL_RAW_DIR)/$(INSTALL_ZIP) Website/$(TUBSLATEX_VERSION)/.
	cp $(INSTALL_DEB_DIR)/$(INSTALL_DEB) Website/$(TUBSLATEX_VERSION)/.
	cp $(INSTALL_WIN_DIR)/$(INSTALL_EXE) Website/$(TUBSLATEX_VERSION)/.


clean:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i clean; done
	$(MAKE) -C $(DOCUMENTATION_DIR) clean


test:
	echo $(TUBSLATEX_DEBVERSION)
