\RequirePackage{xkeyval}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptionsX

%pagenumber=botleft Seitennummern werden nach unten links gesetzt
%refline=nodate In der Geschäftszeile erscheint kein Datum
\LoadClass[pagenumber=botleft,refline=nodate]{scrlttr2}

%Anpassung des Datumsformats
\PassOptionsToPackage{ngerman, num}{isodate}
\RequirePackage{isodate}
\daymonthsepgerman{}
\monthyearsepgerman{}{}

%Die Basispakete des Corporate Design werden geladen
\RequirePackage{nexus}
\RequirePackage{tubscolors}
\RequirePackage{tubslogo}

%Positionierung des Seitenkopfs (Logo und rote Linie)
\@setplength{firstheadhpos}{1.75cm}
\@setplength{firstheadvpos}{1.75cm}
\@setplength{firstheadwidth}{18.5cm}

%Vergrößerung der Rückaddresszeile (da zweizeilig)
\@setplength{backaddrheight}{21pt}

%Positionierung des Locationfeldes (Informationen auf der rechten Seite)
\@setplength{lochpos}{-15.5cm}
\@setplength{locvpos}{4.7cm}
\@setplength{locwidth}{5.25cm}
\@setplength{locheight}{352pt}

%Positionierung der Geschäftszeile, bzw. da nicht vorhanden des Briefanfangs
\@setplength{refhpos}{2.4cm}
\@setplength{refwidth}{12.5cm}

%Anpassung der Textbreite
\setlength{\textwidth}{12.5cm}

%Anlegen von weiteren Komavariablen zur Unterstützung der lco-Dateien
%%Institutsdaten
\newkomavar{frominstitute}
\newkomavar{fromdepartment}
\newkomavar{fromstreet}
\newkomavar{fromtown}
%%Titel des Absenders
\newkomavar{fromtitle}
%%Telefon und Faxdurchwahl
\newkomavar{fromphonedirect}
\newkomavar{fromfaxdirect}
%%Referenzfeld Unser Schreiben vom:
\newkomavar{mymail}
%%Bank- und Steuerdaten
\newkomavar{fromIBAN}
\newkomavar{fromBIC}
\newkomavar{fromUStID}
\newkomavar{fromSteuernummer}

%Setzen der Schriftattribute
\setkomafont{addressee}{\sffamily}
\setkomafont{subject}{\sffamily}
\setkomafont{pageheadfoot}{\sffamily}
\setkomafont{backaddress}{\bfseries\sffamily}
\setkomafont{foldmark}{\color{tuRed}}
\AtBeginLetter{\sffamily}

%Siegelband und rote Linie im Kopf des Briefs
\setkomavar{firsthead}{\color{tuRed}\rule[-1.75cm]{18.5cm}{1pt}\\[-1.75cm]\tubslogo[0.9]\\[-1.3\tubslogoHeight]\parbox{0cm}{}\hfill\usekomavar{fromlogo}}

%Setzen des Locationfeldes am rechten Rand mit allen Absenderinformationen
\setkomavar{location}{%
\begin{flushleft}
%Wenn eine Durchwahl angegeben wurde, wird diese zusammengesetzt, ansonsten wird das komplette phone/fax Feld genutzt
\ifkomavarempty{fromphonedirect}{\relax}{\setkomavar{fromphone}{+49\,531\,391-\usekomavar{fromphonedirect}}}%
\ifkomavarempty{fromfaxdirect}{\relax}{\setkomavar{fromfax}{+49\,531\,391-\usekomavar{fromfaxdirect}}}%
\footnotesize\sffamily
Technische Universität\\Braunschweig\\
\textbf{\usekomavar{frominstitute}}\\
\ifkomavarempty{fromdepartment}
{\relax}
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
\ifkomavarempty{frombank}{\relax}{\usekomavar{frombank}\\~\\}
\ifkomavarempty{fromIBAN}{\relax}{IBAN: \usekomavar{fromIBAN}\\}
\ifkomavarempty{fromBIC}{\relax}{BIC (Swift Code): \usekomavar{fromBIC}\\}
\ifkomavarempty{fromUStID}{\relax}{USt.-ID-Nr.: \usekomavar{fromUStID}\\}
\ifkomavarempty{fromSteuernummer}{\relax}{Steuer-Nr.: \usekomavar{fromSteuernummer}}
\end{flushleft}
}

%Es werden Kopf- und Fußzeilen auf Folgeseiten gesetzt
\pagestyle{headings}
%Alle Felder werden aus der Geschäfszeile entfernt, damit diese in jedem Fall leer bleibt.
\removereffields

\setkomavar{backaddress}{\makebox[0pt][l]{\begin{tabular}[t]{l}
Technische Universität Braunschweig | \usekomavar{frominstitute}\\
\usekomavar{fromstreet} | \usekomavar{fromzipcode} \usekomavar{fromtown} | Deutschland
\end{tabular}}}

\setkomavar{nexthead}{
\begin{tabular}{l}
Technische Universität Braunschweig\\
\usekomavar{frominstitute}\\
\ifkomavarempty{fromdepartment}{\relax}{\usekomavar{fromdepartment}}
\end{tabular}
}

\renewcommand*{\raggedsignature}{\raggedright}