\RequirePackage{xkeyval}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptionsX
\LoadClass[pagenumber=botleft,refline=nodate]{scrlttr2}

\RequirePackage{Nexus}
\RequirePackage[green]{tubscolors}
\RequirePackage{tubslogo}

\@setplength{lochpos}{-15.75cm}
\@setplength{locvpos}{4.7cm}
\@setplength{locwidth}{4.75cm}
\@setplength{locheight}{212pt}

\@setplength{refhpos}{2.4cm}
\@setplength{refwidth}{12.5cm}

\@setplength{firstheadhpos}{1.75cm}
\@setplength{firstheadvpos}{1.75cm}
\@setplength{firstheadwidth}{17.6cm}

\setlength{\textwidth}{12.5cm}

\newkomavar{fromtitle}

\newkomavar{frominstitute}
\newkomavar{fromdepartment}
\newkomavar{fromstreet}
\newkomavar{fromtown}

\newkomavar{fromphonedirect}
\newkomavar{fromfaxdirect}

\setkomavar{firsthead}{\color{tuRed}\rule[-1.75cm]{17.6cm}{1pt}\\[-1.75cm]
\tubslogo[0.9]
}

\setkomavar{backaddress}{\makebox[0pt][l]{\begin{tabular}{l}
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

\ifkomavarempty{fromphonedirect}{\relax}{\setkomavar{fromphone}{+49\,531\,391-\usekomavar{fromphonedirect}}}
\ifkomavarempty{fromfaxdirect}{\relax}{\setkomavar{fromfax}{+49\,531\,391-\usekomavar{fromfaxdirect}}}

\newcommand{\checkmissingvar}[1]{\ifkomavarempty{#1}{\setkomavar{#1}{{\ttfamily[#1]}}\ClassWarning{tubslttr2}{Set komavar #1}}{\relax}}

\checkmissingvar{frominstitute}
\checkmissingvar{fromstreet}
\checkmissingvar{fromzipcode}
\checkmissingvar{fromtown}
\checkmissingvar{fromemail}
\checkmissingvar{fromname}
\checkmissingvar{signature}

\setkomavar{location}{\footnotesize \sffamily
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

}

\pagestyle{headings}