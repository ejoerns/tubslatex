;; Tubslatex Installer
;; (c) 2013 by Enrico Joerns
;;

;; Project definitions
!define NAME    "tubslatex"
!define VERSION REPLACEWITHVERSION
!define TUBSLATEX_UNINST_REGDIR "Software\Microsoft\Windows\CurrentVersion\Uninstall\${NAME}"
!define TUBSLATEX_REGDIR "Software\	${NAME}"



;--------------------------------
;General

;; Name and file
Name "${NAME}"
BrandingText "TU Braunschweig" ; TODO: used?

OutFile "${NAME}Setup_${VERSION}.exe"


;--------------------------------
; Modern UI pre-settings

;; mult user settings
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
;; Page texts
!define MULTIUSER_INSTALLMODEPAGE_TEXT_TOP "$(STRING_INSTALLMODEPAGE_TEXT_TOP)"
!define MULTIUSER_INSTALLMODEPAGE_TEXT_ALLUSERS "$(STRING_TEXT_ALLUSERS)"
!define MULTIUSER_INSTALLMODEPAGE_TEXT_CURRENTUSER "$(STRING_TEXT_CURRENTUSER)"
;; installation default subdir
!define MULTIUSER_INSTALLMODE_INSTDIR "${NAME}"
;; registry keys
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_KEY "${TUBSLATEX_REGDIR}"
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_VALUENAME "InstallMode"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_KEY "${TUBSLATEX_REGDIR}"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_VALUENAME "InstallDir"
;; mode handler function
!define MULTIUSER_INSTALLMODE_FUNCTION setInstallMode
;; request highest possible execution level
!define MULTIUSER_EXECUTIONLEVEL Highest
;; Add custom function to .onGUIInit
!define MUI_CUSTOMFUNCTION_GUIINIT myGuiInit


;; load libs
!include "x64.nsh"
!include MultiUser.nsh
!include "MUI2.nsh"
!include "TextFunc.nsh"
!include "Sections.nsh"
!include nsDialogs.nsh
!include LogicLib.nsh


;--------------------------------
;Interface Settings

!define MUI_ABORTWARNING

;--------------------------------
;Pages

Var checkSecondCall
Var desiredInstallType

;; Install Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MULTIUSER_PAGE_INSTALLMODE 
!insertmacro MUI_PAGE_COMPONENTS 
;; Directory page
!define MUI_DIRECTORYPAGE_TEXT_TOP $(STRING_DIRECTORYPAGE_TEXT_TOP)
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

;; Uninstall Pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages


!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"

LangString STRING_PREVIOUS_INSTALL_FOUND ${LANG_ENGLISH} "Previous version of tubslatex detected: $tubslatexVersion.$\r$\nDo you want to continue installing Version ${VERSION}?"
LangString STRING_PREVIOUS_INSTALL_FOUND ${LANG_GERMAN} "Eine bereits installierte tubslatex-Version wurde gefunden: $tubslatexVersion.$\r$\nWollen Sie mit der Installation von Version ${VERSION} fortfahren?"

LangString STRING_TEXT_ALLUSERS ${LANG_ENGLISH} "Install for all users (global)"
LangString STRING_TEXT_ALLUSERS ${LANG_GERMAN} "F�r alle Benutzer installieren (global)"

LangString STRING_TEXT_CURRENTUSER ${LANG_ENGLISH} "Install for current user only (local)"
LangString STRING_TEXT_CURRENTUSER ${LANG_GERMAN} "Nur f�r diesen Benutzer installieren (lokal)"

LangString STRING_DIRECTORYPAGE_TEXT_TOP ${LANG_ENGLISH} "The contents my be installed in the MiKTeX installation directory. $\rBut it is recommended to choose a seperate folder or an already existing local TeX tree for installation."
LangString STRING_DIRECTORYPAGE_TEXT_TOP ${LANG_GERMAN} "Die Inhalte k�nnen im MiKTeX-Hauptverzeichnis installiert werden. $\rEs wird aber empfohlen ein unabh�ngiges Verzeichnis oder ein bereits vorhandenes lokales TeX-Verzeichnis zu w�hlen."

LangString STRING_INSTALLMODEPAGE_TEXT_TOP ${LANG_ENGLISH} "Note: A local installation will create a local database. As a result, global changes will be ignored henceforth."
LangString STRING_INSTALLMODEPAGE_TEXT_TOP ${LANG_GERMAN} "Hinweis: Eine lokale Installation legt eine lokale Datenbank an, wodurch globale �nderungen fortan ignoriert werden."

