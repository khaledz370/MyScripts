@echo off
:: Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

:: If error flag set, we do not have admin rights
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: Main logic to set PHP_VERSION
setlocal enabledelayedexpansion

echo Select Python version:
echo 1. 3.7.3
echo 2. 3.9.6
echo 3. 3.10
echo 4. 3.11.9
echo 5. 3.12.5
echo 6. 3.13

set python_dir="I:\laragon\bin\python"

set /p choice=Enter choice (1-6):

if "%choice%"=="1" set PYTHON_VERSION=%python_dir%\python-3.7.3
if "%choice%"=="2" set PYTHON_VERSION=%python_dir%\python-3.9.6
if "%choice%"=="3" set PYTHON_VERSION=%python_dir%\python-3.10
if "%choice%"=="4" set PYTHON_VERSION=%python_dir%\python-3.11.9
if "%choice%"=="5" set PYTHON_VERSION=%python_dir%\python-3.12.5
if "%choice%"=="6" set PYTHON_VERSION=%python_dir%\python-3.13

setx PYTHON_VERSION "%PYTHON_VERSION%" /M

echo PYTHON_VERSION is now set to %PYTHON_VERSION%
pause
