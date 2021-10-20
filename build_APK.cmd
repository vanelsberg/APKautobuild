@echo off
setlocal enableextensions
@cd /d "%~dp0"

rem Building from Windows 10 command line:

rem Mounting local data on container
set data_mount=/data
set data_local=%~dp0%data

rem Docker image (public access)
set image=theod00r/apkbuilder:1.0.0

rem Run container in interactive mode
docker run --rm -v "%data_local%:%data_mount%" -it %image% %1
