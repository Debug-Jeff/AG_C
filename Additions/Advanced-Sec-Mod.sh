@echo off
setlocal enabledelayedexpansion

:MAIN_MENU
cls
echo ============================================
echo    Advanced Security Education Framework
echo ============================================
echo 1. Port Scanner Module
echo 2. Service Enumeration
echo 3. Password Policy Analyzer
echo 4. File Permission Auditor
echo 5. Registry Security Checker
echo 6. Network Traffic Monitor
echo 7. Process Analysis
echo 8. Event Log Parser
echo 9. Exit
echo.

set /p choice="Select module (1-9): "

if "%choice%"=="1" goto :PORT_SCANNER
if "%choice%"=="2" goto :SERVICE_ENUM
if "%choice%"=="3" goto :PASSWORD_POLICY
if "%choice%"=="4" goto :FILE_PERMISSIONS
if "%choice%"=="5" goto :REGISTRY_CHECK
if "%choice%"=="6" goto :TRAFFIC_MONITOR
if "%choice%"=="7" goto :PROCESS_ANALYSIS
if "%choice%"=="8" goto :LOG_PARSER
if "%choice%"=="9" exit /b 0
goto :MAIN_MENU

:PORT_SCANNER
cls
echo === Port Scanner Module ===
echo This module demonstrates basic port scanning concepts
set /p target="Enter target IP (default: 127.0.0.1): " || set target=127.0.0.1
echo Scanning common ports...
for %%p in (21,22,23,25,80,443,3389,8080) do (
    echo Testing port %%p
    timeout /t 1 /nobreak > nul
    netstat -an | find "%%p" | find "LISTENING"
)
pause
goto :MAIN_MENU

:SERVICE_ENUM
cls
echo === Service Enumeration Module ===
echo Listing running services...
echo.
sc query state= running
echo.
set /p service="Enter service name for details: "
sc qc "%service%"
pause
goto :MAIN_MENU

:PASSWORD_POLICY
cls
echo === Password Policy Analyzer ===
echo Current password policy settings:
net accounts
echo.
echo Checking for accounts with no password...
net user | find /v "Command" | find /v "accounts"
pause
goto :MAIN_MENU

:FILE_PERMISSIONS
cls
echo === File Permission Auditor ===
echo This module checks file permissions in a directory
set /p check_dir="Enter directory path: "
if exist "%check_dir%" (
    echo Checking permissions for: %check_dir%
    icacls "%check_dir%"
    echo.
    echo Listing files with unusual permissions:
    dir /q "%check_dir%"
) else (
    echo Directory not found!
)
pause
goto :MAIN_MENU

:REGISTRY_CHECK
cls
echo === Registry Security Checker ===
echo Checking common security-related registry keys...
echo.
echo Checking AutoRun entries:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
echo.
echo Checking startup programs:
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
pause
goto :MAIN_MENU

:TRAFFIC_MONITOR
cls
echo === Network Traffic Monitor ===
echo Displaying active network connections...
echo.
netstat -nb
echo.
echo Protocol Statistics:
netstat -s
pause
goto :MAIN_MENU

:PROCESS_ANALYSIS
cls
echo === Process Analysis Module ===
echo 1. List all processes
echo 2. Check specific process
echo 3. View process tree
echo 4. Back to main menu

set /p proc_choice="Select option: "
if "%proc_choice%"=="1" tasklist /v
if "%proc_choice%"=="2" (
    set /p proc_name="Enter process name: "
    tasklist /fi "imagename eq %proc_name%"
)
if "%proc_choice%"=="3" wmic process get Caption,ParentProcessId,ProcessId
if "%proc_choice%"=="4" goto :MAIN_MENU
pause
goto :PROCESS_ANALYSIS

:LOG_PARSER
cls
echo === Event Log Parser ===
echo 1. System logs
echo 2. Application logs
echo 3. Security logs
echo 4. Back to main menu

set /p log_choice="Select option: "
if "%log_choice%"=="1" wevtutil qe System /c:5 /f:text
if "%log_choice%"=="2" wevtutil qe Application /c:5 /f:text
if "%log_choice%"=="3" wevtutil qe Security /c:5 /f:text
if "%log_choice%"=="4" goto :MAIN_MENU
pause
goto :LOG_PARSER