@echo off
setlocal enabledelayedexpansion

REM Configuration
set BACKUP_ROOT=C:\gitBackups
set LOG_FILE=%BACKUP_ROOT%\backup_log.txt
set MAX_BACKUPS=5

REM Create backup directory if it doesn't 
if not exist "%BACKUP_ROOT%" mkdir "%BACKUP_ROOT%"

REM Log function
:LOG
echo %date% %time%: %* >> "%LOG_FILE%"
echo %*
goto :EOF

REM Start backup process
call :LOG "Starting Git backup process..."

REM Get repository name
for %%I in (.) do set REPO_NAME=%%~nxI
set BACKUP_DIR=%BACKUP_ROOT%\%REPO_NAME%_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
set BACKUP_DIR=%BACKUP_DIR: =0%

REM Create backup
git bundle create "%BACKUP_DIR%.bundle" --all
if errorlevel 1 (
    call :LOG "Error: Backup failed!"
    exit /b 1
)

REM Compress backup
powershell Compress-Archive "%BACKUP_DIR%.bundle" "%BACKUP_DIR%.zip"
del "%BACKUP_DIR%.bundle"

REM Clean old backups
pushd "%BACKUP_ROOT%"
for /f "skip=%MAX_BACKUPS% eol=: delims=" %%F in ('dir /b /o-d *.zip') do (
    del "%%F"
    call :LOG "Deleted old backup: %%F"
)
popd

call :LOG "Backup completed successfully: %BACKUP_DIR%.zip"

REM Display backup stats
echo.
echo Backup Statistics:
echo -----------------
powershell -Command "Get-ChildItem '%BACKUP_ROOT%\*.zip' | Sort-Object LastWriteTime -Descending | Format-Table Name,Length,LastWriteTime"