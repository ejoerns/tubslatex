# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erstellt komplettes Release (still under construction!)
#
# VCS_TEXSTYLE = tex.hgstyle
OTFSRCDIR = otf-src

INSFILE := tubs.ins
GENLIST := beamercolorthemetubs.sty beamerfontthemetubs.sty beamerinnerthemetubs.sty \
	beamerouterthemetubs.sty beamerthemetubs.sty tubsbeamersizes.sty \
	tubsbox.sty tubscolors.sty tubsdebug.sty tubsdoc.sty tubsflowfram.sty \
	tubslogo.sty tubsstyle.sty tubstypearea.sty \
	tubsartcl.cls tubsbook.cls tubsleaflet.cls tubslttr2.cls \
	tubsltxdoc.cls tubsposter.cls tubsreprt.cls \
	tubs.lco tubsa040pt.clo tubsa0scifi40pt.clo tubsa125pt.clo \
	tubsa1scifi25pt.clo tubsa218pt.clo tubsa2scifi18pt.clo \
	tubsa313pt.clo tubsa3scifi13pt.clo tubsa410pt.clo \
	tubsa411pt.clo tubsa49pt.clo tubsa510pt.clo \
	tubsa511pt.clo tubsa59pt.clo tubslang10pt.clo \
	tubslang11pt.clo tubslang9pt.clo


DTXLIST := beamercolorthemetubs.dtx beamerfontthemetubs.dtx beamerinnerthemetubs.dtx \
	beamerouterthemetubs.dtx beamerthemetubs.dtx tubsbeamersizes.dtx \
	tubsbox.dtx tubscolors.dtx tubsdebug.dtx tubsdoc.dtx tubsflowfram.dtx \
	tubsfont.dtx tubshead.dtx tubslogo.dtx tubslttr2.dtx tubsposter.dtx \
	tubsstyle.dtx tubstitlepage.dtx tubstypearea.dtx

MEDIALIST := defaulttitlepicture.jpg \
	TUBraunschweig_4C.eps \
	TUBraunschweig_4C.pdf \
	TUBraunschweig_B.eps \
	TUBraunschweig_B.pdf \
	TUBraunschweig_B_true.pdf \
	TUBraunschweig_RGB_beamer.eps \
	TUBraunschweig_RGB_beamer.pdf \
	TUBraunschweig_RGB.eps \
	TUBraunschweig_RGB.pdf \
	TUBraunschweig_SC.eps \
	TUBraunschweig_SC.pdf

NEXUS_INSFILE = nexus.ins
NEXUS_GENLIST := nexus.sty LY1NexusProSans.fd LY1NexusProSans-lnum.fd LY1NexusProSerif.fd LY1NexusProSerif-lnum.fd
NEXUS_DTXLIST = nexus.dtx

OTFDEFAULT = --warn-missing
OTFDEFAULT += --encoding=texnansx
OTFDEFAULT += --feature=kern
OTFDEFAULT += --feature=liga
OTFDEFAULT += --force
#OTFDEFAULT += --tfm-directory=fonts/tfm/Nexus/
#OTFDEFAULT += --vf-directory=fonts/vf/Nexus/ 
#OTFDEFAULT += --type1-directory=fonts/type1/Nexus/
#OTFDEFAULT += --encoding-directory=fonts/enc/dvips/Fontshop/
#SERIF_OPTS = --map-file=fonts/map/dvips/NexusProSerif.map
#SANS_OPTS = --map-file=fonts/map/dvips/NexusProSans.map
SERIF_OPTS = --map-file=NexusProSerif.map
SANS_OPTS = --map-file=NexusProSans.map
# TODO..
SERIF_FONTLIST = NexusSerifPro-Regular NexusSerifPro-Italic NexusSerifPro-Bold NexusSerifPro-BoldItalic
SANS_FONTLIST = NexusSansPro-Regular NexusSansPro-Italic NexusSansPro-Bold NexusSansPro-BoldItalic
FONTLIST = $(SERIF_FONTLIST) $(SANS_FONTLIST)

# For (not-hanging) lined figures
LNUMFEATURE = --feature=lnum
# For small caps
SMCPFEATURE = --feature=smcp

.PHONY: clean mkdir generate sourcedoc documentation examples buildinstaller zip deb exe fetch versiondtx nexus src

all: $(GENLIST) nexus doc nexus-doc
	make -C doc

# Generate documentation
doc: $(DTXLIST:%.dtx=%.pdf)

# Generate documentation
nexus-doc: $(NEXUS_DTXLIST:%.dtx=%.pdf)

tmpmedia: $(notdir $(MEDIALIST))
	echo $(notdir $(MEDIALIST))

# Generate documentation from dtx files
%.pdf: %.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

$(GENLIST): $(DTXLIST)
	#$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(ECHO) -n 'Generating LaTeX-files ...'
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

src: versiondtx $(GENLIST)

release: clean versiondtx buildinstaller mkdir fetch

font-setup:
	updmap --enable Map=NexusProSans.map
	updmap --enable Map=NexusProSerif.map

# Create tex tree in build dir
textree: src nexus-textree doc documentation
	$(MKDIR) -p build/tex/latex/tubs
	$(MKDIR) -p build/doc/latex/tubs
	$(MKDIR) -p build/source/latex/tubs
	$(CP) *.dtx build/source/latex/tubs
	$(CP) *.cls *.sty *.clo build/tex/latex/tubs/
	$(CP) $(MEDIALIST) build/tex/latex
	$(CP) $(DTXLIST:%.dtx=%.pdf) build/doc/latex/tubs/
	$(CP) doc/tubsdocguide.pdf build/doc/latex/tubs/

