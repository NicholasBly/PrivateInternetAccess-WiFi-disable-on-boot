@echo off
:: Enable color support
setlocal EnableDelayedExpansion

:: Disable Wi-Fi
netsh interface set interface "Wi-Fi" admin=disabled

:: Start PIA VPN (adjust path as needed)
start "" "C:\Program Files\Private Internet Access\piactl.exe" connect

:: Run PowerShell script to check for the color with a 5-minute timeout and visual feedback
powershell.exe -ExecutionPolicy Bypass -Command ^
"Add-Type -AssemblyName System.Windows.Forms,System.Drawing; ^
$x = 1671; $y = 1057; $targetColor = [System.Drawing.Color]::FromArgb(230,180,0); ^
$timeout = New-TimeSpan -Minutes 5; ^
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew(); ^
$host.UI.RawUI.WindowTitle = 'Waiting for PIA Connection'; ^
$host.UI.RawUI.BackgroundColor = 'Black'; ^
$host.UI.RawUI.ForegroundColor = 'Green'; ^
Clear-Host; ^
$dots = ''; ^
Write-Host 'Waiting for PIA Connection' -NoNewline; ^
while ($stopwatch.Elapsed -lt $timeout) { ^
    $bitmap = New-Object System.Drawing.Bitmap(1,1); ^
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap); ^
    $graphics.CopyFromScreen($x, $y, 0, 0, $bitmap.Size); ^
    $pixel = $bitmap.GetPixel(0,0); ^
    if ($pixel.R -eq $targetColor.R -and $pixel.G -eq $targetColor.G -and $pixel.B -eq $targetColor.B) { ^
        Write-Host ''; ^
        exit 0; ^
    } ^
    $dots += '.'; ^
    if ($dots.Length -gt 3) { $dots = ''; } ^
    Write-Host "`r`rWaiting for PIA Connection$dots   " -NoNewline; ^
    Start-Sleep -Milliseconds 500; ^
} ^
Write-Host ''; ^
exit 1;"

:: Check if PowerShell script exited successfully (color was detected)
if %errorlevel% equ 0 (
    :: Enable Wi-Fi
    netsh interface set interface "Wi-Fi" admin=enabled
    echo Color detected. Wi-Fi has been enabled.
) else (
    :: Enable Wi-Fi even if color wasn't detected
    netsh interface set interface "Wi-Fi" admin=enabled
    echo Color detection timed out after 5 minutes. Wi-Fi has been enabled anyway.
)

:: Add a 3-second delay and exit message
timeout /t 3 /nobreak >nul
echo.
echo Program is exiting...
timeout /t 1 /nobreak >nul
exit