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

:: Validate search term
if "!SEARCH!"=="" (
  cls
  echo [91m┌─────────────────────────────────────────────────────────────┐[0m
  echo [91m│[0m               [93m[ERROR][0m Search term cannot be empty!              [91m│[0m
  echo [91m└─────────────────────────────────────────────────────────────┘[0m
  echo.
  echo Press any key to exit...
  pause >nul
  exit /b 1
)

:: Validate file type
if "!TYPE!"=="" set "TYPE=5"
set "TYPE_OK=0"
for %%t in (1 2 3 4 5 6) do if "%%t"=="!TYPE!" set "TYPE_OK=1"
if "!TYPE_OK!"=="0" (
  echo [93m┌─────────────────────────────────────────────────────────────┐[0m
  echo [93m│[0m  [91m[WARNING][0m Invalid type '!TYPE!', defaulting to All text-based  [93m│[0m
  echo [93m└─────────────────────────────────────────────────────────────┘[0m
  echo.
  set "TYPE=5"
)

:: Scan-Info
echo [90m┌─────────────────────────────────────────────────────────────┐[0m
echo [90m│[0m [96m🔍 SCANNING FILESYSTEM[0m                                    [90m│[0m
echo [90m├─────────────────────────────────────────────────────────────┤[0m
echo [90m│[0m  [93mSearch term:[0m !SEARCH!                                      [90m│[0m
if not "!EXCLUDE!"=="" echo [90m│[0m  [93mExcluding:[0m !EXCLUDE!                                       [90m│[0m
echo [90m│[0m                                                             [90m│[0m
echo [90m│[0m  [92mScanning in progress...[0m                                   [90m│[0m
echo [90m└─────────────────────────────────────────────────────────────┘[0m
echo.

:: PowerShell Scan
set "CFG=%TEMP%\seapcne_%RANDOM%.txt"
> "%CFG%" echo(!SEARCH!
>> "%CFG%" echo(!EXCLUDE!
>> "%CFG%" echo(!TYPE!
>> "%CFG%" echo(!SHOW!

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$cfg = '%CFG%'; ^
$v = Get-Content -Path $cfg; ^
$excludeRaw = $v[1]; ^
$excludeWords = @(); ^
if ($excludeRaw -ne '') { $excludeWords = $excludeRaw -split ',' ^| ForEach-Object { $_.Trim().ToLower() } }; ^
$search = $v[0]; ^
$type = $v[2]; ^
$showPreview = $v[3]; ^
switch ($type) { ^
  '1' { $extensions = '.json','.yaml','.yml','.toml','.conf','.config' } ^
  '2' { $extensions = '.txt','.log' } ^
  '3' { $extensions = '.js','.ts','.py','.java','.cpp','.c','.cs' } ^
  '4' { $extensions = '.html','.css','.php','.xml' } ^
  '5' { $extensions = '.json','.yaml','.yml','.toml','.conf','.config','.txt','.log','.js','.ts','.py','.java','.cpp','.c','.cs','.html','.css','.php','.xml' } ^
  '6' { $extensions = $null } ^
  default { $extensions = $null } ^
}; ^
$roots = @('%USERPROFILE%'); ^
$foundCount = 0; ^
$seen = @{}; ^
foreach ($root in $roots) { ^
  if (-not (Test-Path $root)) { continue }; ^
  Get-ChildItem -Path $root -Recurse -File -ErrorAction SilentlyContinue ^| Where-Object { ^
    $dir = $_.DirectoryName.ToLower(); ^
    foreach ($ex in $excludeWords) { ^
      if ($ex -and $dir.Contains($ex)) { return $false } ^
    }; ^
    if ($extensions -and $extensions -notcontains $_.Extension) { return $false }; ^
    return $true ^
  } ^| ForEach-Object { ^
    $path = $_.FullName; ^
    if ($seen.ContainsKey($path)) { return }; ^
    $seen[$path] = $true; ^
    try { ^
      $text = [System.IO.File]::ReadAllText($path) ^
    } catch { ^
      return ^
    }; ^
    if (-not $text.Contains($search)) { return }; ^
    $lines = [regex]::Split($text, '\r?\n'); ^
    $matchLines = $lines ^| Where-Object { $_ -and $_.Contains($search) }; ^
    $skip = $false; ^
    foreach ($ex in $excludeWords) { ^
      foreach ($line in $matchLines) { ^
        if ($line.ToLower().Contains($ex)) { $skip = $true; break } ^
      }; ^
      if ($skip) { break } ^
    }; ^
    if ($skip) { return }; ^
    $foundCount++; ^
    Write-Host ('[92m[FOUND][0m ' + $path); ^
    if ($showPreview -eq '1') { ^
      $first = $matchLines ^| Select-Object -First 1; ^
      if ($first) { ^
        $preview = if ($first.Length -gt 200) { $first.Substring(0, 200) } else { $first }; ^
        $preview = $preview -replace '[\n\r]+',' '; ^
        Write-Host ('[90m  └─ ' + $preview + '...[0m'); ^
        Write-Host '  [90m─────────────────────────────────────────────[0m' ^
      } ^
    } ^
  } ^
}; ^
Write-Host ''; ^
Write-Host ('[96m┌─────────────────────────────────────────────────────────────┐[0m'); ^
Write-Host ('[96m│[0m [92m✓ Scan completed![0m                                              [96m│[0m'); ^
Write-Host ('[96m│[0m [93m📊 Total matches found: [92m' + $foundCount + '[0m                              [96m│[0m'); ^
Write-Host ('[96m└─────────────────────────────────────────────────────────────┘[0m')"
del "%CFG%" >nul 2>&1

echo.
echo.
echo [90mPress any key to exit...[0m
pause >nul
exit
