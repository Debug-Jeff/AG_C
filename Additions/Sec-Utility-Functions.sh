@echo off
REM Security Utility Functions Library
setlocal enabledelayedexpansion

:CHECK_ADMIN
REM Check for admin privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Admin privileges detected
) else (
    echo WARNING: Some features require admin privileges
)
exit /b

:HASH_FILE
REM Calculate file hash
set "file=%~1"
certutil -hashfile "%file%" MD5
certutil -hashfile "%file%" SHA256
exit /b

:CHECK_PORTS
REM Check specific port
set "port=%~1"
netstat -an | find ":%port%"
exit /b

:SCAN_DIRECTORY
REM Recursive directory scanner
set "dir=%~1"
dir /s /b "%dir%" > dir_contents.txt
for /f "tokens=*" %%a in (dir_contents.txt) do (
    icacls "%%a"
)
del dir_contents.txt
exit /b

:LOG_EVENT
REM Log events to file
set "event=%~1"
echo %date% %time% - %event% >> security_log.txt
exit /b