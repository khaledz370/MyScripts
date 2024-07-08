@echo off
set adb=C:\Users\khaledz\Documents\apt\adb
set /p file=enter file name: 
set androidfolder=/storage/emulated/0/Download
set desktopfolder="G:\Downloads"

%adb% pull %androidfolder%/%file% %desktopfolder%
@echo off
echo file transfer was successful
@pause