;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  !include "TextFunc.nsh"

;--------------------------------
;General

  ;Name and file
  Name "tubslatex"
  OutFile "Installer2Test.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\tubslatex"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\tubslatex" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

	;; Directory page
  !define MUI_DIRECTORYPAGE_TEXT_TOP "Die Inhalte können im MiKTeX-Hauptverzeichnis installiert werden. $\rEs wird aber empfohlen ein unabhängiges Verzeichnis oder ein bereits vorhandenes lokales TeX-Verzeichnis zu wählen."

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  ;!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "German"

;--------------------------------
;Functions


Function FileSearch
Exch $R0 ;search for
Exch
Exch $R1 ;input file
Push $R2
Push $R3
Push $R4
Push $R5
Push $R6
Push $R7
Push $R8
Push $R9
 
  StrLen $R4 $R0
  StrCpy $R7 0
  StrCpy $R8 0
 
  ClearErrors
  FileOpen $R2 $R1 r
  IfErrors Done
 
  LoopRead:
    ClearErrors
    FileRead $R2 $R3
    IfErrors DoneRead
 
    IntOp $R7 $R7 + 1
    StrCpy $R5 -1
    StrCpy $R9 0
 
    LoopParse:
      IntOp $R5 $R5 + 1
      StrCpy $R6 $R3 $R4 $R5
      StrCmp $R6 "" 0 +4
        StrCmp $R9 1 LoopRead
          IntOp $R7 $R7 - 1
          Goto LoopRead
      StrCmp $R6 $R0 0 LoopParse
        StrCpy $R9 1
        IntOp $R8 $R8 + 1
        Goto LoopParse
 
  DoneRead:
    FileClose $R2
  Done:
    StrCpy $R0 $R8
    StrCpy $R1 $R7
 
Pop $R9
Pop $R8
Pop $R7
Pop $R6
Pop $R5
Pop $R4
Pop $R3
Pop $R2
Exch $R1 ;number of lines found on
Exch
Exch $R0 ;output count found
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
 
Function StrContains
  Exch $STR_NEEDLE
  Exch 1
  Exch $STR_HAYSTACK
  ; Uncomment to debug
  ;MessageBox MB_OK 'STR_NEEDLE = $STR_NEEDLE STR_HAYSTACK = $STR_HAYSTACK '
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
 
!macro _StrContainsConstructor OUT NEEDLE HAYSTACK
  Push "${HAYSTACK}"
  Push "${NEEDLE}"
  Call StrContains
  Pop "${OUT}"
!macroend
 
!define StrContains '!insertmacro "_StrContainsConstructor"'

;; Looks for the MiKTeX installation path and stores it under ${MiktexInstallPath}
Function getMiktexInstallPath
  ;; Check if common directory was selected
  ReadRegStr $R0 HKLM "Software\MiKTeX.org\MiKTeX\2.9\Core" "CommonInstall"
  StrCmp $R0 "" 0 installDirReady
  StrCpy $R0 "$PROGRAMFILES\MiKTeX 2.9"
  InstallDirReady:
  messageBox MB_OK " Ok, MiKTeX is installed in $R0"
  !define MiktexInstallPath $R0
FunctionEnd

;; Adds the install directory to MiKTeX's UserRoots if required
Function addLocaltexmf
  ;; Test if MiKTeX installdir was selected, skip if true
  StrCmp ${MiktexInstallPath} $INSTDIR skipRootsUpdate
  ;; This part backs up already existing local texmf root paths and adds the new one
  ;; But it is not very flexible yet
  ReadRegStr $R0 HKCU "Software\MiKTeX.org\MiKTeX\2.9\Core" "UserRoots"
  ;; Test if directory ist already listed in UserRoots, skip if true
  ${StrContains} $R1 $INSTDIR $R0
  StrCmp $R1 "" 0 skipRootsUpdate
  messageBox MB_OK "Updating UserRoots..."
  WriteRegStr HKCU "Software\MiKTeX.org\MiKTeX\2.9\Core" "UserRoots" "$INSTDIR;$R0"
  skipRootsUpdate:
FunctionEnd


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


Function enableUpdmaps
	;; search for map an delete if found
	Exch $R0 ;map name
	Exch
	Exch $R1 ;updmap config file
	ClearErrors
	messageBox MB_OK "File: $R1, Content: $R0"
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
FunctionEnd


;--------------------------------
;Installer Sections

Section "tubslatex" SecTubslatex

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...

  Call getMiktexInstallPath
  Call addLocaltexmf

	Push "$APPDATA\MiKTeX\2.9\miktex\config\updmap.cfg"
	Push "NexusProSans.map"
		Call enableUpdmaps
	Push "$APPDATA\MiKTeX\2.9\miktex\config\updmap.cfg"
	Push "NexusProSerif.map"
		Call enableUpdmaps


  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


;--------------------------------
;Installer Functions

Function .onInit

  ;!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd



;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecTubslatex ${LANG_ENGLISH} "This includes the whole tubslatex installation."
  LangString DESC_SecTubslatex ${LANG_GERMAN} "Enthält die gesamtes tubslatex-Installation."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecTubslatex} $(DESC_SecTubslatex)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Modern UI Test"

SectionEnd
