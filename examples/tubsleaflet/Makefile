include ../../Makefile.include

PDFLIST=tubsleaflet-example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	$(ECHO) -n 'Compiling example file $<'...
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(PDFLATEX) $(PDFLATEX_SILENT) $< $(SILENT)
	$(ECHO) -e '$(DONE_STRING)'

%.png: %.tex
	for i in $(PDFLIST); do convert -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/CMYK\ Profiles/USWebCoatedSWOP.icc -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/RGB\ Profiles/ColorMatchRGB.icc  $$i `basename $$i .pdf`.jpg; done	


cleantemp:
	$(RM) -f *.log *.aux *~ *.toc

clean:
	$(RM) -f $(PDFLIST)

.PHONY: cleantemp clean
