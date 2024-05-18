[Setup]
AppName=RuneFusion Launcher
AppPublisher=RuneFusion
UninstallDisplayName=RuneFusion
AppVersion=${project.version}
AppSupportURL=https://www.runefusion317.com/play
DefaultDirName={localappdata}\RuneFusion

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\RuneFusion.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=RuneFusionSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\RuneFusion.exe"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\RuneFusion.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs
Source: "${basedir}\app.ico"; DestDir: "{app}"
Source: "${basedir}\left.bmp"; DestDir: "{app}"
Source: "${basedir}\app_small.bmp"; DestDir: "{app}"

[Icons]
; start menu
Name: "{userprograms}\RuneFusion\RuneFusion"; Filename: "{app}\RuneFusion.exe"
Name: "{userprograms}\RuneFusion\RuneFusion (configure)"; Filename: "{app}\RuneFusion.exe"; Parameters: "--configure"
Name: "{userprograms}\RuneFusion\RuneFusion (safe mode)"; Filename: "{app}\RuneFusion.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\RuneFusion"; Filename: "{app}\RuneFusion.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\RuneFusion.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\RuneFusion.exe"; Description: "&Open RuneFusion"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\RuneFusion.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.runefusion\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"