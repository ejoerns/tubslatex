\RequirePackage{xkeyval}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptionsX
\LoadClass[pagenumber=botleft]{scrlttr2}

\RequirePackage{Nexus}
\RequirePackage[green]{tubscolors}
\RequirePackage{tubslogo}

\@setplength{lochpos}{-15.75cm}
\@setplength{locvpos}{4.7cm}
\@setplength{locwidth}{4.75cm}

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

\firsthead{\color{tuRed}\rule[-1.75cm]{17.6cm}{1pt}\\[-1.75cm]
\tubslogo[0.9]
}

\setkomavar{backaddress}{
\begin{tabular}{l}
Technische Universität Braunschweig | \usekomavar{frominstitute}\\
\usekomavar{fromstreet} | \usekomavar{fromzipcode} \usekomavar{fromtown} | Deutschland
\end{tabular}
}

\setkomafont{addressee}{\sffamily}
\setkomafont{backaddress}{\bfseries\sffamily}

\nexthead{
\begin{tabular}{l}
Technische Universität Braunschweig\\
\usekomavar{frominstitute}\\
\ifkomavarempty{fromdepartment}{\relax}{\usekomavar{fromdepartment}
}
\end{tabular}
}

\setkomavar{fromphone}{+49\,531\,391-\usekomavar{fromphonedirect}}
\setkomavar{fromfax}{+49\,531\,391-\usekomavar{fromfaxdirect}}

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
\usekomavar{fromtitle}\\
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