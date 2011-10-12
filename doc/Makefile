all:
	bibtex tubsdocguide
	makeglossaries tubsdocguide
	TEXINPUTS=../beamer/doc:$$TEXINPUTS pdflatex tubsdocguide.tex

examples: examples/*.tex

%.tex:
	pdflatex $@
