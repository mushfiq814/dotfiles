
# CPU Load
$cpu = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select -ExpandProperty Average

# Free space on storage
$storage = Get-CimInstance -Class CIM_LogicalDisk | Select -ExpandProperty FreeSpace
$storage = [Math]::Round($storage / 1000000000, 2)
$storage = "$($storage) GB"

# RAM usage
$mem = Get-Counter '\Memory\Available MBytes' | Select -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue
$mem = [Math]::Round($mem / 1000, 2)
$mem = "$($mem) MB"

# Wifi Name
$wifi_name = (netsh wlan show interfaces | Select-String -Pattern "^\s+SSID\s*: (.*)$").Matches.Groups[1].Value

# Wifi Speed
$wifi_speed = Get-NetAdapter | ? Name -eq Wi-Fi | Select -ExpandProperty LinkSpeed

Write-Host $cpu
Write-Host $storage
Write-Host $mem
Write-Host $wifi_name
Write-Host $wifi_speed
