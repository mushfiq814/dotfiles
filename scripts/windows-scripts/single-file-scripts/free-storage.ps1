$storage = Get-CimInstance -Class CIM_LogicalDisk | Select -ExpandProperty FreeSpace
$storage = [Math]::Round($storage / 1000000000, 2)
Write-Host "$($storage) GB"
