[string] $global:search = ''

$mapRaw = Get-Content "C:\dev\other\hotkeys\map.json"
$mapRaw = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes($mapRaw))
$map = $mapRaw | ConvertFrom-Json
$urls = $map.urls
$directories = $map.directories

function Write-Hotkeys {
  Clear-Host
  $map.PSObject.Properties | ForEach-Object {
    $separator = "-" * $_.Name.Length
    Write-Host @"
$separator
$($_.Name.toUpper())
$separator
"@ -ForegroundColor DarkGray
    [int] $longest = ($_.Value.PSObject.Properties.Name | Measure-Object -Property Length -Maximum).Maximum
    $_.Value.PSObject.Properties | ForEach-Object {
      Write-Host $_.Name.toUpper() -f Yellow -NoNewline;
      Write-Host (" " * ($longest - $_.Name.Length)) -NoNewline;
      Write-Host " | " -f DarkGray -NoNewline;
      Write-Host $_.Value.description;
    }
  }
}

while ($true) {
  $key = [System.Console]::ReadKey($true)
  $ch = $key.KeyChar.ToString().ToLower()
  Clear-Host
  switch ($key.Key) {
    "Backspace" { 
      $global:search = ""
    }
    "Spacebar" {
      Write-Hotkeys
    }
    "$($map.other.exit.key)" {
      exit
    }
    default {
      if ($key.KeyChar -ne 0) {
        $global:search = $global:search + $ch
      }
    }
  }
  Write-Host $global:search -b White -f Black -NoNewline
  [System.Object[]] $suggestions = @()
  ([psobject] $urls.psobject).Properties | ForEach-Object {
    if ($_.Name.StartsWith($global:search) -and $_.Name -ne $global:search) {
      $suggestions += $_
    }
  }
  if ($global:search.Length -gt 0 -and $suggestions.Length -gt 0) {
    Write-Host ""
    foreach ($m in $suggestions) {
      Write-Host "$($m.Name) $($m.Value.description)" -f DarkGray
    }
  }
  $urlMatch = $urls.PSObject.Properties[$global:search]
  $directoryMatch = $directories.PSObject.Properties[$global:search]
  if ($null -ne $urlMatch) {
    Start-Process $urlMatch.Value.url
    exit
  } elseif ($null -ne $directoryMatch) {
    Invoke-Item $directoryMatch.Value.url
    exit
  }
}

