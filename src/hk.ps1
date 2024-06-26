﻿[string] $global:search = ''

$shortcutName = "hk.lnk"
$map = (Get-Content -Path "$((Get-Location).Path)\hk-map.json" -Encoding UTF8) | ConvertFrom-Json
$urls = $map.urls
$directories = $map.directories
$other = $map.other
$replacements = (Get-Content -Path "$((Get-Location).Path)\replacements.json" -Encoding UTF8) | ConvertFrom-Json

while ($true) {
  $_key = [System.Console]::ReadKey($true)
  $key = $_key.Key.ToString().ToLower()
  $ch = $_key.KeyChar.ToString().ToLower()
  Clear-Host
  if ($key -eq "backspace") {
    $global:search = ""
  } elseif ($key -eq $map.other.help.key) {
    Clear-Host
    $map.PSObject.Properties | ForEach-Object {
      [string] $groupname = $_.Name
      $line = "-" * $groupname.Length
      Write-Host @"
$line
$($_.Name.toUpper())
$line
"@ -ForegroundColor DarkGray
      [int] $longest = ($_.Value.PSObject.Properties.Name | Measure-Object -Property Length -Maximum).Maximum
      $_.Value.PSObject.Properties | ForEach-Object {
        if ($groupname -eq "other") {
          Write-Host $_.Value.key.toUpper() -f Yellow -NoNewline;
          Write-Host (" " * (12 - $_.Value.key.length)) -NoNewline;
          Write-Host " | " -f DarkGray -NoNewline;
          Write-Host $_.Value.description -f DarkGray;
        } else {
          Write-Host $_.Name.toUpper() -f Yellow -NoNewline;
          Write-Host (" " * ($longest - $_.Name.Length)) -NoNewline;
          Write-Host " | " -f DarkGray -NoNewline;
          Write-Host $_.Value.description;
        }
      }
    }
  } else {
    if ($key.KeyChar -ne 0) {
      $replacement = $replacements.PSObject.Properties[$ch] 
      if ($null -ne $replacement) {
        $ch = $replacement.Value
      }
      $global:search = $global:search + $ch
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
    foreach ($s in $suggestions) {
      Write-Host "$($s.Name) $($s.Value.description)" -f DarkGray
    }
  }

  $urlMatch = $urls.PSObject.Properties[$global:search].Value
  $directoryMatch = $directories.PSObject.Properties[$global:search].Value
  if ($null -ne $urlMatch) {
    Start-Process $urlMatch.url
    exit
  } elseif ($null -ne $directoryMatch) {
    Invoke-Item $directoryMatch.url
    exit
  } else {
    if ($global:search -eq $other.exit.key) {
      exit
    } elseif ($global:search -eq $other.checkStartup.key) {
      Write-Host ""
      if (Test-Path "C:\Users\$([Environment]::UserName)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\$shortcutName") {
        Write-Host "Автозагрузка включена (*^▽^*)" -f Green 
      } else {
        Write-Host "Не на автозагрузке (>'-'<)" -f Yellow
      }
      continue
    } elseif ($global:search -eq $other.root.key) {
      Invoke-Item (Get-Location).Path
      exit
    }
  }
}

