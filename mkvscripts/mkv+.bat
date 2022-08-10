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

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%/*.%extention%") do (
move "%CD%\%%~nA.%extention%" "%CD%/mkvmerge_old/%%~nA.%extention%"
move "%CD%\%%~nA.%additionalFile%"  "%CD%/mkvmerge_old/%%~nA.%additionalFile%" 
%mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%/mkvmerge_old/%%~nA.%extention%" --language 0:en "%CD%/mkvmerge_old/%%~nA.%additionalFile%" 
)
echo.
echo ============================
echo Done
pause>nul
