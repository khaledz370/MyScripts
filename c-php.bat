@echo off
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

set /p choice=Enter choice (1-8):

if %choice%==1 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-5.4.9
if %choice%==2 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-7.1
if %choice%==3 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-7.2.19
if %choice%==4 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-7.3.2
if %choice%==5 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-7.4
if %choice%==6 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-8.0
if %choice%==7 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-8.1.10
if %choice%==8 set PHP_VERSION=G:\Books-and-courses\Programming\laragon\bin\php\php-8.2.20

setx PHP_VERSION "%PHP_VERSION%"

echo PHP_VERSION is now set to %PHP_VERSION%
pause
