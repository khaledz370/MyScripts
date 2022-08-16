@echo off
set /p extention= video ext: 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
)ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_audio" (mkdir "%CD%\mkvmerge_audio")
for %%A in ("%CD%/*.%extention%") do (
    %mkvtoolnix% --output "%CD%/mkvmerge_audio/%%~nA.mka" --no-video --language 1:und  "%CD%\%%~nA.%extention%"
)
echo.
echo ============================
echo Done
pause>nul
