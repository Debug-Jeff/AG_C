@echo off
setlocal enabledelayedexpansion

REM Configuration 
set REPO_PATH=C:\Users\...\....\
set BRANCH_NAME=feature

REM Change to repository directory
cd /d "%REPO_PATH%"

REM Check if there are any changes to commit
git diff --quiet
if %errorlevel% equ 0 (
    echo No changes to commit
    exit /b 0
)

REM Show current changes
git status
echo.
echo Current changes shown above
echo.

:COMMIT_TYPE
echo Select commit type:
echo 1. feat     - New feature
echo 2. fix      - Bug fix
echo 3. docs     - Documentation only
echo 4. style    - Code style changes
echo 5. refactor - Code refactoring
echo 6. test     - Adding tests
echo 7. chore    - Maintenance tasks
echo.
set /p COMMIT_TYPE_NUM="Enter number (1-7): "

REM Convert number to commit type prefix
set COMMIT_TYPE=
if "%COMMIT_TYPE_NUM%"=="1" set COMMIT_TYPE=feat
if "%COMMIT_TYPE_NUM%"=="2" set COMMIT_TYPE=fix
if "%COMMIT_TYPE_NUM%"=="3" set COMMIT_TYPE=docs
if "%COMMIT_TYPE_NUM%"=="4" set COMMIT_TYPE=style
if "%COMMIT_TYPE_NUM%"=="5" set COMMIT_TYPE=refactor
if "%COMMIT_TYPE_NUM%"=="6" set COMMIT_TYPE=test
if "%COMMIT_TYPE_NUM%"=="7" set COMMIT_TYPE=chore

if "%COMMIT_TYPE%"=="" (
    echo Invalid selection
    goto COMMIT_TYPE
)

REM Get commit message
set /p COMMIT_DESC="Enter commit description: "

REM Get optional detailed message
echo.
echo Enter detailed commit message (optional)
echo Press Ctrl+Z and Enter when done, or just Enter to skip
echo.
set COMMIT_BODY=
set /p "COMMIT_BODY="

REM Stage changes
echo.
echo Do you want to:
echo 1. Stage all changes (git add .)
echo 2. Stage specific files
set /p STAGE_CHOICE="Enter choice (1-2): "

if "%STAGE_CHOICE%"=="1" (
    git add .
) else (
    git status
    echo.
    echo Enter files to stage (space-separated):
    set /p FILES_TO_STAGE=
    git add %FILES_TO_STAGE%
)

REM Show staged changes
echo.
echo The following changes will be committed:
git diff --cached --stat

REM Confirm commit
echo.
set /p CONFIRM="Proceed with commit? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo Commit cancelled
    exit /b 1
)

REM Create commit
if "%COMMIT_BODY%"=="" (
    git commit -m "%COMMIT_TYPE%: %COMMIT_DESC%"
) else (
    (echo %COMMIT_TYPE%: %COMMIT_DESC%& echo.& echo %COMMIT_BODY%) > commit-msg.tmp
    git commit -F commit-msg.tmp
    del commit-msg.tmp
)

REM Ask about pushing
echo.
set /p PUSH_CONFIRM="Push changes to remote? (Y/N): "
if /i "%PUSH_CONFIRM%"=="Y" (
    git push origin %BRANCH_NAME%
    echo Changes pushed successfully
) else (
    echo Changes committed locally but not pushed
)

endlocal