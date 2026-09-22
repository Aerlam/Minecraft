$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$server = Join-Path $root "server"
$version = "1.21.4"
$java = Get-Command java -ErrorAction SilentlyContinue
if (-not $java) { throw "Java introuvable. Installe Java 21 puis recommence." }
$ver = (& java -version 2>&1 | Out-String)
Write-Host $ver
if ($ver -notmatch '21') { throw "Java 21 est requis. Installe Java 21 puis recommence." }
New-Item -ItemType Directory -Force -Path $server | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $server "plugins") | Out-Null
$api = "https://api.papermc.io/v2/projects/paper/versions/$version"
$info = Invoke-RestMethod -Uri $api
$build = ($info.builds | Measure-Object -Maximum).Maximum
if (-not $build) { throw "Aucun build Paper trouve." }
$buildInfo = Invoke-RestMethod -Uri "$api/builds/$build"
$name = $buildInfo.downloads.application.name
$url = "$api/builds/$build/downloads/$name"
$out = Join-Path $server "paper.jar"
Write-Host "Telechargement Paper $version build $build..."
Invoke-WebRequest -Uri $url -OutFile $out
Write-Host "Termine : $out"
