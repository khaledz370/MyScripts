@echo off
set adb=C:\Users\khaledz\Documents\apt\adb
set /p file=enter file location: 
set androidfolder=/storage/emulated/0/Download

%adb% push %file% %androidfolder%
@echo off
echo file transfer was successful
@pause