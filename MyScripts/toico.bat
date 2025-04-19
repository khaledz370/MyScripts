@echo off
setlocal

:: Prompt for file name
set /p "filename=Enter the file name (with extension): "

:: Get file path and name without extension
for %%F in ("%filename%") do (
    set "filepath=%%~dpF"
    set "name=%%~nF"
)

:: Convert to ICO using ffmpeg
ffmpeg -i "%filename%" -vf scale=256:256 "%filepath%%name% [icon].ico"

echo Conversion complete: "%filepath%%name% [icon].ico"
pause
