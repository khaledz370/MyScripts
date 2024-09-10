@echo off
setlocal

:: Input image file
set "input_image=input.webp"

:: Convert to various PNG sizes
ffmpeg -i %input_image% -vf scale=144:144 android-icon-144x144.png
ffmpeg -i %input_image% -vf scale=192:192 android-icon-192x192.png
ffmpeg -i %input_image% -vf scale=36:36 android-icon-36x36.png
ffmpeg -i %input_image% -vf scale=48:48 android-icon-48x48.png
ffmpeg -i %input_image% -vf scale=72:72 android-icon-72x72.png
ffmpeg -i %input_image% -vf scale=96:96 android-icon-96x96.png

ffmpeg -i %input_image% -vf scale=114:114 apple-touch-icon-114x114.png
ffmpeg -i %input_image% -vf scale=120:120 apple-touch-icon-120x120.png
ffmpeg -i %input_image% -vf scale=144:144 apple-touch-icon-144x144.png
ffmpeg -i %input_image% -vf scale=152:152 apple-touch-icon-152x152.png
ffmpeg -i %input_image% -vf scale=57:57 apple-touch-icon-57x57.png
ffmpeg -i %input_image% -vf scale=60:60 apple-touch-icon-60x60.png
ffmpeg -i %input_image% -vf scale=72:72 apple-touch-icon-72x72.png
ffmpeg -i %input_image% -vf scale=76:76 apple-touch-icon-76x76.png

:: SVG conversion using Inkscape or ImageMagick
:: Uncomment the following lines if you have Inkscape or ImageMagick installed
:: inkscape %input_image% --export-filename=cic-logo-1.svg
:: inkscape %input_image% --export-filename=cic-logo-2.svg
:: convert %input_image% cic-logo-1.svg
:: convert %input_image% cic-logo-2.svg

:: Favicon sizes
ffmpeg -i %input_image% -vf scale=128:128 favicon-128.png
ffmpeg -i %input_image% -vf scale=16:16 favicon-16x16.png
ffmpeg -i %input_image% -vf scale=196:196 favicon-196x196.png
ffmpeg -i %input_image% -vf scale=32:32 favicon-32x32.png
ffmpeg -i %input_image% -vf scale=96:96 favicon-96x96.png

:: Favicon ICO format using ImageMagick (uncomment if you have it installed)
:: convert %input_image% -define icon:auto-resize=64,32,16 favicon.ico

:: Tile sizes
ffmpeg -i %input_image% -vf scale=144:144 mstile-144x144.png
ffmpeg -i %input_image% -vf scale=150:150 mstile-150x150.png
ffmpeg -i %input_image% -vf scale=310:310 mstile-310x310.png
ffmpeg -i %input_image% -vf scale=70:70 mstile-70x70.png

:: Generate filelist.txt
dir /b *.png *.svg *.ico > filelist.txt

:: Generate manifest.json
(
echo {
echo   "name": "App Name",
echo   "short_name": "App",
echo   "icons": [
echo     { "src": "android-icon-36x36.png", "sizes": "36x36", "type": "image/png" },
echo     { "src": "android-icon-48x48.png", "sizes": "48x48", "type": "image/png" },
echo     { "src": "android-icon-72x72.png", "sizes": "72x72", "type": "image/png" },
echo     { "src": "android-icon-96x96.png", "sizes": "96x96", "type": "image/png" },
echo     { "src": "android-icon-144x144.png", "sizes": "144x144", "type": "image/png" },
echo     { "src": "android-icon-192x192.png", "sizes": "192x192", "type": "image/png" },
echo     { "src": "apple-touch-icon-57x57.png", "sizes": "57x57", "type": "image/png" },
echo     { "src": "apple-touch-icon-60x60.png", "sizes": "60x60", "type": "image/png" },
echo     { "src": "apple-touch-icon-72x72.png", "sizes": "72x72", "type": "image/png" },
echo     { "src": "apple-touch-icon-76x76.png", "sizes": "76x76", "type": "image/png" },
echo     { "src": "apple-touch-icon-114x114.png", "sizes": "114x114", "type": "image/png" },
echo     { "src": "apple-touch-icon-120x120.png", "sizes": "120x120", "type": "image/png" },
echo     { "src": "apple-touch-icon-144x144.png", "sizes": "144x144", "type": "image/png" },
echo     { "src": "apple-touch-icon-152x152.png", "sizes": "152x152", "type": "image/png" },
echo     { "src": "favicon-16x16.png", "sizes": "16x16", "type": "image/png" },
echo     { "src": "favicon-32x32.png", "sizes": "32x32", "type": "image/png" },
echo     { "src": "favicon-96x96.png", "sizes": "96x96", "type": "image/png" },
echo     { "src": "favicon-128.png", "sizes": "128x128", "type": "image/png" },
echo     { "src": "favicon.ico", "sizes": "any", "type": "image/x-icon" },
echo     { "src": "mstile-70x70.png", "sizes": "70x70", "type": "image/png" },
echo     { "src": "mstile-144x144.png", "sizes": "144x144", "type": "image/png" },
echo     { "src": "mstile-150x150.png", "sizes": "150x150", "type": "image/png" },
echo     { "src": "mstile-310x310.png", "sizes": "310x310", "type": "image/png" }
echo   ]
echo }
) > manifest.json

echo Conversion completed.
pause