LangString STRING_MB_LOCALDB_FOUND ${LANG_ENGLISH} "Warning! Found local database!$\rSystem-wide installation my cause problems.$\r$\rDo you want to continue?"
LangString STRING_MB_LOCALDB_FOUND ${LANG_GERMAN} "Warnung! Lokale Datenbank gefunden!$\rEs k�nnen Probleme bei systemweiter Installation auftreten.$\r$\rTrotzdem Fortfahren?"

LangString STRING_MB_NOMIKTEX ${LANG_ENGLISH} "Error: MiKTeX not installed, cancelling installation"
LangString STRING_MB_NOMIKTEX ${LANG_GERMAN} "Fehler: Keine vorhandene MiKTeX-Installation gefunden, Installation wird abgebrochen."

LangString STRING_MB_UPDWRITE_FAILED ${LANG_GERMAN} "Fehler beim Schreiben der updmap.cfg!"
LangString STRING_MB_UPDWRITE_FAILED ${LANG_GERMAN} "Error while writing updmap.cfg!"

;--------------------------------
;Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Function for page jump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
 
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd


Var miktexRoots

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Note: Used MiKTeX registry keys for *writing* depend on tubslatex install type,
;       not on MiKteX install type!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function setInstallMode
  ; Prevent execution on first call
  ${If} $checkSecondCall != "OK"
    StrCpy $checkSecondCall "OK"
    Return
  ${EndIf}
  
  ; Test...
  ${If} $MultiUser.InstallMode == AllUsers
    StrCpy $desiredInstallType "global"
    ; Names of registry keys
    StrCpy $miktexRoots "CommonRoots"
    IfFileExists "$LOCALAPPDATA\MiKTeX\2.9\pdftex\config\pdftex.map" 0 +5
      MessageBox MB_YESNO "$(STRING_MB_LOCALDB_FOUND)" IDYES noskip
        StrCpy $R9 0 ;
        Call RelGotoPage
        Abort
    noskip:
  ${Else}
    StrCpy $desiredInstallType "local"
    ; Names of registry keys
    StrCpy $miktexRoots "UserRoots"
  ${EndIf}
FunctionEnd

;--------------------------------
;Functions

Var miktexVersion ; Detected Version of MiKTeX
Var miktexInstall ; key name for install dir

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tries to get Version number and shell context of MiKTeX
;; Aborts installation if no version was found
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function analyzeMiktex
  ; check in HKLM
  EnumRegKey $miktexVersion HKLM Software\MiKTeX.org\MiKTeX 0
  ${If} $miktexVersion == ""
    ; check in HKCU
    EnumRegKey $miktexVersion HKCU Software\MiKTeX.org\MiKTeX 0
    ${If} $miktexVersion == ""
      MessageBox MB_OK "$(STRING_MB_NOMIKTEX)"
      Abort "MiKTeX not installed, cancelling installation"
    ${Else}
      LogText "MiKTeX $miktexVersion user installation detected."
      DetailPrint "MiKTeX $miktexVersion user installation detected."
      StrCpy $miktexInstall "UserInstall"
    ${EndIf}
  ${Else}
    LogText "MiKTeX $miktexVersion system-wide installation detected."
    DetailPrint "MiKTeX $miktexVersion system-wide installation detected."
    StrCpy $miktexInstall "CommonInstall"
  ${EndIf}
FunctionEnd

Var tubslatexVersion ; Previous installation of tubslatex
Var tubslatexInstall ; Previous installation of tubslatex

Function analyzeTubslatex
  ; check if exists
  ; should be: SHCTX "Software\tubslatex" "InstallDir"
  ReadRegStr $tubslatexVersion HKLM "Software\tubslatex" "Version"
  ${If} $tubslatexVersion == ""
    ; check in HKCU
    ReadRegStr $tubslatexVersion HKCU "Software\tubslatex" "Version"
    ${If} $tubslatexVersion == ""
      LogText "previous tubslatex not found"
    ${Else}
      LogText "previous tubslatex $tubslatexVersion user installation detected."
    ${EndIf}
  ${Else}
    LogText "previous tubslatex $tubslatexVersion system-wide installation detected."
  ${EndIf}

  ; show message box if previous version was found
  ${If} $tubslatexVersion != ""
    MessageBox MB_YESNO "$(STRING_PREVIOUS_INSTALL_FOUND)" IDYES noabort
      DetailPrint "STOP: User aborted installation."
      Abort
    noabort:
  ${EndIf}
FunctionEnd


