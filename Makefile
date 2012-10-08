# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
#
include Makefile.include

# 
HG_TEXSTYLE = tex.hgstyle
HG_DTXOUT = tubsvers.inc

# Verzeichnisse und Dateien
DOCUMENTATION_DIR = doc
DOCUMENTATION_PDF = tubsdocguide.pdf
EXAMPLE_DIR = examples
EXAMPLE_ZIP = tubslatex_examples.zip
CDBASE_SRCDIR = cd-base
BEAMER_SRCDIR = beamer
LETTER_SRCDIR = letter
NEXUS_SRCDIR = nexus
REPORT_SRCDIR = report
ALL_SRCDIRS = $(CDBASE_SRCDIR) $(BEAMER_SRCDIR) $(LETTER_SRCDIR) $(NEXUS_SRCDIR) $(REPORT_SRCDIR)

INSTALL_RAW_DIR = install/rawtree
INSTALL_ZIP = tubslatex_$(TUBSLATEX_FULLVERSION).tds.zip
INSTALL_DEB_DIR = install/debian
INSTALL_DEB = texlive-tubs_$(TUBSLATEX_FULLVERSION)debian.deb
INSTALL_WIN_DIR = install/windows
INSTALL_EXE = tubslatexSetup_$(TUBSLATEX_FULLVERSION).exe


.PHONY: clean mkdir generate source sourcedoc documentation examples buildinstaller zip deb exe fetch

release: info generate buildinstaller mkdir fetch

info:
	$(ECHO) 'This is Version $(V_MAJOR).$(V_MINOR).$(V_PATCH)'

generate: source sourcedoc documentation examples

mkdir:
	$(MKDIR) -p Website/$(TUBSLATEX_FULLVERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)

examples:
	$(MAKE) -C $(EXAMPLE_DIR)

source:
	$(CAT) tex.hgtemplate \
	  | $(SED) 's:\$$HG_DATE\$$:'"$(HG_DATE)"':g' \
	  | $(SED) 's/\$$VERSION\$$/$(TUBSLATEX_VERSION)/g' \
	  | $(SED) -e 's/\$$HG_REV\$$/'"$(HG_REVISION)"'/g' > $(HG_DTXOUT)
	for i in $(ALL_SRCDIRS); do make -C $$i src; done

sourcedoc:
	for i in $(ALL_SRCDIRS); do make -C $$i doc; done

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
	for i in $(ALL_SRCDIRS); do make -C $$i clean; done
	$(MAKE) -C $(DOCUMENTATION_DIR) clean
