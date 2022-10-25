$mem = Get-Counter '\Memory\Available MBytes' | Select -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue
$mem = [Math]::Round($mem / 1000, 2)
Write-Host "$($mem) MB"
