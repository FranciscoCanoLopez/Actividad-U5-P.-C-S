@echo off
title Hub - C# Module Manager
color 0A

:MENU
cls
echo ===================================================
echo               HUB - C# (.NET 10) MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 5001)
echo   2. Iniciar Servidor SOAP (Puerto 5002)
echo   3. Ejecutar Cliente de Consola
echo   4. Levantar TODO (REST, SOAP y Cliente)
echo   5. Salir
echo.
echo ===================================================
set /p option="Selecciona una opcion (1-5): "

if "%option%"=="1" goto REST
if "%option%"=="2" goto SOAP
if "%option%"=="3" goto CLIENT
if "%option%"=="4" goto ALL
if "%option%"=="5" goto END

goto MENU

:REST
echo Iniciando Hub REST Service...
start "Hub - C# REST Service" cmd /k "title Hub-REST (5001) && cd rest-service && dotnet run"
goto MENU

:SOAP
echo Iniciando Hub SOAP Service...
start "Hub - C# SOAP Service" cmd /k "title Hub-SOAP (5002) && cd soap-service && dotnet run"
goto MENU

:CLIENT
echo Ejecutando Hub Client...
start "Hub - C# Client" cmd /k "title Hub-Client && cd client && dotnet run"
goto MENU

:ALL
echo Iniciando infraestructura completa del Hub...
start "Hub - C# REST Service" cmd /k "title Hub-REST (5001) && cd rest-service && dotnet run"
start "Hub - C# SOAP Service" cmd /k "title Hub-SOAP (5002) && cd soap-service && dotnet run"

echo.
echo [INFO] Esperando 5 segundos para que los servidores levanten...
timeout /t 5 >nul

start "Hub - C# Client" cmd /k "title Hub-Client && cd client && dotnet run"
goto MENU

:END
exit