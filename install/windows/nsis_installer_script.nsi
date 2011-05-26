; Beispiel-Skript
Name "Tubs-Miktex-Installer V 0.2.2"
OutFile "Tubs-Miktex-Installer.exe"

!include "Registry.nsh"
!include "Sections.nsh"

; Get MikTeX installation directory from registry
Function .onInit
  ${registry::Open} "HKEY_LOCAL_MACHINE" "" $0
  ${registry::Read} "HKEY_LOCAL_MACHINE\SOFTWARE\MiKTeX.org\MikTeX\2.9\Core" "CommonInstall" $R0 $R1
  ;messageBox MB_OK "Hello world!$R0$R1"
  ${registry::Close} "$0"
  StrCpy $INSTDIR "$R0"
FunctionEnd

; Set default install dir
InstallDir $R0
DirText "Dies wird alle MikTeXtubs-Dateien auf Ihrem Computer installieren. Bitte wählen Sie das Verzeichnis Ihrer MikTeX-Installation."


Section
; The default installation directory
${registry::Open} "HKEY_LOCAL_MACHINE" "" $0
${registry::Read} "HKEY_LOCAL_MACHINE\SOFTWARE\MiKTeX.org\MikTeX\2.9\Core" "CommonInstall" $R0 $R1
;messageBox MB_OK "Hello world!$R0$R1"
${registry::Close} "$0"

SetOutPath $INSTDIR/
FILE /r data\tex
FILE /r data\doc
FILE /r data\fonts
ExecCmd::exec /TIMEOUT=10000 '"initexmf --admin --update-fndb"'
SectionEnd
