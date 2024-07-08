@echo off
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
) ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%\*.mkv") do (
    move "%CD%\%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.mkv"
    %mkvtoolnix% --output "%CD%/%%~nA.mkv" --no-subtitles "%CD%\mkvmerge_old\%%~nA.mkv"
)
echo.
echo ============================
echo Done
pause>nul
