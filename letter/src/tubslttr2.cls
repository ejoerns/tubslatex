\RequirePackage{xkeyval}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptionsX
\LoadClass[pagenumber=botleft,refline=nodate]{scrlttr2}
\removereffields

\RequirePackage{Nexus}
\RequirePackage[green]{tubscolors}
\RequirePackage{tubslogo}

\@setplength{lochpos}{-15.75cm}
\@setplength{locvpos}{4.7cm}
\@setplength{locwidth}{4.75cm}
\@setplength{locheight}{292pt}

\@setplength{refhpos}{2.4cm}
\@setplength{refwidth}{12.5cm}

\@setplength{firstheadhpos}{1.75cm}
\@setplength{firstheadvpos}{1.75cm}
\@setplength{firstheadwidth}{17.6cm}

\@setplength{backaddrheight}{21pt}

\setlength{\textwidth}{12.5cm}

\newkomavar{fromtitle}

\newkomavar{frominstitute}
\newkomavar{fromdepartment}
\newkomavar{fromstreet}
\newkomavar{fromtown}

\newkomavar{fromphonedirect}
\newkomavar{fromfaxdirect}

\newkomavar{mymail}

\renewcommand*{\raggedsignature}{\raggedright}

\setkomavar{firsthead}{\color{tuRed}\rule[-1.75cm]{17.6cm}{1pt}\\[-1.75cm]
\tubslogo[0.9]
}

\setkomavar{backaddress}{\makebox[0pt][l]{\begin{tabular}[t]{l}
Technische Universität Braunschweig | \usekomavar{frominstitute}\\
\usekomavar{fromstreet} | \usekomavar{fromzipcode} \usekomavar{fromtown} | Deutschland
\end{tabular}}}

\setkomafont{addressee}{\sffamily}
\setkomafont{subject}{\sffamily}
\setkomafont{pageheadfoot}{\sffamily}
\setkomafont{backaddress}{\bfseries\sffamily}
\AtBeginLetter{\sffamily}

\setkomavar{nexthead}{
\begin{tabular}{l}
Technische Universität Braunschweig\\
\usekomavar{frominstitute}\\
\ifkomavarempty{fromdepartment}{\relax}{\usekomavar{fromdepartment}}
\end{tabular}
}

\setkomavar{location}{\begin{flushleft}
\ifkomavarempty{fromphonedirect}{\relax}{\setkomavar{fromphone}{+49\,531\,391-\usekomavar{fromphonedirect}}}%
\ifkomavarempty{fromfaxdirect}{\relax}{\setkomavar{fromfax}{+49\,531\,391-\usekomavar{fromfaxdirect}}}%
\footnotesize \sffamily
Technische Universität\\Braunschweig\\
\textbf{\usekomavar{frominstitute}}\\
\ifkomavarempty{fromdepartment}{\relax}
{
~\\
\usekomavar{fromdepartment}\\
}
~\\
\usekomavar{fromstreet}\\
\usekomavar{fromzipcode}~\usekomavar{fromtown}\\
Deutschland\\
~\\
\ifkomavarempty{fromtitle}{\relax}{\usekomavar{fromtitle}\\}
\usekomavar{fromname}\\
~\\
\usekomavar{fromphone}\\
\usekomavar{fromfax}\\
\usekomavar{fromemail}\\
\usekomavar{fromurl}\\
~\\
Datum: \usekomavar{date}\\
~\\
\ifkomavarempty{yourref}{\relax}{Ihr Zeichen: \usekomavar{yourref}\\}
\ifkomavarempty{yourmail}{\relax}{Ihre Nachricht vom: \usekomavar{yourmail}\\}
\ifkomavarempty{myref}{\relax}{Unser Zeichen: \usekomavar{myref}\\}
\ifkomavarempty{mymail}{\relax}{Unsere Nachricht vom: \usekomavar{mymail}\\}
~\\
\end{flushleft}
}

\pagestyle{headings}