@echo off

set /p folderlocation= folder location: 

if not DEFINED "%mkvDir%" (
    set mkvtoolnix="C:\Program Files\MKVToolNix\mkvmerge.exe"  
) ELSE (
    set mkvtoolnix="C:\Program Files\MKVToolNix\%mkvDir%\mkvmerge.exe"
)

for %%f in ("%folderlocation%\*.mkv") do (
    %mkvtoolnix% -o "%%~dpnf_no_thumbnail.mkv" --no-attachments "%%f"
)
echo Finished processing files.
pause
