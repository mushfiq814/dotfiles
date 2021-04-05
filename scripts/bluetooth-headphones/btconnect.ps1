$btcom = "C:\Program Files (x86)\Bluetooth Command Line Tools\bin\btcom.exe"
$deviceName = "WH-XB900N"

# disconnect first from voice (111e) and music (110b) service
$d1 = '& "$btcom" -n $deviceName -r -s110b'
$d2 = '& "$btcom" -n $deviceName -r -s111e'
Invoke-Expression $d1
Invoke-Expression $d2
# wait
Start-Sleep -Seconds 2
# # connect to voice (111e) and music (110b) service
$c1 = '& "$btcom" -n $deviceName -c -s110b'
$c2 = '& "$btcom" -n $deviceName -c -s111e'
Invoke-Expression $c1
Invoke-Expression $c2
