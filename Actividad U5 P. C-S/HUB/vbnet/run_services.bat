@echo off
title Hub - VB.NET Module Manager
color 09

:MENU
cls
echo ===================================================
echo               HUB - VB.NET MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 5003)
echo   2. Iniciar Servidor SOAP (Puerto 5004)
echo   3. Ejecutar Cliente Hibrido
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
start "Hub - VBNET REST (5003)" cmd /k "title Hub-VBNET-REST (5003) && cd rest-service && dotnet run"
goto MENU

:SOAP
start "Hub - VBNET SOAP (5004)" cmd /k "title Hub-VBNET-SOAP (5004) && cd soap-service && dotnet run"
goto MENU

:CLIENT
start "Hub - VBNET Client" cmd /k "title Hub-VBNET-Client && cd client && dotnet run"
goto MENU

:ALL
start "Hub - VBNET REST (5003)" cmd /k "title Hub-VBNET-REST (5003) && cd rest-service && dotnet run"
start "Hub - VBNET SOAP (5004)" cmd /k "title Hub-VBNET-SOAP (5004) && cd soap-service && dotnet run"
timeout /t 6 >nul
start "Hub - VBNET Client" cmd /k "title Hub-VBNET-Client && cd client && dotnet run"
goto MENU

:END
exit