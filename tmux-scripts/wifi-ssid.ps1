(netsh wlan show interfaces | Select-String -Pattern "^\s+SSID\s*: (.*)$").Matches.Groups[1].Value