; StrContains
; This function does a case sensitive searches for an occurrence of a substring in a string. 
; It returns the substring if it is found. 
; Otherwise it returns null(""). 
; Written by kenglish_hi
; Adapted from StrReplace written by dandaman32
 
Var STR_HAYSTACK
Var STR_NEEDLE
Var STR_CONTAINS_VAR_1
Var STR_CONTAINS_VAR_2
Var STR_CONTAINS_VAR_3
Var STR_CONTAINS_VAR_4
Var STR_RETURN_VAR
 
!macro StrContainsMacro un
Function ${un}StrContains
  Exch $STR_NEEDLE
  Exch 1
  Exch $STR_HAYSTACK
  ; Uncomment to debug
;  MessageBox MB_OK 'STR_NEEDLE = $STR_NEEDLE STR_HAYSTACK = $STR_HAYSTACK '
    StrCpy $STR_RETURN_VAR ""
    StrCpy $STR_CONTAINS_VAR_1 -1
    StrLen $STR_CONTAINS_VAR_2 $STR_NEEDLE
    StrLen $STR_CONTAINS_VAR_4 $STR_HAYSTACK
    loop:
      IntOp $STR_CONTAINS_VAR_1 $STR_CONTAINS_VAR_1 + 1
      StrCpy $STR_CONTAINS_VAR_3 $STR_HAYSTACK $STR_CONTAINS_VAR_2 $STR_CONTAINS_VAR_1
      StrCmp $STR_CONTAINS_VAR_3 $STR_NEEDLE found
      StrCmp $STR_CONTAINS_VAR_1 $STR_CONTAINS_VAR_4 done
      Goto loop
    found:
      StrCpy $STR_RETURN_VAR $STR_NEEDLE
      Goto done
    done:
   Pop $STR_NEEDLE ;Prevent "invalid opcode" errors and keep the
   Exch $STR_RETURN_VAR  
FunctionEnd
!macroend

!insertmacro StrContainsMacro ""
!insertmacro StrContainsMacro "un."

!macro _StrContainsConstructor OUT NEEDLE HAYSTACK
  Push "${HAYSTACK}"
  Push "${NEEDLE}"
  Call StrContains
  Pop "${OUT}"
!macroend

!macro un_StrContainsConstructor OUT NEEDLE HAYSTACK
  Push "${HAYSTACK}"
  Push "${NEEDLE}"
  Call un.StrContains
  Pop "${OUT}"
!macroend
 
!define StrContains '!insertmacro "_StrContainsConstructor"'
!define un.StrContains '!insertmacro "un_StrContainsConstructor"'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Looks for the MiKTeX installation path and stores it under ${MiktexInstallPath}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function getMiktexInstallPath
  ;; Check if common directory was selected
  ${If} $miktexInstall == "CommonInstall"
    ReadRegStr $R0 HKLM "Software\MiKTeX.org\MiKTeX\$miktexVersion\Core" "$miktexInstall"
  ${Else}
    ReadRegStr $R0 HKCU "Software\MiKTeX.org\MiKTeX\$miktexVersion\Core" "$miktexInstall"
  ${EndIf}
  StrCmp $R0 "" 0 installDirReady
    DetailPrint "MiKTeX installation directory could not be detected, trying default..."
    StrCpy $R0 "$PROGRAMFILES\MiKTeX $miktexVersion"
  InstallDirReady:
  LogText "MiKTeX might be installed in $R0"
  !define MiktexInstallPath $R0
FunctionEnd




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adds the install directory to MiKTeX's UserRoots if required
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function addLocaltexmf
  ;; Test if MiKTeX installdir was selected, skip if true
  StrCmp ${MiktexInstallPath} $INSTDIR skipRootsUpdate
    ;; This part backs up already existing local texmf root paths and adds the new one
    LogText "Installation in custom texmf directory"
    ReadRegStr $R0 SHCTX "Software\MiKTeX.org\MiKTeX\$miktexVersion\Core" "$miktexRoots"
    ;; Test if directory ist already listed in UserRoots, skip if true
    ${StrContains} $R1 $INSTDIR $R0
    StrCmp $R1 "" 0 skipRootsUpdate
      LogText "Adding $R1 to MikTeX root paths"
      WriteRegStr SHCTX "Software\MiKTeX.org\MiKTeX\$miktexVersion\Core" "$miktexRoots" "$INSTDIR;$R0"
  skipRootsUpdate:
