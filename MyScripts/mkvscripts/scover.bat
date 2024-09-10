@echo off
setlocal enabledelayedexpansion

:: Prompt user for input
set "folder=%CD%"
set /p "image=Enter the path to the cover image file: "
set /p "extension=Enter the file extension of the audio files (e.g., mka): "
set mkvpropedit="C:\Program Files\MKVToolNix\mkvpropedit.exe"

:: Check if the provided paths exist
if not exist "%folder%" (
    echo Folder "%folder%" does not exist.
    exit /b 1
)

if not exist "%image%" (
    echo Image file "%image%" does not exist.
    exit /b 1
)

:: Extract the directory, filename, and extension of the image
for %%i in ("%image%") do (
    set "imageDir=%%~dpi"
    set "imageName=%%~ni"
    set "imageExt=%%~xi"
)

:: Define the temporary cover image filename
set "coverImage=%imageDir%cover%imageExt%"

:: Rename the image file to "cover"
echo Renaming "%image%" to "%coverImage%..."
rename "%image%" "cover%imageExt%"

:: Loop through each file in the folder with the specified extension
for %%f in ("%folder%\*.%extension%") do (
    echo Processing %%f...
    %mkvpropedit% "%%f" --add-attachment "%coverImage%"
)

:: Rename the image file back to its original name
echo Renaming "%coverImage%" back to "%imageName%%imageExt%"...
rename "%coverImage%" "%imageName%%imageExt%"

echo Done!
pause
