@echo off
setlocal enableextensions
@cd /d "%~dp0"

rem Building from Windows 10 command line:

rem Mounting local data on container
set data_mount=/data
set data_local=%~dp0%data

rem set docker_runparam="--memory=4g"
set docker_runparam=

rem Docker image (public access)
set image=theod00r/apkbuilder:1.1.20

rem Run container in interactive mode
rem docker run --rm %docker_runparam% --name AAPSbuilder -v "%data_local%:%data_mount%" -it %image% %1

rem docker volume rm volAAPSgit
rem docker volume rm volAAPSgradle

set mount_volAAPSgradle=-v volAAPSgradle:/root/.gradle
set mount_volAAPSgit=-v volAAPSgit:/user/src/asbuilder/AndroidAPS
set mount_data=-v %data_local%:%data_mount%

rem Run container in interactive mode
docker run %docker_runparam% --rm --name AAPSbuilder %mount_volAAPSgradle% %mount_volAAPSgit% %mount_data% -it %image% %1
