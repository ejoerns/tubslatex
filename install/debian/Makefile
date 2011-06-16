all: clean structure fetch build

VERSION = 0.2.4
DIST = debian

REPODIR = /home/enrico/CD-LaTeX
INSTALLPATH = usr/share/texmf-texlive

build:
	sudo dpkg -b ./texlive-tubs texlive-tubs_$(VERSION)$(DIST).deb

structure:
	mkdir -p texlive-tubs
	mkdir -p texlive-tubs/DEBIAN
	mkdir -p texlive-tubs/$(INSTALLPATH)

fetch:
	. ../rawtree/fetch
	cp control postinst prerm postrm texlive-tubs/DEBIAN/.
	mv tex texlive-tubs/$(INSTALLPATH)/.
	mv doc texlive-tubs/$(INSTALLPATH)/.
	mv fonts texlive-tubs/$(INSTALLPATH)/.

clean:
	rm -rf texlive-tubs
	rm -f *.otf
	rm -f texlive-tubs_$(VERSION)$(DIST).deb

install:
	sudo dpkg -i texlive-tubs_$(VERSION)$(DIST).deb
