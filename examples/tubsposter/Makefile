PDFLIST=tubsposter_example.pdf scifiposter_example.pdf bulletin_example.pdf

all: $(PDFLIST) cleantemp

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

%.png: %.tex
	for i in $(PDFLIST); do convert -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/CMYK\ Profiles/USWebCoatedSWOP.icc -profile /usr/share/color/icc/Adobe\ ICC\ Profiles/RGB\ Profiles/ColorMatchRGB.icc  $$i `basename $$i .pdf`.jpg; done	
	#for i in $(PDFLIST); do convert -profile ../../sRGB_v4_ICC_preference.icc -profile ../../AdobeRGB1998.icc $$i `basename $$i .pdf`.jpg; done	

cleantemp:
	rm -f *.log *.aux *~ *.toc *.backup

clean: cleantemp
	rm -f $(PDFLIST)

.PHONY: cleantemp clean
