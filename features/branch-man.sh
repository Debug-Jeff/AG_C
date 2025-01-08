@echo off
setlocal enabledelayedexpansion

:MENU
cls
echo ===================================
echo   Git Branch Management Console
echo ===================================
echo 1. List all branches
echo 2. Create feature branch
echo 3. Delete stale branches
echo 4. Clean merged branches
echo 5. Switch branches
echo 6. Show branch history
echo 7. Exit
echo.

set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" (
    echo.
    echo Current branches:
    echo ----------------
    git branch -a
    timeout /t 5
    goto MENU
)

if "%choice%"=="2" (
    set /p branchName="Enter feature name: "
    git checkout -b feature/%branchName%
    echo Created and switched to feature/%branchName%
    timeout /t 3
    goto MENU
)

if "%choice%"=="3" (
    echo Checking for stale branches...
    for /f "tokens=*" %%a in ('git branch -r --merged') do (
        echo Analyzing: %%a
        git branch -r --contains %%a > nul 2>&1
        if errorlevel 1 (
            echo Stale branch found: %%a
            set /p delete="Delete this branch? (Y/N): "
            if /i "!delete!"=="Y" git branch -d %%a
        )
    )
    timeout /t 3
    goto MENU
)

if "%choice%"=="4" (
    echo Cleaning merged branches...
    git branch --merged | findstr /v "\* main master develop" > merged-branches.tmp
    for /f "tokens=*" %%a in (merged-branches.tmp) do (
        git branch -d %%a
    )
    del merged-branches.tmp
    echo Done cleaning merged branches
    timeout /t 3
    goto MENU
)

if "%choice%"=="5" (
    echo Available branches:
    git branch
    echo.
    set /p branch="Enter branch name to switch to: "
    git checkout %branch%
    timeout /t 3
    goto MENU
)

if "%choice%"=="6" (
    set /p days="Show history for how many days? "
    echo.
    echo Branch history for the last %days% days:
    echo -------------------------------------
    git for-each-ref --sort=-committerdate refs/heads/ --format=%%(refname:short) --count=20
    git log --all --decorate --oneline --graph --since="%days% days ago"
    pause
    goto MENU
)

if "%choice%"=="7" (
    exit /b 0
)

goto MENU