@echo off
set /p extention= video ext: 

for %%x in ("%CD%\*.%extention%") do (
for %%A in ("%%x/*.%extention%") do (
del "%%x\%%~nA.%extention%"
))
echo.
echo ============================
echo Done
pause>nul
