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
  "$proc = Get-Process -Name 'zw3','iw4x' -ErrorAction SilentlyContinue | Select-Object -First 1;" ^
  "if (-not $proc) { Write-Host '  ERROR: zw3.exe / iw4x.exe is not running.' -ForegroundColor Magenta; Write-Host '  Start the game and load into a match (private match is fine), then run this again.' -ForegroundColor Magenta; exit 1 }" ^
  "$exeDir = Split-Path $proc.Path -Parent;" ^
  "$logFiles = Get-ChildItem -Path $exeDir -Filter 'games_mp.log' -Recurse -ErrorAction SilentlyContinue;" ^
  "if (-not $logFiles) { Write-Host '  ERROR: No games_mp.log found under the game folder.' -ForegroundColor Magenta; Write-Host '  Load into a match first (a private match works) so the log gets created.' -ForegroundColor Magenta; exit 1 }" ^
  "$logFile = $logFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 1;" ^
  "$joinLine = Get-Content $logFile.FullName -ErrorAction SilentlyContinue | Select-String '^\s*[0-9: ]+J;' | Select-Object -Last 1;" ^
  "if (-not $joinLine) { Write-Host ('  ERROR: No join record found in ' + $logFile.FullName) -ForegroundColor Magenta; Write-Host '  Load into a match first (a private match works), then run this again.' -ForegroundColor Magenta; exit 1 }" ^
  "$parts = $joinLine.Line -split ';';" ^
  "if ($parts.Count -lt 2) { Write-Host '  ERROR: Could not parse the join line.' -ForegroundColor Red; exit 1 }" ^
  "$guid = $parts[1].Trim().ToLower();" ^
  "Set-Clipboard -Value $guid;" ^
  "Write-Host ('  Your GUID: ' + $guid) -ForegroundColor Magenta;" ^
  "Write-Host ('  (from: ' + $logFile.FullName + ')') -ForegroundColor DarkGray;" ^
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
