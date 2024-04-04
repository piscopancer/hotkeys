[string] $global:search = ''

$map = Get-Content "C:\dev\other\hotkeys\map.json" | ConvertFrom-Json
$urls = $map.urls

while ($true) {
  $key = [System.Console]::ReadKey($true)
  $ch = $key.KeyChar.ToString().ToLower()
  if ($key.Key -eq "Backspace" -and $global:search.Length -gt 0) {
    $global:search = $global:search.Remove($global:search.Length - 1, 1)
  } elseif ($key.KeyChar -ne 0) {
    $global:search += $ch
  }
  Clear-Host
  $global:search
  if ($null -ne $urls.PSObject.Properties[$global:search]) {
    $url = $urls.PSObject.Properties[$global:search]
    $url = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($url))
    Write-Host $url  
  }
}