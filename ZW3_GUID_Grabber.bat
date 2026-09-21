@echo off
title Get Machine GUID for ZW3
color 0D

echo.
echo  ==============================
echo    ZW3 Machine GUID Grabber
echo  ==============================
echo.
echo  Retrieving Machine GUID...
echo.

powershell -NoProfile -Command ^
  "try { $g = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Cryptography' -ErrorAction Stop).MachineGuid; if ($g) { Set-Clipboard -Value $g.Trim(); Write-Host ('  ' + $g.Trim()) -ForegroundColor Red; exit 0 } else { Write-Host '  ERROR: MachineGuid not found' -ForegroundColor Red; exit 1 } } catch { Write-Host ('  ERROR: ' + $_.Exception.Message) -ForegroundColor Red; exit 1 }"

if %errorlevel% equ 0 (
    echo.
    echo  Copied to clipboard!
) else (
    color 0C
    echo.
    echo  Failed to retrieve the GUID.
)

echo.
set /p dummy="  Press Enter to close..."
