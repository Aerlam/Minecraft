@echo off
chcp 65001 >nul
title Installation Paper 1.21.4
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if errorlevel 1 (
 echo.
 echo Installation echouee. Verifie Java 21 et ta connexion.
 pause
 exit /b 1
)
echo.
echo Installation terminee. Lance START.bat.
pause
