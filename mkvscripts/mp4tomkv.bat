@echo off
set  extention="mp4"
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
) ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%\*.%extention%") do (
if not exist "%CD%\%%~nA.mkv" (
    move "%CD%\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
) else (
    move "%CD%\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
    move "%CD%\%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.mkv"
)
    %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
)
echo.
echo ============================
echo Done
pause>nul
