all: structure fetch font build

VERSION = 0.2
DIST = debian

REPODIR = /home/enrico/CD-LaTeX

build:
	sudo dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb

structure:
	mkdir -p texlive-tubs
	mkdir -p texlive-tubs/DEBIAN
	mkdir -p texlive-tubs/usr/share/texmf-texlive/tex/latex/tubs
	mkdir -p texlive-tubs/usr/share/texmf-texlive/tex/latex/tubs/beamer
	mkdir -p texlive-tubs/usr/share/texmf-texlive/tex/latex/tubs/cd-base
	mkdir -p texlive-tubs/usr/share/texmf-texlive/tex/latex/tubs/report

fetch:
	cp control postinst texlive-tubs/DEBIAN/.
	cd ./texlive-tubs/usr/share/texmf-texlive/tex/latex/tubs; \
	cp $(REPODIR)/cd-base/src/*.sty cd-base/.; \
	cp $(REPODIR)/cd-base/src/*.pdf cd-base/.; \
	cp $(REPODIR)/beamer/src/*.sty beamer/.; \
	cp $(REPODIR)/beamer/src/defaulttitlepicture.jpg beamer/.; \
	cp $(REPODIR)/report/src/*.cls report/.; \
	cp $(REPODIR)/report/src/*.tex report/.;

clean:
	rm -rf texlive-tubs
	rm -f *.otf
	rm texlive-tubs_$(VERSION)$(DIST).deb

install:
	sudo dpkg -i texlive-tubs_$(VERSION)$(DIST).deb

OTFDEFAULT=--warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --force

font:
	cp $(REPODIR)/cd-base/nexus/*.otf .
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Regular $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
	# otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Italic --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Slanted --slant=.167  $(OTFDEFAULT)  --map-file=NexusProSerif.map NexusSerifPro-Regular.otf 

	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Regular  $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
	# otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Italic --warn-missing --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSerif.map NexusSerifPro-Bold-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSerif-Bold-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSerif.map NexusSerifPro-Bold.otf 

	# Sans Serif
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	#otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Italic --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Regular.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Regular.otf 

	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Regular  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	#otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Italic --verbose --encoding=texnansx --feature=kern --feature=liga --feature=lnum --map-file=NexusProSans.map NexusSansPro-Bold-Italic.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-SmallCaps  $(OTFDEFAULT) --feature=smcp --map-file=NexusProSans.map NexusSansPro-Bold.otf 
	otftotfm --no-updmap --vendor=Fontshop --name=NexusProSans-Bold-Slanted --slant=.167  $(OTFDEFAULT) --map-file=NexusProSans.map NexusSansPro-Bold.otf

	# Move generated fonts
	mkdir -p texlive-tubs/usr/share/texmf-texlive/fonts/enc/dvips/Fontshop/
	mv *.enc texlive-tubs/usr/share/texmf-texlive/fonts/enc/dvips/Fontshop/

	mkdir -p texlive-tubs/usr/share/texmf-texlive/fonts/map/
	mv *.map texlive-tubs/usr/share/texmf-texlive/fonts/map/

	mkdir -p texlive-tubs/usr/share/texmf-texlive/fonts/tfm/Nexus/
	mv *.tfm texlive-tubs/usr/share/texmf-texlive/fonts/tfm/Nexus/

	mkdir -p texlive-tubs/usr/share/texmf-texlive/fonts/vf/Nexus/
	mv *.vf texlive-tubs/usr/share/texmf-texlive/fonts/vf/Nexus/

	mkdir -p texlive-tubs/usr/share/texmf-texlive/fonts/type1/Nexus/
	mv *.pfb texlive-tubs/usr/share/texmf-texlive/fonts/type1/Nexus/

# 	mkdir -p texlive-tubs/usr/share/texmf-texlive/tex/latex/
	cp -r $(REPODIR)/cd-base/nexus/Nexus texlive-tubs/usr/share/texmf-texlive/tex/latex/

