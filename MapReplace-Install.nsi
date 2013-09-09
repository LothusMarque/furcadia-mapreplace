; The name of the installer
Name "MapReplace"

; The file to write
OutFile "MapReplace-Setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\MapReplace

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\MapReplace" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

; External license file.
LicenseData "license.txt"
;--------------------------------

; Pages
Page license
Page components
Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Install FIles"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /oname=MRGUI.exe "bin\MRGUI.exe" ; Default project output isn't the main folder.
  File /oname=MapReplace.exe "bin\MapReplace.exe"
  File "Source.7z"
  File "license.txt"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\MapReplace "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MapReplace" "DisplayName" "MapReplace"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MapReplace" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MapReplace" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MapReplace" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\MapReplace"
  CreateShortCut "$SMPROGRAMS\MapReplace\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\MapReplace\MapReplace.lnk" "$INSTDIR\MRGUI.exe" "" "$INSTDIR\MRGUI.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MapReplace"
  DeleteRegKey HKLM SOFTWARE\MapReplace

  ; Remove files and uninstaller
  Delete $INSTDIR\*.*
  RMDir "$INSTDIR"
  
  ; Delete shortcuts
  delete "$SMPROGRAMS\MapReplace\*.lnk"
  RMDir "$SMPROGRAMS\MapReplace"

SectionEnd
