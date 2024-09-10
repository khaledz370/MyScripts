@echo off
setlocal

rem Define the application name to search for
set /p "AppName=ApplicationName: "

rem Query the registry for the CLSID keys related to the application
for /f "tokens=*" %%I in ('reg query HKEY_CLASSES_ROOT\CLSID /f "%AppName%" /t REG_SZ /s 2^>nul') do (
    rem Check if the line contains a registry path
    echo %%I | findstr /i "HKEY_CLASSES_ROOT\CLSID" >nul
    if not errorlevel 1 (
        rem Delete the registry key
        reg delete "%%I" /f
    )
)

endlocal
@pause