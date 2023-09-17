@echo off
Setlocal enabledelayedexpansion
set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"
@echo off

if not exist %mkvtoolnix% ( exit )

if not exist "%CD%\mkvmerge_old" (mkdir "%CD%\mkvmerge_old")
for %%A in ("%CD%\*.mkv") do (
    if exist "%CD%\%%~nA.mkv" if exist "%CD%\%%~nA.de.srt" if exist "%CD%\%%~nA.en.srt" (
            move "%CD%\%%~nA.mkv" "%CD%/mkvmerge_old/%%~nA.mkv"
            move "%CD%\%%~nA.de.srt"  "%CD%/mkvmerge_old/%%~nA.de.srt" 
            move "%CD%\%%~nA.en.srt"  "%CD%/mkvmerge_old/%%~nA.en.srt" 
            %mkvtoolnix% --output "%CD%/%%~nA.mkv" "%CD%/mkvmerge_old/%%~nA.mkv" --language 0:de "%CD%/mkvmerge_old/%%~nA.de.srt" --language 0:en --default-track-flag 0:no "%CD%/mkvmerge_old/%%~nA.en.srt" 

            Set "File=%%~nxA"
            Ren "%%A" "!File: no sub=!"
    )  
)
echo.
echo ============================
echo Done
pause>nul
