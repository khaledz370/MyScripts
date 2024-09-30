@echo off
if not exist "%CD%\options.json" (
    echo Options file 'options.json' not found. Exiting.
    pause>nul
    exit
)

set /p extention= video ext: 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvmerge="C:\Program Files\MKVToolNix\mkvmerge.exe"  
)ELSE (
    set mkvmerge="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvmerge% ( exit )

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%\*.%extention%") do (
    move "%CD%\%%~nA.%extention%" "%CD%/mkvmerge_old/%%~nA.mkv"
    %mkvmerge% @options.json -o "%CD%/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
)
echo.
echo ============================
echo Done. Press any key to exit.
pause>nul
exit