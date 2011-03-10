[KRITISCH]

\usepackage{uarial}%
gibt es bei mir nicht
 -> urw-arial
 
Linux-Lösung:
  sudo getnonfreefonts-sys -a
  bzw.
  sudo getnonfreefonts-sys arial-urw
  

---

[WICHTIG]

\addto\extrasgerman{\npdecimalsign{,}\npproductsign{\cdot}}%
\addto\extrasngerman{\npdecimalsign{,}\npproductsign{\cdot}}%
\addto\extrasaustrian{\npdecimalsign{,}\npproductsign{\cdot}}%
\addto\extrasnaustrian{\npdecimalsign{,}\npproductsign{\cdot}}%
\addto\extrasenglish{\npdecimalsign{.}\npproductsign{\cdot}}%
\addto\extrasamerican{\npdecimalsign{.}\npproductsign{\times}}%
benötigt \usepackage[ngerman]{babel} !

---

[INFO]

Benötigte Dateien:

beamercolorthemeTU-CD.sty
beamerinnerthemeTU-CD.sty
beamerouterthemeTU-CD.sty
beamerthemeTU-CD.sty
TU-CDcolors.sty
TU-logo.sty
TUBraunschweig-cmyk.pdf
TUBraunschweig-rgb.pdf

---

[KRITISCH]

Weglassen von Option
"t" zerhaut die Titelseite (rutscht nach unten)

<SOLVED>

---

[EYECANDY]

Farben von subsections im header grässlich (kaum zu erkennen).

---

[WICHTIG]

subsection im hearder verschiebt section im header

---


