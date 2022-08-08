@echo off
set /p extention= video ext: 
set /p additionalFile= additionalFile ext: 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
)ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_out" (mkdir "%CD%\mkvmerge_out")
for %%A in ("%CD%/*.%extention%") do (
%mkvtoolnix% --output "%CD%/mkvmerge_out/%%~nA.mkv" "%CD%\%%~nA.%extention%" --language 0:en "%CD%\%%~nA.%additionalFile%" 
)
echo.
echo ============================
echo Done
pause>nul
