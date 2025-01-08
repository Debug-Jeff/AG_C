@echo off
REM Turns off command echoing to keep console output clean

REM Navigate to the repository directory - Replace ... with your actual path
cd /d "C:\Users\...\...."

REM Stage all changes in the repository
git add .

REM Enable delayed environment variable expansion
REM This is needed to use !variables! later in the script
setlocal enabledelayedexpansion

REM Define an array of generic commit messages
REM Each message is stored in messages[index] from 0 to 19
set messages[0]=Refactor code to improve readability
set messages[1]=Fix minor bugs and update documentation
set messages[2]=Optimize performance for critical functions
set messages[3]=Update dependencies to latest versions
set messages[4]=Enhance error handling in edge cases
set messages[5]=Add comments and clean up code
set messages[6]=Revise UI layout for better user experience
set messages[7]=Implement new feature: user profiles
set messages[8]=Add automated tests for key modules
set messages[9]=Fix styling issues in CSS
set messages[10]=Adjust configurations for deployment
set messages[11]=Improve logging and monitoring tools
set messages[12]=Resolve merge conflicts in main branch
set messages[13]=Add new translations for localization
set messages[14]=Fix build issues and dependency errors
set messages[15]=Improve database queries for performance
set messages[16]=Redesign footer section of the website
set messages[17]=Update README with usage instructions
set messages[18]=Patch security vulnerabilities
set messages[19]=Implement feature flags for testing

REM Generate a random number between 0 and 19
REM %random% generates a number between 0 and 32767
REM %% 20 gets the remainder when divided by 20 (0-19)
set /a randomIndex=%random% %% 20

REM Select a random message from the array using the random index
REM !messages[%randomIndex%]! uses delayed expansion to get the message
set commitMessage=!messages[%randomIndex%]!

REM Commit changes with the randomly selected message
git commit -m "!commitMessage!"

REM Push the changes to the main branch of the remote repository
git push origin main