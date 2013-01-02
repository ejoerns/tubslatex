# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
#
# Benutzung:
#   Aufrunf von 'make' erzeugt exe-Datei ...

include ../../Makefile.include

VERSION = $(TUBSLATEX_FULLVERSION)


.PHONY: exe build structure fetch clean install

# Compile, copy and create exe
all: build exe

# Only copy files, then create exe (no compile!)
exe: copy
	$(ECHO) -n 'Compiling Windows-Installer...'
	$(CAT) tubslatexSetup_script.nsi | sed 's/REPLACEWITHVERSION/$(VERSION)/g' > tmp.nsi
	$(MAKENSIS) tmp.nsi $(SILENT)
	$(RM) tmp.nsi
	$(ECHO) -e '$(DONE_STRING)'

# Clean up, and copy compiled files from 'raw' directory
copy: clean structure fetch

build:
	$(MAKE) -C $(INSTALL_RAW_DIR)

structure:
	$(MKDIR) -p data

fetch:
	$(CP) -r $(INSTALL_RAW_DIR)/tex data/.
	$(CP) -r $(INSTALL_RAW_DIR)/doc data/.
	$(CP) -r $(INSTALL_RAW_DIR)/fonts data/.

clean:
	$(RM) -rf data

install:
	$(WINE) tubslatexSetup_$(VERSION).exe
