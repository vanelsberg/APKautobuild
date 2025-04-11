@echo off
setlocal enableextensions
@cd /d "%~dp0"

echo "Generating new keystore:"

win_build_APK.cmd ./generate-key.sh
