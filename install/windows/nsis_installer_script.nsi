; Beispiel-Skript
Name "MeinBeispiel"
OutFile "Tubs-Miktex-Installer.exe"

!include "Registry.nsh"
!include "Sections.nsh"

Function .onInit
  ${registry::Open} "HKEY_LOCAL_MACHINE" "" $0
  ${registry::Read} "HKEY_LOCAL_MACHINE\SOFTWARE\MiKTeX.org\MikTeX\2.9\Core" "CommonInstall" $R0 $R1
  ;messageBox MB_OK "Hello world!$R0$R1"
  ${registry::Close} "$0"
  StrCpy $INSTDIR "$R0"
FunctionEnd


InstallDir $R0
; The text to prompt the user to enter a directory
DirText "Dies wird alle MikTeXtubs-Dateien auf ihrem Computer installieren. Bitte wählen sie das Verzeichnis Ihrer MikTeX-Installation."


Section
; The default installation directory
${registry::Open} "HKEY_LOCAL_MACHINE" "" $0
${registry::Read} "HKEY_LOCAL_MACHINE\SOFTWARE\MiKTeX.org\MikTeX\2.9\Core" "CommonInstall" $R0 $R1
;messageBox MB_OK "Hello world!$R0$R1"
${registry::Close} "$0"

SetOutPath $INSTDIR/
FILE /r data\tex
SectionEnd