$(NEXUS_GENLIST): $(NEXUS_DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(NEXUS_INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

nexus-textree: versiondtx $(NEXUS_GENLIST) fonts-textree font-setup nexus-doc
	$(MKDIR) -p build/tex/latex/nexus
	$(MKDIR) -p build/source/latex/nexus
	$(MKDIR) -p build/doc/latex/nexus
	$(CP) *.fd nexus.sty build/tex/latex/nexus/
	$(CP) nexus.dtx build/source/latex/nexus/
	$(CP) nexus.pdf build/doc/latex/nexus/

# TODO: make dependent from existence of directory
mkdir:
	$(MKDIR) -p Website/$(TUBSLATEX_FULLVERSION)

# Specify some variables to allow building doc and example from generated cls, sty and font files
export TEXINPUTS := $(shell pwd):
export TFMFONTS := $(shell pwd):
export TEXFONTMAPS := $(shell pwd):
export TEXFONTS := $(shell pwd):

documentation:
	$(MAKE) -C doc/

examples:
	$(MAKE) -C examples/

fonts-textree: fonts
	$(MKDIR) -p build/fonts/enc/dvips/Fontshop/
	$(MKDIR) -p build/fonts/map/dvips/Nexus/
	$(MKDIR) -p build/fonts/tfm/Nexus/
	$(MKDIR) -p build/fonts/vf/Nexus/
	$(MKDIR) -p build/fonts/type1/Nexus/
	$(CP) -r *.tfm build/fonts/tfm/Nexus/
	$(CP) -r *.vf build/fonts/vf/Nexus/
	$(CP) -r *.pfb build/fonts/type1/Nexus/
	$(CP) -r *.enc build/fonts/enc/dvips/Fontshop/
	$(CP) NexusProSans.map NexusProSerif.map build/fonts/map/dvips/

fonts:
	$(ECHO) -en 'Generating font files...'
	# Serif
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted --slant=.167  $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)
	# Serif lnum
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular-lnum $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic-lnum $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps-lnum  $(OTFDEFAULT) --feature=smcp $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted-lnum --slant=.167  $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Regular.otf $(SILENT)


	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular  $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted --slant=.167  $(OTFDEFAULT) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)
	# lnum
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular-lnum  $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic-lnum $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps-lnum  $(OTFDEFAULT) $(LNUMFEATURE) --feature=smcp $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted-lnum --slant=.167  $(OTFDEFAULT) $(LNUMFEATURE) $(SERIF_OPTS) $(OTFSRCDIR)/NexusSerifPro-Bold.otf $(SILENT)

	# Sans Serif
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Regular  $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Italic $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167  $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)
	# lnum
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Regular-lnum  $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Italic-lnum $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Italic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps-lnum  $(OTFDEFAULT) $(LNUMFEATURE) --feature=smcp $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted-lnum --slant=.167  $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Regular.otf $(SILENT)

	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular  $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167  $(OTFDEFAULT) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)
	# lnum
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular-lnum  $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic-lnum $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-BoldItalic.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps-lnum  $(OTFDEFAULT) $(LNUMFEATURE) --feature=smcp $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)
	$(OTFTOTFM) --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted-lnum --slant=.167  $(OTFDEFAULT) $(LNUMFEATURE) $(SANS_OPTS) $(OTFSRCDIR)/NexusSansPro-Bold.otf $(SILENT)

	$(ECHO) -e '$(OK_STRING)'


buildinstaller: zip deb exe

pre-install: zip

zip: textree
	$(ZIP) -r build/tubslatex_$(TUBSLATEX_FULLVERSION).tds.zip build/* $(SILENT)

deb:
	$(MAKE) -C $(INSTALL_DEB_DIR) deb

exe:
	$(MAKE) -C $(INSTALL_WIN_DIR) exe

fetch:
	$(ECHO) -n 'Copying release files...'
	$(CP) $(DOCUMENTATION_DIR)/$(DOCUMENTATION_PDF) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(EXAMPLE_DIR)/$(EXAMPLE_ZIP)     Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_RAW_DIR)/$(INSTALL_ZIP) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_DEB_DIR)/$(INSTALL_DEB) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_WIN_DIR)/$(INSTALL_EXE) Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) $(INSTALL_RAW_DIR)/tubslatex_installer Website/$(TUBSLATEX_FULLVERSION)/.
	$(CP) Website/Changelog.txt             Website/$(TUBSLATEX_FULLVERSION)/.
	$(ECHO) -e '$(DONE_STRING)'

clean:
	$(RM) -f *.log *.aux *.toc *.out *.glo *.idx

distclean: clean
	$(RM) -f $(GENLIST) $(NEXUS_GENLIST) $(DTXLIST:%.dtx=%.pdf) $(NEXUS_DTXLIST:%.dtx=%.pdf)
	$(RM) -rf build
	$(RM) -f tubslatex_$(TUBSLATEX_FULLVERSION).tds.zip

cleantemp:
	for i in $(ALL_DIRS); do make -C $$i cleantemp; done
	$(RM) -f *~

include Makefile.include
