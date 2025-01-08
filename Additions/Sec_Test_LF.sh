@echo off
setlocal enabledelayedexpansion

:MAIN_MENU
cls
echo ========================================
echo    Security Testing Learning Framework
echo ========================================
echo 1. System Information Gathering
echo 2. Network Analysis Tools
echo 3. Security Configuration Checker
echo 4. Log Analysis
echo 5. File Integrity Monitor
echo 6. Exit
echo.

set /p choice="Select module (1-6): "

if "%choice%"=="1" goto :SYSINFO
if "%choice%"=="2" goto :NETANALYSIS
if "%choice%"=="3" goto :SECCONFIG
if "%choice%"=="4" goto :LOGANALYSIS
if "%choice%"=="5" goto :FILEINTEGRITY
if "%choice%"=="6" exit /b 0
goto :MAIN_MENU

:SYSINFO
cls
echo === System Information Module ===
echo Gathering system information...
systeminfo | findstr /B /C:"OS" /C:"System Type" /C:"Total Physical Memory"
echo.
echo Network Configuration:
ipconfig /all | findstr /i "IPv4 Physical"
pause
goto :MAIN_MENU

:NETANALYSIS
cls
echo === Network Analysis Module ===
echo 1. View active connections
echo 2. Check open ports
echo 3. DNS cache
echo 4. Back to main menu

set /p net_choice="Select option: "
if "%net_choice%"=="1" netstat -ano
if "%net_choice%"=="2" netstat -an | findstr "LISTENING"
if "%net_choice%"=="3" ipconfig /displaydns
if "%net_choice%"=="4" goto :MAIN_MENU
pause
goto :NETANALYSIS

:SECCONFIG
cls
echo === Security Configuration Module ===
echo Checking security settings...
echo.
echo Windows Firewall Status:
netsh advfirewall show allprofiles state
echo.
echo Windows Updates Status:
wmic qfe list brief
pause
goto :MAIN_MENU

:LOGANALYSIS
cls
echo === Log Analysis Module ===
echo Recent System Events:
wevtutil qe System /c:5 /f:text
pause
goto :MAIN_MENU

:FILEINTEGRITY
cls
echo === File Integrity Monitor ===
echo Monitoring critical system files...
echo Creating file baseline...
dir /b /s %SystemRoot%\system32\*.dll > baseline.txt
echo Baseline created. Run comparison next time.
pause
goto :MAIN_MENU