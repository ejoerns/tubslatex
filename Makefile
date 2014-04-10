# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
#
include Makefile.include

# 
# VCS_TEXSTYLE = tex.hgstyle


.PHONY: clean mkdir generate sourcedoc documentation examples buildinstaller zip deb exe fetch versiondtx

release: clean versiondtx buildinstaller mkdir fetch

# generate: $(VCS_DTXOUT) sourcedoc documentation examples

versiondtx:
	$(ECHO) -e '$(WARN_COLOR)This is tubslatex Version $(TUBSLATEX_FULLVERSION)$(NO_COLOR)'
	$(CAT) $(TEX_HGTEMPLATE) \
	  | $(SED) 's:\$$VCS_DATE\$$:'"$(VCS_DATE)"':g' \
	  | $(SED) 's/\$$VERSION\$$/$(TUBSLATEX_VERSION)/g' \
	  | $(SED) -e 's/\$$VCS_REV\$$/'"$(VCS_REVISION)"'/g' > $(VCS_DTXOUT)

# TODO: make dependent from existence of directory
mkdir:
	$(MKDIR) -p Website/$(TUBSLATEX_FULLVERSION)

documentation:
	$(MAKE) -C $(DOCUMENTATION_DIR)

examples:
	$(MAKE) -C $(EXAMPLE_DIR)

# 	for i in $(ALL_DIRS); do make -C $$i src; done

sourcedoc:
# 	for i in $(ALL_DIRS); do make -C $$i doc; done

buildinstaller: zip deb exe

zip:
# 	$(MAKE) -C $(INSTALL_RAW_DIR)
	$(MAKE) -C $(INSTALL_RAW_DIR) zip

deb:
# 	$(MAKE) -C $(INSTALL_DEB_DIR)
	$(MAKE) -C $(INSTALL_DEB_DIR) deb

exe:
# 	$(MAKE) -C $(INSTALL_WIN_DIR)
	$(MAKE) -C $(INSTALL_WIN_DIR) exe

fetch:
	$(ECHO) -n 'Copying release files...'
	$(CP) $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(EXAMPLE_DIR)/$(EXAMPLE_ZIP)     Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_RAW_DIR)/$(INSTALL_ZIP) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_DEB_DIR)/$(INSTALL_DEB) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_WIN_DIR)/$(INSTALL_EXE) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_RAW_DIR)/tubslatex_installer.sh  Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) Website/Changelog.txt             Website/$(TUBSLATEX_FULLVERSION)/.
	$(ECHO) -e '$(DONE_STRING)'

clean:
	for i in $(ALL_DIRS); do make -C $$i clean; done
	$(MAKE) -C $(DOCUMENTATION_DIR) clean
	$(RM) -f *~

cleantemp:
	for i in $(ALL_DIRS); do make -C $$i cleantemp; done
	$(RM) -f *~
