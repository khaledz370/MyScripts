@echo off
set /p extention= video ext: 
set /p split= split timestamp ex "00:00:00" :
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
) ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_split" (mkdir "%CD%\mkvmerge_split")
for %%A in ("%CD%\*.%extention%") do (
    %mkvtoolnix% --output "%CD%\mkvmerge_split\%%~nA.%extention%" "%CD%/%%~nA.mkv" --split timestamps:%split% 
) 

echo.
echo ============================
echo Done
pause>nul
