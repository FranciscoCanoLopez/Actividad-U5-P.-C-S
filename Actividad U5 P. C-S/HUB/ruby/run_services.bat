@echo off
title Hub - Ruby Module Manager
color 0C

:MENU
cls
echo ===================================================
echo               HUB - RUBY MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 8085)
echo   2. Iniciar Servidor SOAP (Puerto 8086)
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
echo Iniciando Hub REST Service (Sinatra)...
start "Hub - Ruby REST (8085)" cmd /k "title Hub-Ruby-REST (8085) && cd rest-service && ruby app.rb"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8085/swagger"
goto MENU

:SOAP
echo Iniciando Hub SOAP Service (Sinatra/Nokogiri)...
start "Hub - Ruby SOAP (8086)" cmd /k "title Hub-Ruby-SOAP (8086) && cd soap-service && ruby app.rb"
goto MENU

:CLIENT
echo Ejecutando Hub Client (Ruby)...
start "Hub - Ruby Client" cmd /k "title Hub-Ruby-Client && cd client && ruby client.rb"
goto MENU

:ALL
echo Iniciando infraestructura completa del Hub (Ruby)...
start "Hub - Ruby REST (8085)" cmd /k "title Hub-Ruby-REST (8085) && cd rest-service && ruby app.rb"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8085/swagger"
start "Hub - Ruby SOAP (8086)" cmd /k "title Hub-Ruby-SOAP (8086) && cd soap-service && ruby app.rb"

echo.
echo [INFO] Esperando 5 segundos para que Puma inicie correctamente...
timeout /t 5 >nul

start "Hub - Ruby Client" cmd /k "title Hub-Ruby-Client && cd client && ruby client.rb"
goto MENU

:END
exit