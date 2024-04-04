[string] $global:search = ''

$mapRaw = Get-Content "C:\dev\other\hotkeys\map.json"
$mapRaw = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($mapRaw))
$map = $mapRaw | ConvertFrom-Json
[psobject] $urls = $map.urls.PSObject

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
  Write-Host $urls.ToString() | Select-Object -Property $_.Name
  $urls.Properties[$global:search].Value | Select-Object
  if ($null -ne $urls.Properties[$global:search]) {
    Write-Host $url  
  }
}