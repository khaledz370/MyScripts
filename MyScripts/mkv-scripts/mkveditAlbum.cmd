@echo off
set extention=mkv
set /p album=album: 
@echo off

set mkvpropedit="C:\Program Files\MKVToolNix\mkvpropedit.exe"  

if not exist %mkvpropedit% ( exit )

for %%A in ("%CD%\*.%extention%") do (
    %mkvpropedit% "%CD%/%%~nA.%extention%" --set "album=%album%"
)
exit