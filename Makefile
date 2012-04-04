# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
#

# hg-Version
HG_REVISION = `hg tip --template '{rev}'`
HG_DATE = `hg tip --template '{date|shortdate}' | tr - /`
HG_TEXREVISION = tip --style $(HG_TEXSTYLE)
# tubslatex-Version
TUBSLATEX_VERSION = 0.3-beta2
TUBSLATEX_FULLVERSION = $(TUBSLATEX_VERSION)
#TUBSLATEX_FULLVERSION = $(TUBSLATEX_VERSION)-r$(HG_REVISION)
TUBSLATEX_DEBVERSION = 1:0.3.0~r$(HG_REVISION)beta2

# 
HG_TEXSTYLE = tex.hgstyle
HG_DTXOUT = tubsvers.inc

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
INSTALL_ZIP = tubslatex_$(TUBSLATEX_FULLVERSION).zip
INSTALL_DEB_DIR = install/debian
INSTALL_DEB = texlive-tubs_$(TUBSLATEX_FULLVERSION)debian.deb
INSTALL_WIN_DIR = install/windows
INSTALL_EXE = tubslatexSetup_$(TUBSLATEX_FULLVERSION).exe

# Programme
MAKE = make
HG = /usr/bin/hg
SED = /bin/sed

.PHONY: clean mkdir generate source sourcedoc documentation examples buildinstaller zip deb exe fetch

release: generate buildinstaller mkdir fetch

generate: source sourcedoc documentation examples

mkdir:
	mkdir -p Website/$(TUBSLATEX_FULLVERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)

examples:
	$(MAKE) -C $(EXAMPLE_DIR)

source:
	cat tex.hgtemplate \
	  | $(SED) 's:\$$HG_DATE\$$:'"$(HG_DATE)"':g' \
	  | $(SED) 's/\$$VERSION\$$/$(TUBSLATEX_VERSION)/g' \
	  | $(SED) -e 's/\$$HG_REV\$$/'"$(HG_REVISION)"'/g' > $(HG_DTXOUT)
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i src; done

sourcedoc:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i doc; done

buildinstaller: zip deb exe

zip:
	$(MAKE) -C $(INSTALL_RAW_DIR)
	$(MAKE) -C $(INSTALL_RAW_DIR) VERSION=$(TUBSLATEX_FULLVERSION) zip
deb:
	$(MAKE) -C $(INSTALL_DEB_DIR) copy DEBVERSION=$(TUBSLATEX_DEBVERSION)
	$(MAKE) -C $(INSTALL_DEB_DIR) VERSION=$(TUBSLATEX_FULLVERSION) deb
exe:
	$(MAKE) -C $(INSTALL_WIN_DIR) copy
	$(MAKE) -C $(INSTALL_WIN_DIR) VERSION=$(TUBSLATEX_FULLVERSION) exe

fetch:
	cp $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_FULLVERSION)/.
	cp $(EXAMPLE_DIR)/$(EXAMPLE_ZIP)     Website/$(TUBSLATEX_FULLVERSION)/.
	cp $(INSTALL_RAW_DIR)/$(INSTALL_ZIP) Website/$(TUBSLATEX_FULLVERSION)/.
	cp $(INSTALL_DEB_DIR)/$(INSTALL_DEB) Website/$(TUBSLATEX_FULLVERSION)/.
	cp $(INSTALL_WIN_DIR)/$(INSTALL_EXE) Website/$(TUBSLATEX_FULLVERSION)/.
	cp Website/Changelog.txt             Website/$(TUBSLATEX_FULLVERSION)/.

clean:
	for i in $(ALL_SRCDIRS); do $(MAKE) -C $$i clean; done
	$(MAKE) -C $(DOCUMENTATION_DIR) clean
