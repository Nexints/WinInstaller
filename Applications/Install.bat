@echo off
echo Installing Applications / Removing Bloat(Stage 7)
reg add “HKEY_CURRENT_USER\Control Panel\Desktop” /v Wallpaper /t REG_SZ /d C:\Background.bmp /f
:: Edit past this part! Implement custom installations, use cmd tools, etc.
SET /P AREYOUSURE=Do you wish to remove Edge? This WILL Make your system unstable. (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO installapps
echo Removing Bloatware! (MSEdge, etc)
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /t REG_DWORD /d 0 /f
taskkill /f /im "msedge.exe"
powershell -ExecutionPolicy Bypass -Command "Get-AppxPackage *edge* | Remove-AppxPackage"
reg add "HKLM\System\CurrentControlset\Services\NlaSvc\Parameters\Internet" /v EnableActiveProbing /t REG_DWORD /d 0 /f
cd /d "%programfiles(x86)%\Microsoft\Edge\Application"
del *.* /f /s /q
cd ..
cd ..
rm /s /q Edge
cd /d "%userprofile%\Appdata\Roaming\Microsoft\Internet Explorer"
takeown /r /a /f "%userprofile%\Appdata\Roaming\Microsoft\Internet Explorer" /d Y
icacls "%userprofile%\Appdata\Roaming\Microsoft\Internet Explorer" /grant Administrators:F /T
del *.* /f /s /q
cd ..
rm /s /q "Internet Explorer"
cd /d "%userprofile%\Appdata\Local\Microsoft\Edge"
del *.* /f /s /q
cd ..
rm /s /q "Edge"
cd /d "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
takeown /r /a /f "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /d Y
icacls "C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /grant Administrators:F /T /C
del *.* /f /s /q
cd ..
rm /s /q "Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
reg delete HKLM\Software\Microsoft\Edge /f
cd /d "%programfiles(x86)%\Internet Explorer"
takeown /r /a /f "%programfiles(x86)%\Internet Explorer" /d Y
icacls "%programfiles(x86)%\Internet Explorer" /grant Administrators:F /T
del *.* /f /s /q
cd ..
rm /s /q "Internet Explorer"
cd /d "%programfiles%\Internet Explorer"
takeown /r /a /f "%programfiles%\Internet Explorer" /d Y
icacls "%programfiles%\Internet Explorer" /grant Administrators:F /T
del *.* /f /s /q
cd ..
rm /s /q "Internet Explorer"
cd /d "C:\RestoreBackup\Applications"
SET /P AREYOUSURE=Do you wish to remove other bloatware? This WILL Make your system very unstable. If using Language EN_GB, press No.(Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO installapps
powershell -ExecutionPolicy Bypass -Command ".\Windows10Debloater.ps1"
goto InstallApps
:InstallApps
echo Installing (Notepad, Paint, Firefox, Java, VLC)
echo Installing Notepad++!
.\npp.exe /S
echo Installing Paint!
msiexec /i paint.msi /quiet
echo Installing Firefox!
msiexec /i Firefox.msi /quiet /norestart
echo Installing AdoptOpenJDK!
msiexec /i AdoptOpenJDK.msi ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome INSTALLDIR="c:\Program Files\Temurin\" /quiet
echo Installing VLC Media Player (3.0.19)
vlc.exe /L=1033 /S /NCRC

SET /P AREYOUSURE=Do you wish to install Content Creation Apps? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO gaming
echo Installing OBS!
.\OBS.exe /S
echo Installing Davinci Resolve!
.\Davinci.exe /i /q
goto gaming

:gaming
SET /P AREYOUSURE=Do you wish to install Gaming apps? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO misc
echo Installing Minecraft!
msiexec /i MinecraftInstaller.msi INSTALLDIR=C:\Minecraft /passive
echo Installing Steam!
.\SteamSetup.exe /S
echo Installing Osu!
.\Osu.exe
goto officework

:officework
SET /P AREYOUSURE=Do you wish to install Office / Work apps? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO misc
echo Installing Libreoffice!
msiexec /i LibreOffice.exe /quiet
goto misc

:misc
SET /P AREYOUSURE=Do you wish to install Misc apps? (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO end
echo Installing CrystalDiskInfo!
.\CrystalDiskInfo.exe /VERYSILENT /NORESTART
goto end

:: Don't edit this part.
:end
echo Done! Press any key to delete the RestoreBackup folder!
notepad ./Read\ me.txt
pause
cd C:\
rmdir "C:\Temp" /s /q
rmdir "C:\RestoreBackup" /s /q
