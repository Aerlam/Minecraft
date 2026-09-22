@echo off
chcp 65001 >nul
title Minecraft Paper 1.21.4
cd /d "%~dp0server"
if not exist paper.jar (
 echo Paper absent. Lance d'abord INSTALL.bat.
 pause
 exit /b 1
)
if not exist eula.txt (
 echo Premier lancement : generation des fichiers serveur.
 java -Xms2G -Xmx4G -jar paper.jar --nogui
 if exist eula.txt (
  echo Lis eula.txt et accepte-le manuellement si tu es d'accord.
  echo Puis relance START.bat.
 )
 pause
 exit /b
)
findstr /i /c:"eula=true" eula.txt >nul
if errorlevel 1 (
 echo Tu dois lire et accepter le EULA dans eula.txt avant de lancer.
 pause
 exit /b 1
)
java -Xms2G -Xmx4G -jar paper.jar --nogui
pause
