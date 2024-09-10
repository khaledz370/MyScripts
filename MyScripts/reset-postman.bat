@echo off
set "filePath=%appdata%\Postman\Preferences"

if exist "%filePath%" (
    del "%filePath%"
    echo File deleted successfully.
) else (
    echo File not found.
)
pause