FunctionEnd


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Adds specified data at the end of the specified file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function WriteToFile
 Exch $0 ;file to write to
 Exch
 Exch $1 ;text to write
 
  FileOpen $0 $0 a #open file
   FileSeek $0 0 END #go to end
   FileWrite $0 $1 #write to file
  FileClose $0
 
 Pop $1
 Pop $0
FunctionEnd
 
!macro WriteToFile String File
 Push "${String}"
 Push "${File}"
  Call WriteToFile
!macroend
!define WriteToFile "!insertmacro WriteToFile"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Searches in given updmap config file for given map definitions and
;; removes them if found.
;; Then this map information is simply added at the end of the file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function enableUpdmaps
	;; search for map an delete if found
	Exch $R0 ;map name
	Exch
	Exch $R1 ;updmap config file
	ClearErrors
	;messageBox MB_OK "File: $R1, Content: $R0";TODO 
	FileOpen $0 $R1 "r"                     ; open target file for reading
	GetTempFileName $R9                           ; get new temp file name
	FileOpen $1 $R9 "w"                           ; open temp file for writing
	loop:
		FileRead $0 $2                              ; read line from target file
		IfErrors done                               ; check if end of file reached
		${StrContains} $R2 $R0 $2
		StrCmp $R2 "" 0 loop
		;StrCmp $2 $R0 loop 0
		FileWrite $1 $2                             ; write changed or unchanged line to temp file
		Goto loop
	done:
		FileClose $0                                ; close target file
		FileClose $1                                ; close temp file
		Delete "file.txt"                           ; delete target file
		CopyFiles /SILENT $R9 $R1            				; copy temp file to target file
		Delete $R9                                  ; delete temp file
	;; add map
	${WriteToFile} "Map $R0$\r$\n" $R1
	IfErrors 0 +2
		messageBox MB_OK "$(STRING_MB_UPDWRITE_FAILED)"
FunctionEnd


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Searches in given updmap config file for given map definitions and
;; removes them if found.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function un.disableUpdmaps
	;; search for map an delete if found
	Exch $R0 ;map name
	Exch
	Exch $R1 ;updmap config file
	ClearErrors
	;messageBox MB_OK "File: $R1, Content: $R0"
	FileOpen $0 $R1 "r"                     ; open target file for reading
	GetTempFileName $R9                           ; get new temp file name
	FileOpen $1 $R9 "w"                           ; open temp file for writing
	loop:
		FileRead $0 $2                              ; read line from target file
		IfErrors done                               ; check if end of file reached
		${un.StrContains} $R2 $R0 $2
		StrCmp $R2 "" 0 loop
		;StrCmp $2 $R0 loop 0
		FileWrite $1 $2                             ; write changed or unchanged line to temp file
		Goto loop
	done:
		FileClose $0                                ; close target file
		FileClose $1                                ; close temp file
		Delete "file.txt"                           ; delete target file
		CopyFiles /SILENT $R9 $R1            				; copy temp file to target file
		Delete $R9                                  ; delete temp file
	;; add map
FunctionEnd


Var UpdmapDir

;-------------------------------------------------------------------------------
; Initial Section (hidden)
;-------------------------------------------------------------------------------
Section "-preinstall"

  ;; enables install logging
  LogSet On
  
  ;; check miktex installation
  Call analyzeMiktex
  
SectionEnd


;-------------------------------------------------------------------------------
; Installer Sections
;-------------------------------------------------------------------------------
Section "Nexus" SecNexus

  ;; Make sure that updmap.cfg exists, switch for local/global
  StrCpy $UpdmapDir "$APPDATA\MiKTeX\$miktexVersion\miktex\config\"
  SetOutPath $UpdmapDir
  FileOpen $9 "updmap.cfg" w
  FileClose $9

  SetOutPath "$INSTDIR"
	FILE /r data\fonts

	;; enable updmaps
  DetailPrint "Enabling Nexus font maps..."
	Push "$UpdmapDir\updmap.cfg"
	Push "NexusProSans.map"
	Call enableUpdmaps
	Push "$UpdmapDir\updmap.cfg"
	Push "NexusProSerif.map"
	Call enableUpdmaps

	;; run font update
  DetailPrint "Updating font database..."
	${If} $MultiUser.InstallMode == AllUsers
  	ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --admin --mkmaps"'
	${Else}
  	ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --mkmaps"'
	${EndIf}
SectionEnd


;-------------------------------------------------------------------------------
; Documentation Section
;-------------------------------------------------------------------------------
Section "Dokumentation" SecDoc

  ;; files to copy
  SetOutPath "$INSTDIR"
  DetailPrint "Copying documentation files..."
	FILE /r data\doc

