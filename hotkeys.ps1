$map = Get-Content "C:\dev\other\hotkeys\map.json" | ConvertFrom-Json
$urls = $map.urls
$directories = $map.directories

while ($true) {
  $key = [System.Console]::ReadKey($true)
  if ($key.KeyChar -ne 0) {
    $ch = $key.Key.ToString().ToLower()
    if ($ch -eq 'x') {
      exit
    }
    if ($null -ne $urls.PSObject.Properties[$ch]) {
      Start-Process $urls.PSObject.Properties[$ch].Value
      exit
    } elseif ($null -ne $directories.PSObject.Properties[$ch]) {
      Invoke-Item $directories.PSObject.Properties[$ch].Value
      exit
    } elseif ($ch -eq 'spacebar') {
      Clear-Host
      $map.PSObject.Properties | ForEach-Object {
        $separator = "-" * $_.Name.Length
        Write-Host @"
$separator
$($_.Name.toUpper())
$separator
"@ -ForegroundColor Green          
        $_.Value.PSObject.Properties | ForEach-Object {
          Write-Host $_.Name.toUpper() -f Cyan -NoNewline;
          Write-Host " => " -f DarkGray -NoNewline;
          Write-Host $_.Value;
        }
      }
    } else {
      Clear-Host
      Write-Output "(0-o)"
    }
  }
}
 