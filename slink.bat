@echo off
set /p originalFolder=Real File/Folder path: 
set /p symbolicFolder=Symbolic Link folder path: 
set /p FileName=File/Folder Name: 

set originalFolder=%originalFolder:"=%
set symbolicFolder=%symbolicFolder:"=%

@echo off
mklink /D "%symbolicFolder%\%FileName%" "%originalFolder%"