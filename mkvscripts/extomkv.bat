@echo off
set /p extention= video ext: 
set /p filename= file name: 
set /a index= 1
@echo off

set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\%filename%.mkv" (
    %mkvtoolnix% --output "%CD%/%filename%.mkv" "%CD%\%filename%.%extention%"
) else (
    :while
    if exist "%CD%\%filename%_%index%.mkv" (
        set /a index= %index% + 1
        goto :while
    ) else (
        %mkvtoolnix% --output "%CD%/%filename%_%index%.mkv" "%CD%\%filename%.%extention%"
    )
)

echo.
echo ============================
echo Done
pause>nul
