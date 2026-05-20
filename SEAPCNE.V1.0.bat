@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

color 0A
mode con: cols=100 lines=35
title SEAPCNE - Smart File Scanner

cls
echo.
echo.
echo  [92m╔════════════════════════════════════════════════════════════════════════════╗[0m
echo  [92m║[0m                                                                                [92m║[0m
echo  [92m║[0m      [96m███████╗███████╗ █████╗ ██████╗  ██████╗███╗   ██╗███████╗[0m              [92m║[0m
echo  [92m║[0m      [96m██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝[0m              [92m║[0m
echo  [92m║[0m      [96m███████╗█████╗  ███████║██████╔╝██║     ██╔██╗ ██║█████╗  [0m              [92m║[0m
echo  [92m║[0m      [96m╚════██║██╔══╝  ██╔══██║██╔═══╝ ██║     ██║╚██╗██║██╔══╝  [0m              [92m║[0m
echo  [92m║[0m      [96m███████║███████╗██║  ██║██║     ╚██████╗██║ ╚████║███████╗[0m              [92m║[0m
echo  [92m║[0m      [96m╚══════╝╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝╚═╝  ╚═══╝╚══════╝[0m              [92m║[0m
echo  [92m║[0m                                                                                [92m║[0m
echo  [92m║[0m                    [93m▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀[0m                 [92m║[0m
echo  [92m║[0m                                                                                [92m║[0m
echo  [92m║[0m                    [95m🔍  Smart Enterprise Archive and Pattern Scanner[0m            [92m║[0m
echo  [92m║[0m                    [90mVersion 2.0 - Advanced Search and Filter System[0m          [92m║[0m
echo  [92m║[0m                                                                                [92m║[0m
echo  [92m╚════════════════════════════════════════════════════════════════════════════╝[0m
echo.
echo.

:: Eingaben
echo [96m┌─────────────────────────────────────────────────────────────┐[0m
echo [96m│[0m [93m🔎 Enter search term:[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
set /p "SEARCH=[96m│[0m [92m➤[0m "
echo [96m└─────────────────────────────────────────────────────────────┘[0m
echo.

echo [96m┌─────────────────────────────────────────────────────────────┐[0m
echo [96m│[0m [93m🚫 Exclude words (comma separated, optional):[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
set /p "EXCLUDE=[96m│[0m [92m➤[0m "
echo [96m└─────────────────────────────────────────────────────────────┘[0m
echo.

echo [96m┌─────────────────────────────────────────────────────────────┐[0m
echo [96m│[0m [93m📁 Select file type filter:[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
echo [96m│[0m                                                             [96m│[0m
echo [96m│[0m   [92m1[0m) Config files      [92m4[0m) Web files           [96m│[0m
echo [96m│[0m   [92m2[0m) Text files       [92m5[0m) All text-based     [96m│[0m
echo [96m│[0m   [92m3[0m) Code files       [92m6[0m) Everything         [96m│[0m
echo [96m│[0m                                                             [96m│[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
set /p "TYPE=[96m│[0m [92m➤[0m "
echo [96m└─────────────────────────────────────────────────────────────┘[0m
echo.

echo [96m┌─────────────────────────────────────────────────────────────┐[0m
echo [96m│[0m [93m📄 Show content preview?[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
echo [96m│[0m   [92m1[0m) Yes, show preview (max 200 chars)            [96m│[0m
echo [96m│[0m   [92m2[0m) No, just file paths                         [96m│[0m
echo [96m├─────────────────────────────────────────────────────────────┤[0m
set /p "SHOW=[96m│[0m [92m➤[0m "
echo [96m└─────────────────────────────────────────────────────────────┘[0m
echo.

:: Scan-Info (ohne Animation)
echo [90m┌─────────────────────────────────────────────────────────────┐[0m
echo [90m│[0m [96m🔍 SCANNING FILESYSTEM[0m                                    [90m│[0m
echo [90m├─────────────────────────────────────────────────────────────┤[0m
echo [90m│[0m  [93mSearch term:[0m %SEARCH%                                      [90m│[0m
if not "%EXCLUDE%"=="" echo [90m│[0m  [93mExcluding:[0m %EXCLUDE%                                       [90m│[0m
echo [90m│[0m                                                             [90m│[0m
echo [90m│[0m  [92mScanning in progress...[0m                                   [90m│[0m
echo [90m└─────────────────────────────────────────────────────────────┘[0m
echo.

:: PowerShell Scan
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$roots = @('%USERPROFILE%\.config','%USERPROFILE%','%APPDATA%','%LOCALAPPDATA%'); ^
$excludeRaw = '%EXCLUDE%'; ^
$excludeWords = @(); ^
if ($excludeRaw -ne '') { $excludeWords = $excludeRaw -split ',' ^| ForEach-Object { $_.Trim().ToLower() } }; ^
switch ('%TYPE%') { ^
 '1' { $ext = '.json','.yaml','.yml','.toml','.conf','.config' } ^
 '2' { $ext = '.txt','.log' } ^
 '3' { $ext = '.js','.ts','.py','.java','.cpp','.c','.cs' } ^
 '4' { $ext = '.html','.css','.php','.xml' } ^
 '5' { $ext = '.json','.yaml','.yml','.toml','.conf','.config','.txt','.log','.js','.ts','.py','.java','.cpp','.c','.cs','.html','.css','.php','.xml' } ^
 '6' { $ext = $null } ^
 default { $ext = '.txt' } ^
}; ^
$foundCount = 0; ^
foreach ($root in $roots) { ^
 if (Test-Path $root) { ^
  Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue ^| ^
  Where-Object { ^
   $skipPath = $false; ^
   $currentPath = $_.DirectoryName.ToLower(); ^
   foreach ($ex in $excludeWords) { ^
    if ($ex -ne '' -and $currentPath -match [regex]::Escape($ex)) { $skipPath = $true; break } ^
   }; ^
   if ($skipPath) { return $false }; ^
   if ($ext -eq $null -or $ext -contains $_.Extension) { return $true } else { return $false } ^
  } ^| ^
  Select-String -Pattern '%SEARCH%' -SimpleMatch -ErrorAction SilentlyContinue ^| ^
  ForEach-Object { ^
   $path = $_.Path; ^
   $text = ''; ^
   try { $text = Get-Content $path -Raw -ErrorAction SilentlyContinue } catch {}; ^
   $skipContent = $false; ^
   foreach ($ex in $excludeWords) { ^
    if ($ex -ne '' -and $text -match [regex]::Escape($ex)) { $skipContent = $true } ^
   }; ^
   if (-not $skipContent) { ^
    $foundCount++; ^
    Write-Host ('[92m[FOUND][0m ' + $path); ^
    if ('%SHOW%' -eq '1') { ^
     if ($text -and $text.Length -gt 0) { ^
      $preview = if ($text.Length -gt 200) { $text.Substring(0, 200) } else { $text }; ^
      $preview = $preview -replace '[\n\r]+',' '; ^
      Write-Host ('[90m  └─ ' + $preview + '...[0m'); ^
      Write-Host '  [90m─────────────────────────────────────────────[0m' ^
     } ^
    } ^
   } ^
  } ^
 } ^
}; ^
Write-Host ''; ^
Write-Host ('[96m┌─────────────────────────────────────────────────────────────┐[0m'); ^
Write-Host ('[96m│[0m [92m✓ Scan completed![0m                                              [96m│[0m'); ^
Write-Host ('[96m│[0m [93m📊 Total matches found: [92m' + $foundCount + '[0m                              [96m│[0m'); ^
Write-Host ('[96m└─────────────────────────────────────────────────────────────┘[0m')"

echo.
echo.
echo [90mPress any key to exit...[0m
pause >nul
exit
