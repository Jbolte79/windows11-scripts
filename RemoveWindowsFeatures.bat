rem # Disable and remove Windows features
rem # Windows update services required for DISM
rem # "DISM /online /get-features /format:table" shows installed features
rem # "Get-WindowsOptionalFeature -Online" shows installed features

rem # Possible AUTO-REBOOT if ran without admin privileges

PAUSE

reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Start" /t REG_DWORD /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\InventorySvc" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "2" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d "3" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Winmgmt" /v "Start" /t REG_DWORD /d "2" /f

net start UsoSvc
net start wisvc
net start wuauserv
net start BITS
net start TrustedInstaller
net start WaaSMedicSvc
net start cryptsvc
net start InventorySvc
net start DoSvc
net start DiagTrack
net start Appinfo
net start Winmgmt

rem Enable and start WMI

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Winmgmt" /v "Start" /t REG_DWORD /d "2" /f
sc config winmgmt start= auto
net start winmgmt

rem # Enable PowerShell

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "powershell.exe" /t REG_DWORD /d "0" /f

powershell.exe Enable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root

rem TLS 1.2 or lower is required for Windows Update to work, TLS 1.3 not supported yet
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /v "Enabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /v "DisabledByDefault" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client" /v "Enabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client" /v "DisabledByDefault" /t REG_DWORD /d "0" /f

Dism /Online /Disable-Feature /FeatureName:MediaPlayback /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:MSRDC-Infrastructure /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Printing-Foundation-Features /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Printing-XPSServices-Features /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:SMB1Protocol /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:SearchEngine-Client-Package /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:WCF-TCP-PortSharing45 /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Windows-Defender-Default-Definitions /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:WorkFolders-Client /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:NetFx3 /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:LegacyComponents /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:DirectPlay /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-All
Dism /Online /Disable-Feature /FeatureName:Client-ProjFS /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:TelnetClient /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:TFTP /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:TIFFIFilter /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:NetFx4-AdvSrvs /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:WCF-Services45 /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:SimpleTCP /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Microsoft-RemoteDesktopConnection /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:DirectoryServices-ADAM-Client /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:SmbDirect /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:MSRDC-Infrastructure /Quiet /NoRestart
Dism /Online /Disable-Feature /FeatureName:Recall /Quiet /NoRestart

dism /online /Remove-Package /PackageName:Microsoft-Windows-HVSI-Components-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-CodeIntegrity-Diagnostics-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-HypervisorEnforcedCodeIntegrity-Sysprep-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-HypervisorEnforcedCodeIntegrity-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-OneCore-VirtualizationBasedSecurity-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-DeviceGuard-GPEXT-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Nis-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Management-Powershell-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Management-MDM-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Management-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Group-Policy-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Core-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Client-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-ApplicationGuard-Inbox-WOW64-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-ApplicationGuard-Inbox-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-AppLayer-Group-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-AM-Default-Definitions-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-AM-Default-Definitions-OptionalWrapper-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-ApplicationGuard-Inbox-Package /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-Group-Policy-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-HVSI-Components-WOW64-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-HVSI-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-HVSI-WOW64-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-SecurityCenter /NoRestart
dism /online /Remove-Package /PackageName:Multimedia-RestrictedCodecsDolby /NoRestart
dism /online /Remove-Package /PackageName:RemoteDesktopServices-Base-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-SMB /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-Smb /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-Telnet-Client-Opt /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-Telnet-Client-FOD-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-TFTP-Client-FOD-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-WMPNetworkSharingService /NoRestart
dism /online /Remove-Package /PackageName:OpenSSH-Client /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-Internet-Browser-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-MicrosoftEdgeDevToolsClient-Package /NoRestart
dism /online /Remove-Package /PackageName:Microsoft-hyper-v-all /NoRestart
dism /online /Remove-Package /PackageName:Client-ProjFS /NoRestart
dism /online /Remove-Package /PackageName:TelnetClient /NoRestart
dism /online /Remove-Package /PackageName:TFTP /NoRestart
dism /online /Remove-Package /PackageName:TIFFIFilter /NoRestart
dism /online /Remove-Package /PackageName:NetFx4-AdvSrvs /NoRestart
dism /online /Remove-Package /PackageName:WCF-Services45 /NoRestart

dism /online /Remove-Package /PackageName:VirtualMachinePlatform /NoRestart
dism /online /Remove-Package /PackageName:HypervisorPlatform /NoRestart
dism /online /Remove-Package /PackageName:Containers /NoRestart
dism /online /Remove-Package /PackageName:Windows-Defender-ApplicationGuard /NoRestart
dism /online /Remove-Package /PackageName:Containers-DisposableClientVM /NoRestart

powershell Remove-WindowsCapability -Name Realtek -Online
powershell Remove-WindowsCapability -Name Vmware -Online
powershell Remove-WindowsCapability -Name InternetExplorer -Online
powershell Remove-WindowsCapability -Name StepsRecorder -Online
powershell Remove-WindowsCapability -Name WindowsMediaPlayer -Online
powershell Remove-WindowsCapability -Name Wallpapers -Online
powershell Remove-WindowsCapability -Name Print -Online
powershell Remove-WindowsCapability -Name MathRecognizer -Online
powershell Remove-WindowsCapability -Name OpenSSH -Online
powershell Remove-WindowsCapability -Name QuickAssist -Online
powershell Remove-WindowsCapability -Name OneSync -Online
powershell Remove-WindowsCapability -Name LA57 -Online
powershell Remove-WindowsCapability -Name Virtual -Online
powershell Remove-WindowsCapability -Name Hello -Online

PAUSE
