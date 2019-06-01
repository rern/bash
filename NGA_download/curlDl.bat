:: Usage: curlDl.bat "NAME" COUNT TOPRIGHT "URL"

:: curlDl.bat "The Houses of Parliament, Sunset" 3952 66 "https://media.nga.gov/fastcgi/iipsrv.fcgi?FIF=/public/objects/4/6/5/2/3/46523-primary-0-nativeres.ptif&SDS=0,90&JTL=8,"

@echo off

set name=%1
set /A count=%2
set /A tile=%3+1x
set url=%4
:: remove last " for appending number
set url=%url:~0,-1%

if exist %name% (
	echo Directory: %name% exists.
	exit /B
)

md %name%
cd %name%
echo.
echo Download image blocks ...
echo.
echo URL: %url%
echo.
setlocal EnableDelayedExpansion
for /L %%i in (0,1,%count%) do (
	set filename=000%%i
	set filename=!filename:~-4!
	echo %%i/%count% !filename!.jpg
	curl -# -o "!filename!.jpg" %url%%%i"
)
echo.
echo Merge blocks into single image...

magick montage *.* -geometry +0+0 -tile %tile% ../%name%.jpg

echo.
echo File: %name%.jpg
