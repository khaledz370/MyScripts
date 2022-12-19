@echo off
set extention=mkv
set /p left=left: 
set /p top=top: 
set /p right=right: 
set /p bottom=bottom: 
@echo off

set mkvpropedit="C:\Program Files\MKVToolNix\mkvpropedit.exe"  

if not exist %mkvpropedit% ( exit )

for %%A in ("%CD%\*.%extention%") do (
    %mkvpropedit% "%CD%/%%~nA.%extention%" --edit track:v1 --set pixel-crop-top=%top% --set pixel-crop-left=%left% --set pixel-crop-right=%right% --set pixel-crop-bottom=%bottom%
)
exit