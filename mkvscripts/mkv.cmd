@echo off
if not exist "%CD%\options.json" (
    echo Options file 'options.json' not found. Exiting.
    pause>nul
    exit
)

set /p extention= video ext: 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkDir%" (
    set mkvmerge="C:\Program Files\MKVToolNix\mkvmerge.exe"  
)ELSE (
    set mkvmerge="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvmerge% ( exit )

if not exist "%CD%\mkvmerge_out" (mkdir "%CD%\mkvmerge_out")
for %%A in ("%CD%\*.%extention%") do (
    %mkvmerge% @options.json -o "%CD%/mkvmerge_out/%%~nA.mkv" "%CD%\%%~nA.%extention%"
)
echo.
echo ============================
echo Done. Press any key to exit.
pause>nul
exit