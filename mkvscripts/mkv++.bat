@echo off
set /p extention= video ext: 
set /p additionalFile= additionalFile ext: 
set /p lg= language: 
set /p additionalName= additional FileName Ending: 
set /p mkvDir= mkv dir: 
@echo off

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
)ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%\*.%extention%") do (
    if exist "%CD%\%%~nA.%extention%" (
        if exist "%CD%\%%~nA%additionalName%.%additionalFile%" (
            move "%CD%\%%~nA.%extention%" "%CD%/mkvmerge_old/%%~nA.%extention%"
            move "%CD%\%%~nA%additionalName%.%additionalFile%"  "%CD%/mkvmerge_old/%%~nA%additionalName%.%additionalFile%" 
            %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%/mkvmerge_old/%%~nA.%extention%" --language 0:%lg% "%CD%/mkvmerge_old/%%~nA%additionalName%.%additionalFile%" 
        )
    )  
)
echo.
echo ============================
echo Done
pause>nul
