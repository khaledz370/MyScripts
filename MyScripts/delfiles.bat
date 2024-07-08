@echo off
set /p extention= video ext: 

for %%x in ("%CD%\*.%extention%") do (
del "%%x"
)
echo.
echo ============================
echo Done
pause>nul
