@echo off
setlocal

:: Prompt user for input file location
set /p "input_file=Enter the full path to the input image file (e.g., C:\path\to\t.jpeg): "

:: Verify if the input file exists
if not exist "%input_file%" (
    echo The specified file does not exist. Please check the path and try again.
    pause
    exit /b
)

:: Prompt user for the desired output extension
set /p "output_ext=Enter the desired output extension (e.g., png, jpeg, bmp): "

:: Ensure the extension starts with a dot
if not "%output_ext:~0,1%" == "." set "output_ext=.%output_ext%"

:: Prompt user for export base name
set /p "export_name=Enter the base name for the exported files (e.g., resized_image): "

:: Extract the directory of the input file
for %%f in ("%input_file%") do (
    set "dir_name=%%~dpf"
)

:: Set output file names with user-defined base name and chosen extension
set "output_file_16=%dir_name%%export_name%_16%output_ext%"
set "output_file_48=%dir_name%%export_name%_48%output_ext%"
set "output_file_128=%dir_name%%export_name%_128%output_ext%"

:: Convert to 16x16
ffmpeg -i "%input_file%" -vf scale=16:16 "%output_file_16%"

:: Convert to 48x48
ffmpeg -i "%input_file%" -vf scale=48:48 "%output_file_48%"

:: Convert to 128x128
ffmpeg -i "%input_file%" -vf scale=128:128 "%output_file_128%"

echo Conversion complete!
pause
