\RequirePackage{xkeyval}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptionsX
\LoadClass{scrreprt}

\RequirePackage{ifthen}
\RequirePackage[cmyk]{xcolor}

\input{colors}

\input{predefinedtitlepages}

\def\TUBSLogoPosition{top}

\DeclareOptionX{TUBSLogo}
	{
	\def\TUBSLogoPosition{#1}
	}


\def\twosided{false}
\DeclareOptionX{twoside}
	{
	\def\twosided{true}
	}
	
\def\TUBSDesignHelper{false}
\DeclareOptionX{TUBSDesignHelper}
	{
	\ifthenelse{\equal{#1}{true}}
		{
		\def\TUBSDesignHelper{true}
		}{}
	}

\edef\papersize{4}
\DeclareOptionX{paper}
	{
	%lowercase isnt working???
	\ifthenelse{\equal{#1}{a0}}{\edef\papersize{0}}{}
	\ifthenelse{\equal{#1}{a1}}{\edef\papersize{1}}{}
	\ifthenelse{\equal{#1}{a2}}{\edef\papersize{2}}{}
	\ifthenelse{\equal{#1}{a3}}{\edef\papersize{3}}{}
	\ifthenelse{\equal{#1}{a4}}{\edef\papersize{4}}{}
	\ifthenelse{\equal{#1}{a5}}{\edef\papersize{5}}{}
	\ifthenelse{\equal{#1}{a6}}{\edef\papersize{6}}{}
	}
\DeclareOptionX{a4paper}
	{
	\edef\papersize{4}
	}
\DeclareOptionX{a5paper}
	{
	\edef\papersize{5}
	}
	
\edef\landscape{false}
\DeclareOptionX{landscape}
	{
	\edef\landscape{true}
	}

\ExecuteOptionsX{TUBStitlepage=classic,TUBSLogo=top}
\ProcessOptionsX

\input{font}
\input{gaussgrid}
\input{titlepage}
\input{backpage}
\input{header}

\IfFileExists{TUBS.cfg}
{
	\input{TUBS.cfg}
}
{
	\relax
}

\DeclareOptionX{config}
{
	\IfFileExists{TUBS_#1.cfg}
	{
		\input{TUBS_#1.cfg}
	}
	{
		\PackageWarning{tubs*}{Config file TUBS_#1.cfg does not exist, standard configuration used}
	}
}
\ProcessOptionsX

\renewcommand{\labelitemi}{\raisebox{1.5pt}{\vrule width 3.5pt height 3.5pt}}
\renewcommand{\labelitemii}{\raisebox{1.5pt}{\vrule width 3.5pt height 3.5pt}}
\renewcommand{\labelitemiii}{\raisebox{1.5pt}{\vrule width 3.5pt height 3.5pt}}
\renewcommand{\labelitemiv}{\raisebox{1.5pt}{\vrule width 3.5pt height 3.5pt}}