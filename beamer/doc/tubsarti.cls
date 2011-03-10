\LoadClass{scrartcl}

\RequirePackage{xkeyval}
\RequirePackage{ifthen}
\RequirePackage{xcolor}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\input{colors}
\ProcessOptionsX

\input{font}
\input{titlepage}