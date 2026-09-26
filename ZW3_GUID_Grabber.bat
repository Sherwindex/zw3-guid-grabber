@echo off
title Get Game GUID for ZW3
color 05

echo.
echo  ==============================
echo    ZW3 Game GUID Grabber
echo  ==============================
echo.

where powershell >nul 2>&1
if errorlevel 1 (
    color 0C
    echo  ERROR: PowerShell was not found on this system.
    echo  This tool requires PowerShell, which ships with Windows by default.
    echo  If it's missing or blocked here, ask whoever manages this PC to
    echo  re-enable it, or run the tool on a different machine.
    echo.
    set /p dummy="  Press Enter to close..."
    exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ErrorActionPreference = 'SilentlyContinue';" ^
  "$gameDir = $null;" ^
  "$q = [char]34; $pattern = $q + 'path' + $q + '\s*' + $q + '([^' + $q + ']+)' + $q; $steamPath = (Get-ItemProperty -Path 'HKCU:\Software\Valve\Steam' -ErrorAction SilentlyContinue).SteamPath; if ($steamPath) { $steamPath = $steamPath -replace '/', '\'; $vdf = Join-Path $steamPath 'steamapps\libraryfolders.vdf'; if (Test-Path $vdf) { $libPaths = Select-String -Path $vdf -Pattern $pattern -ErrorAction SilentlyContinue | ForEach-Object { $_.Matches[0].Groups[1].Value -replace '\\\\','\' }; foreach ($lib in $libPaths) { $candidate = Join-Path $lib 'steamapps\common\Call of Duty Modern Warfare 2'; if (Test-Path $candidate) { $gameDir = $candidate; break } } } }" ^
  "if (-not $gameDir) { $proc = Get-Process -Name 'zw3','iw4x' -ErrorAction SilentlyContinue | Select-Object -First 1; if ($proc -and $proc.Path) { $gameDir = Split-Path $proc.Path -Parent } }" ^
  "if (-not $gameDir) { Write-Host '  ERROR: Could not locate your Modern Warfare 2 install folder.' -ForegroundColor Magenta; Write-Host '  Make sure MW2 is installed via Steam, or start the game and try again.' -ForegroundColor Magenta; exit 1 }" ^
  "$guid = $null; $source = $null;" ^
  "$logFiles = Get-ChildItem -Path $gameDir -Filter 'games_mp.log' -Recurse -ErrorAction SilentlyContinue;" ^
  "if ($logFiles) { $logFile = $logFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 1; $joinLine = Get-Content $logFile.FullName -ErrorAction SilentlyContinue | Select-String '^\s*[0-9: ]+J;' | Select-Object -Last 1; if ($joinLine) { $parts = $joinLine.Line -split ';'; if ($parts.Count -ge 2) { $guid = $parts[1].Trim().ToLower(); $source = $logFile.FullName } } }" ^
  "if (-not $guid) { $scriptDataDir = Join-Path $gameDir 'userraw\scriptdata'; if (-not (Test-Path $scriptDataDir)) { $found = Get-ChildItem -Path $gameDir -Directory -Recurse -Filter 'scriptdata' -ErrorAction SilentlyContinue | Select-Object -First 1; $scriptDataDir = if ($found) { $found.FullName } else { $null } }; if ($scriptDataDir) { $rankFiles = Get-ChildItem -Path $scriptDataDir -Filter 'rank_*' -File -ErrorAction SilentlyContinue | Where-Object { $_.BaseName -match '^rank_[0-9a-fA-F]{16}$' }; if ($rankFiles) { $rankFile = $rankFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 1; $guid = $rankFile.BaseName.Substring(5).ToLower(); $source = $rankFile.FullName } } }" ^
  "if (-not $guid) { Write-Host '  ERROR: Could not find your GUID (checked games_mp.log and rank_ files).' -ForegroundColor Magenta; Write-Host '  Load into a match first (a private match works), then run this again.' -ForegroundColor Magenta; exit 1 }" ^
  "Set-Clipboard -Value $guid;" ^
  "Write-Host ('  Your GUID: ' + $guid) -ForegroundColor Magenta;" ^
  "Write-Host ('  (from: ' + $source + ')') -ForegroundColor DarkGray;" ^
  "Write-Host '';" ^
  "Write-Host '  Next step:' -ForegroundColor Magenta;" ^
  "Write-Host '  1. Go to https://stats.zw3.eu/settings' -ForegroundColor White;" ^
  "Write-Host '  2. Paste your GUID into the Game GUID box (Ctrl+V)' -ForegroundColor White;" ^
  "Write-Host '  3. Click Save settings to link it to your Discord' -ForegroundColor White;" ^
  "exit 0"

if %errorlevel% equ 0 (
    echo.
    echo  Copied to clipboard!
) else (
    color 05
)

echo.
set /p dummy="  Press Enter to close..."
