@echo off
echo ===================================================
echo   Inicializando dependencias de C# (.NET 8)
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\csharp"

echo [1/3] Configurando C# RESTful Service...
cd /d "%HUB_DIR%\rest-service"
dotnet new webapi --force --no-https
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer

echo [2/3] Configurando C# SOAP Service...
cd /d "%HUB_DIR%\soap-service"
dotnet new web --force
dotnet add package CoreWCF.Http
dotnet add package CoreWCF.Primitives
dotnet add package CoreWCF.Metadata

echo [3/3] Configurando C# Client...
cd /d "%HUB_DIR%\client"
dotnet new console --force

echo Finalizado C#.