SectionEnd


;-------------------------------------------------------------------------------
; tex Section
;-------------------------------------------------------------------------------
Section "tubslatex" SecTubslatex

  ;; files to copy
  SetOutPath "$INSTDIR"
	FILE /r data\tex

	;; run file db update script
  DetailPrint "Updating fndb..."
  ${If} $MultiUser.InstallMode == AllUsers
  	ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --admin --update-fndb"'
  ${Else}
  	ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --update-fndb"'
	${EndIf}

SectionEnd

;-------------------------------------------------------------------------------
; Post Install Section
;-------------------------------------------------------------------------------

Section "-postinst" SecPostInstall

  Call getMiktexInstallPath
  Call addLocaltexmf

  ;; Write program Information for later use
  WriteRegStr SHCTX "${TUBSLATEX_REGDIR}" "InstallDir" $INSTDIR
  WriteRegStr SHCTX "${TUBSLATEX_REGDIR}" "InstallMode" $MultiUser.InstallMode
  WriteRegStr SHCTX "${TUBSLATEX_REGDIR}" "Version" ${VERSION}

  ;; Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  ;; register uninstaller for windows uninstall manager
  WriteRegStr SHCTX "${TUBSLATEX_UNINST_REGDIR}" "DisplayName" "tubslatex -- LaTeX Coporate Design Templates"
  WriteRegStr SHCTX "${TUBSLATEX_UNINST_REGDIR}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
  WriteRegStr SHCTX "${TUBSLATEX_UNINST_REGDIR}" "DisplayVersion" "${VERSION}"
SectionEnd


;--------------------------------
;Language strings

LangString DESC_SecNexus ${LANG_ENGLISH} "Nexus-Schrift"
LangString DESC_SecNexus ${LANG_GERMAN} "Nexus font"

LangString DESC_SecTubslatex ${LANG_ENGLISH} "This includes the whole tubslatex installation."
LangString DESC_SecTubslatex ${LANG_GERMAN} "Enth�lt die gesamtes tubslatex-Installation."

LangString DESC_SecDoc ${LANG_ENGLISH} "tubslatex documentation"
LangString DESC_SecDoc ${LANG_GERMAN} "tubslatex-Dokumentation"

LangString DESC_AbortInstallation ${LANG_ENGLISH} "MiKTeX not installed. Canceling installation"
LangString DESC_AbortInstallation ${LANG_GERMAN} "MiKTeX ist nicht installiert. Installation wird abgebrochen."

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecNexus} $(DESC_SecNexus)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDoc} $(DESC_SecDoc)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecTubslatex} $(DESC_SecTubslatex)
!insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;Installer Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; .onInit
;; Tests if admin privileges are available. Stores in var $userrights
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function .onInit

  ;; check for os bit version (32/64)
  ${If} ${RunningX64}
    DetailPrint "64 Bit Windows detected"
    SetRegView 64
  ${Else}
    DetailPrint "32 Bit Windows detected"
    SetRegView 32
  ${EndIf}

  ;; Check user privileges
  !insertmacro MULTIUSER_INIT
  ;; Show language dialog
  !insertmacro MUI_LANGDLL_DISPLAY
  
FunctionEnd


Function myGuiInit
  ;; check for previous tubslatex installation
  Call analyzeTubslatex
FunctionEnd


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; un.onInit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Function un.onInit
  !insertmacro MULTIUSER_UNINIT
FunctionEnd


;-------------------------------------------------------------------------------
; Uninstaller Section
;-------------------------------------------------------------------------------
Section "Uninstall"

  Delete "$INSTDIR\Uninstall.exe"

  RMDir /r "$INSTDIR"

	Push "$APPDATA\MiKTeX\$miktexVersion\miktex\config\updmap.cfg"
	Push "NexusProSans.map"
  Call un.disableUpdmaps
	Push "$APPDATA\MiKTeX\$miktexVersion\miktex\config\updmap.cfg"
	Push "NexusProSerif.map"
  Call un.disableUpdmaps
  
  ${If} $MultiUser.InstallMode == AllUsers
    ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --admin --update-fndb"'
  ${Else}
    ExecCmd::exec /TIMEOUT=60000 '"initexmf -v --update-fndb"'
  ${EndIf}

  DeleteRegKey /ifempty SHCTX "Software\tubslatex"
  
  ;; Delete from windows uninstall list
	DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\tubslatex"

SectionEnd

; TODO: Test + Behandlung alter tusblatex-Installation?
; TODO: user roots aus MiKTeX bei Deinstallation cond. entfernen

