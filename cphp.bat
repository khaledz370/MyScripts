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

echo Select PHP version:
echo 1. 5.4.9
echo 2. 7.1
echo 3. 7.2.19
echo 4. 7.3.2
echo 5. 7.4
echo 6. 8.0
echo 7. 8.1.10
echo 8. 8.2.20
echo 9. 8.3.9

set php_dir="I:\laragon\bin\php"
set /p choice=Enter choice (1-9):

if "%choice%"=="1" set PHP_VERSION=%php_dir%\php-5.4.9
if "%choice%"=="2" set PHP_VERSION=%php_dir%\php-7.1
if "%choice%"=="3" set PHP_VERSION=%php_dir%\php-7.2.19
if "%choice%"=="4" set PHP_VERSION=%php_dir%\php-7.3.2
if "%choice%"=="5" set PHP_VERSION=%php_dir%\php-7.4
if "%choice%"=="6" set PHP_VERSION=%php_dir%\php-8.0
if "%choice%"=="7" set PHP_VERSION=%php_dir%\php-8.1.10
if "%choice%"=="8" set PHP_VERSION=%php_dir%\php-8.2.20
if "%choice%"=="9" set PHP_VERSION=%php_dir%\php-8.3.9


setx PHP_VERSION "%PHP_VERSION%" /M

echo PHP_VERSION is now set to %PHP_VERSION%
pause
