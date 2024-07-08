@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb runAs"
    goto :eof
)
REM Prompt the user for the PHP version
set PHP_VERSION="5.4.9"
set phpVersion="C:\php\php-"%PHP_VERSION%

REM Set the system environment variable
setx PHP_VERSION %phpVersion% /M
REM Confirm the environment variable is set
echo PHP_VERSION is set to %phpVersion% system-wide
:end
pause
