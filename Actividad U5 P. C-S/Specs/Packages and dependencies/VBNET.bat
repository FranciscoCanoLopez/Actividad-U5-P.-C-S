@echo off
echo ===================================================
echo   Inicializando dependencias de VB.NET (.NET 8)
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\vbnet"

echo [1/3] Configurando VB.NET RESTful Service...
cd /d "%HUB_DIR%\rest-service"
dotnet new console -lang "VB" --force
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer

echo [2/3] Configurando VB.NET SOAP Service...
cd /d "%HUB_DIR%\soap-service"
dotnet new console -lang "VB" --force
dotnet add package CoreWCF.Http
dotnet add package CoreWCF.Primitives
dotnet add package CoreWCF.Metadata

echo [3/3] Configurando VB.NET Client...
cd /d "%HUB_DIR%\client"
dotnet new console -lang "VB" --force

echo Finalizado VB.NET.