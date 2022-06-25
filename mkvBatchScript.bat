@echo off
set /p extention= enter extention 

@echo off
set mkvmerge="C:\Program Files\MKVToolNix\mkvmerge.exe"
if not exist "%CD%\options.json" (
    echo Options file 'options.json' not found. Exiting.
    pause>nul
    exit
)

if not exist "%CD%\output" (mkdir "%CD%\output")
for %%f in ("%CD%/*.%extention%") do %mkvmerge% @options.json -o "%CD%/output/%%~nf.mkv" "%CD%\%%~nf.%extention%"
echo.
echo ============================
echo Done. Press any key to exit.
pause>nul
exit
