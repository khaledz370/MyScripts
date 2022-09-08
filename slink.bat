@echo off
set /p originalFolder=main folder or file: 
set /p symbolicFolder=Symbolic Link folder or file Name:
@echo off
mklink /D %symbolicFolder% %originalFolder%