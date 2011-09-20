all:
	TEXINPUTS=../beamer/doc:$$TEXINPUTS pdflatex tubsdocguide.tex

examples: examples/*.tex

%.tex:
	pdflatex $@
