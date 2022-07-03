@echo off
set /p extention= video ext: 

@echo off
set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"

for /d %%x in ("%CD%\*") do (
for %%f in ("%%x/*.%extention%") do (
%mkvtoolnix% --output "%%x/%%~nf.mkv" "%%x\%%~nf.%extention%" 
trash "%%x\%%~nf.%extention%"
))
echo.
echo ============================
echo Done
pause>nul
