(Get-Process | Where-Object {$_.ProcessName -eq "vlc"} | Select-Object -ExpandProperty MainWindowTitle | Select-String -Pattern "(.*) - VLC media player").Matches.Groups[1].Value

