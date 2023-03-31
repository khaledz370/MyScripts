@echo off
set extention= "ts" 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
) ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )
if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for /d %%x in ("%CD%\*") do (
    for %%A in ("%%x\*.%extention%") do (
        if not exist "%%x\%%~nA.mkv" (
            move "%%x\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
        ) else (
            move "%%x\%%~nA.%extention%" "%CD%\mkvmerge_old\%%~nA.%extention%"
            move "%%x\%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.mkv"
        )
        %mkvtoolnix% --output "%%x/%%~nA.mkv" "%CD%\mkvmerge_old\%%~nA.%extention%"
    )
)
echo.
echo ============================
echo Done
pause>nul
