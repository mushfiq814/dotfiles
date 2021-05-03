$btcom = "C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom.exe"
$deviceName = "WH-XB900N"

# disconnect first from voice (111e) and music (110b) service
Write-Host "disconnecting $deviceName from music service"
Invoke-Expression '& "$btcom" -n $deviceName -r -s110b'
Write-Host "disconnecting $deviceName from voice service"
Invoke-Expression '& "$btcom" -n $deviceName -r -s111e'

# wait
Start-Sleep -Seconds 2

# connect to voice (111e) and music (110b) service
Write-Host "reconnecting $deviceName to music service"
Invoke-Expression '& "$btcom" -n $deviceName -c -s110b'
Write-Host "reconnecting $deviceName to voice service"
Invoke-Expression '& "$btcom" -n $deviceName -c -s111e'
