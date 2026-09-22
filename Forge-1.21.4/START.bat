@echo off
chcp 65001 >nul
title Serveur Minecraft Forge 1.21.4
cd /d "%~dp0server"
if not exist run.bat (
 echo Forge n'est pas installe. Lance d'abord INSTALL.bat dans le dossier parent.
 pause
 exit /b 1
)
if not exist eula.txt (
 echo Premier lancement : Forge va generer les fichiers et afficher les conditions EULA.
 call run.bat nogui
 if exist eula.txt (
  echo Lis eula.txt. Si tu acceptes le EULA, remplace eula=false par eula=true.
  echo Puis relance START.bat.
 )
 pause
 exit /b
)
findstr /i /c:"eula=true" eula.txt >nul
if errorlevel 1 (
 echo Lis eula.txt et accepte le EULA en mettant eula=true, puis relance.
 pause
 exit /b 1
)
call run.bat nogui
pause
