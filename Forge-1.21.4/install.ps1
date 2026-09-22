$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$server = Join-Path $root 'server'
$mc = '1.21.4'
$forge = '54.1.14'

$java = Get-Command java -ErrorAction SilentlyContinue
if (-not $java) { throw 'Java introuvable. Installe Java 21 (64 bits), puis recommence.' }
$ver = (& java -version 2>&1 | Out-String)
Write-Host $ver
if ($ver -notmatch '21') { throw 'Java 21 est requis.' }

New-Item -ItemType Directory -Force -Path $server | Out-Null
$installer = Join-Path $server "forge-$mc-$forge-installer.jar"
$url = "https://maven.minecraftforge.net/net/minecraftforge/forge/$mc-$forge/forge-$mc-$forge-installer.jar"
Write-Host "Telechargement Forge $forge pour Minecraft $mc..."
Invoke-WebRequest -Uri $url -OutFile $installer
Write-Host 'Installation des fichiers serveur Forge...'
Push-Location $server
try { & java -jar $installer --installServer; if ($LASTEXITCODE -ne 0) { throw 'L installateur Forge a echoue.' } }
finally { Pop-Location }
Write-Host 'Installation terminee.'
Write-Host 'Ajoute tes mods compatibles Minecraft 1.21.4 / Forge dans le dossier server\mods.'
