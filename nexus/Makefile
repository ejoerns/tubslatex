# Makefile (c) 2011 by Enrico Jörns
# ---------------------------------
# Erzeugt nexus-Paket und Dokumentation
#

SRCDIR = src
OTFSRCDIR = otf-src
BUILDDIR = build

# Dateien
STYLIST := nexus.sty LY1NexusProSans.fd LY1NexusProSans-lnum.fd LY1NexusProSerif.fd LY1NexusProSerif-lnum.fd
DTXLIST = nexus.dtx
INSFILE = nexus.ins

OTFDEFAULT = --warn-missing
OTFDEFAULT += --encoding=texnansx
OTFDEFAULT += --feature=kern
OTFDEFAULT += --feature=liga
OTFDEFAULT += --force
OTFDEFAULT += --tfm-directory=fonts/tfm/Nexus/
OTFDEFAULT += --vf-directory=fonts/vf/Nexus/ 
OTFDEFAULT += --type1-directory=fonts/type1/Nexus/
OTFDEFAULT += --encoding-directory=fonts/enc/dvips/Fontshop/
SERIF_OPTS = --map-file=fonts/map/dvips/NexusProSerif.map
SANS_OPTS = --map-file=fonts/map/dvips/NexusProSans.map
# TODO..
SERIF_FONTLIST = NexusSerifPro-Regular NexusSerifPro-Italic NexusSerifPro-Bold NexusSerifPro-BoldItalic
SANS_FONTLIST = NexusSansPro-Regular NexusSansPro-Italic NexusSansPro-Bold NexusSansPro-BoldItalic
FONTLIST = $(SERIF_FONTLIST) $(SANS_FONTLIST)

# For (not-hanging) lined figures
LNUMFEATURE = --feature=lnum
# For small caps
SMCPFEATURE = --feature=smcp

.PHONY: cleantemp clean

# TODO: make fonts, too?
all: src cleantemp

test:
	echo '$(STYLIST)'

src: $(STYLIST)

doc: $(DTXLIST:%.dtx=%.pdf)

$(STYLIST): $(DTXLIST)
	$(ECHO) -n 'Generating LaTeX-files for $<'...
	$(LATEX) $(PDFLATEX_SILENT) $(INSFILE) $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.pdf: %.dtx
	$(ECHO) -n 'Compiling doc for $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

fonts:
	$(ECHO) -en 'Generating font files...'
	$(MKDIR) -p fonts/enc/dvips/Fontshop/
	$(MKDIR) -p fonts/map/dvips/Nexus/
	$(MKDIR) -p fonts/tfm/Nexus/
	$(MKDIR) -p fonts/vf/Nexus/
	$(MKDIR) -p fonts/type1/Nexus/
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

clean:
	$(ECHO) -n "Clean temporary files..."
	$(RM) -f *~ build/*~ *.aux *.log *.glo *.idx *.out *.toc *.backup
	$(ECHO) -e '$(OK_STRING)'

distclean: clean
	$(ECHO) -n "Clean build files..."
	$(RM) -rf *.sty *.pdf *.fd
	$(RM) -rf fonts
	$(ECHO) -e '$(OK_STRING)'

include ../Makefile.include
