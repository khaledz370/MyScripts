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

for /d %%x in ("%CD%\*") do (
if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%%x/*.%extention%") do (
%mkvtoolnix% --output "%%x/%%~nA.mkv" "%%x\%%~nA.%extention%" 
move "%%x\%%~nA.%extention%" "%%x\mkvmerge_old\%%~nA.%extention%"
))
echo.
echo ============================
echo Done
pause>nul
