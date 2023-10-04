# WSL PowerShell Music Player Script
# Created By: Mushfiq Mahmud
# February 2021

# Get Passed in Duration
$mp3file = Get-Item $args[0] | Select -ExpandProperty FullName
$duration = $args[1]

# Check if filepath and duration exists, otherwise terminate
If ($mp3file -and $duration) {
  # Create Assembly and MusicPlayer Object
  Add-Type -AssemblyName PresentationCore
  $MediaPlayer = New-Object System.Windows.Media.Mediaplayer

  # Open Music File
  $MediaPlayer.Open($mp3file)

  # Play Music
  $MediaPlayer.Play()

  sleep $duration
}
Else {
  Write-Host "Either filename or duration was not provided. Exiting..."
  exit
}

# Stop Music
# $MediaPlayer.Stop()
