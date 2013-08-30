\ProvidesPackage{tubsltxdoc}[2012/09/11 Dokumentationsklasse]

\LoadClass{ltxdoc}
\RequirePackage{tubsdoc}

\newenvironment{key}[2]{\expandafter\macro\expandafter{`#2'}}{\endmacro}
\newenvironment{Options}%
 {\begin{list}{}{%
  \renewcommand{\makelabel}[1]{\texttt{##1}\hfil}%
  \setlength{\itemsep}{-.5\parsep}
  \settowidth{\labelwidth}{\texttt{xxxxxxxxxxx\space}}%
  \setlength{\leftmargin}{\labelwidth}%
  \addtolength{\leftmargin}{\labelsep}}%
  \raggedright}
 {\end{list}}

\parindent0mm
\parskip\medskipamount