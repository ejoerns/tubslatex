PDFLIST=tubsleaflet-example.pdf

include ../../Makefile.include

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	$(ECHO) Generating $<
	$(PDFLATEX) --interaction batchmode $< > /dev/null || ( echo '[FAILED]' || true )
	$(PDFLATEX) --interaction batchmode $< > /dev/null || ( echo '[FAILED]' || true )

%.png: %.tex
	for i in $(PDFLIST); do convert -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/CMYK\ Profiles/USWebCoatedSWOP.icc -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/RGB\ Profiles/ColorMatchRGB.icc  $$i `basename $$i .pdf`.jpg; done	
	#for i in $(PDFLIST); do convert -profile ../../sRGB_v4_ICC_preference.icc -profile ../../AdobeRGB1998.icc $$i `basename $$i .pdf`.jpg; done	

cleantemp:
	$(RM) -f *.log *.aux *~ *.toc *.backup

clean: cleantemp
	$(RM) -f $(PDFLIST)

.PHONY: cleantemp clean
