# Used to send a windows notification
# Source: https://den.dev/blog/powershell-windows-notification/
function Show-Notification {
  [cmdletbinding()]
  Param (
    [string]
    $ToastTitle,
    [string]
    [parameter(ValueFromPipeline)]
    $ToastText,
    [string]
    $ToastFrom
  )

  [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
  $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)

  $RawXml = [xml] $Template.GetXml()
  ($RawXml.toast.visual.binding.text|where {$_.id -eq "1"}).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
  ($RawXml.toast.visual.binding.text|where {$_.id -eq "2"}).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

  $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
  $SerializedXml.LoadXml($RawXml.OuterXml)

  $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
  $Toast.Tag = $ToastFrom
  $Toast.Group = $ToastFrom
  $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

  $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($ToastFrom)
  $Notifier.Show($Toast);
}
