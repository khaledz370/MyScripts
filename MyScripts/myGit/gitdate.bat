@echo off
setlocal

:: Save the current directory
set "current_dir=%cd%"

:: Change to the directory where the batch file is located
cd /d "%~dp0"

:: Prompt the user for the date and commit message
set /p date="Enter the date (e.g., YYYY-MM-DD HH:MM:SS): "
set /p message="Enter the commit message: "

:: Set the environment variables for git commit
set "GIT_AUTHOR_DATE=%date%"
set "GIT_COMMITTER_DATE=%date%"

:: Add changes and commit with the provided message
git add .
git commit -m "%message%"

:: Return to the original directory
cd /d "%current_dir%"

endlocal
