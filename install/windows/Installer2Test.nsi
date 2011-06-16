;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "MiKTeX Installer2 Test"
  OutFile "Installer2Test.exe"

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\Modern UI Test"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Modern UI Test" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

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


;--------------------------------
;Installer Sections

Section "tubslatex" SecTubslatex

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...

  Call getMiktexInstallPath
  Call addLocaltexmf

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd


;--------------------------------
;Installer Functions

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

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
