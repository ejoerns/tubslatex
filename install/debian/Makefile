all: clean structure fetch build

VERSION = 0.3-alpha1
DIST = debian

REPODIR = /home/enrico/CD-LaTeX
INSTALLPATH = usr/share/texmf-texlive

RAWTREE = $(REPODIR)/install/rawtree

build:
	sudo dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb

structure:
	mkdir -p texlive-tubs
	mkdir -p texlive-tubs/DEBIAN
	mkdir -p texlive-tubs/$(INSTALLPATH)

fetch:
	make -C $(RAWTREE) -B
	cp control postinst prerm postrm texlive-tubs/DEBIAN/.
	mv $(RAWTREE)/tex texlive-tubs/$(INSTALLPATH)/.
	mv $(RAWTREE)/doc texlive-tubs/$(INSTALLPATH)/.
	mv $(RAWTREE)/fonts texlive-tubs/$(INSTALLPATH)/.

clean:
	rm -rf texlive-tubs
	rm -f *.otf
	rm -f texlive-tubs_$(VERSION)$(DIST).deb

install:
	sudo dpkg -i texlive-tubs_$(VERSION)$(DIST).deb
