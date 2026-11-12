@echo off
title Hub - PHP Module Manager
color 0D

:MENU
cls
echo ===================================================
echo               HUB - PHP MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 8083)
echo   2. Iniciar Servidor SOAP (Puerto 8084)
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
echo Iniciando Hub REST Service (Slim Framework)...
start "Hub - PHP REST (8083)" cmd /k "title Hub-PHP-REST (8083) && cd rest-service && php -S localhost:8083 -t public"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8083/swagger"
goto MENU

:SOAP
echo Iniciando Hub SOAP Service (ext-soap)...
start "Hub - PHP SOAP (8084)" cmd /k "title Hub-PHP-SOAP (8084) && cd soap-service && php -S localhost:8084"
goto MENU

:CLIENT
echo Ejecutando Hub Client (PHP)...
start "Hub - PHP Client" cmd /k "title Hub-PHP-Client && cd client && php client.php"
goto MENU

:ALL
echo Iniciando infraestructura completa del Hub (PHP)...
start "Hub - PHP REST (8083)" cmd /k "title Hub-PHP-REST (8083) && cd rest-service && php -S localhost:8083 -t public"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8083/swagger"
start "Hub - PHP SOAP (8084)" cmd /k "title Hub-PHP-SOAP (8084) && cd soap-service && php -S localhost:8084"

echo.
echo [INFO] Esperando 5 segundos para que los servidores internos de PHP levanten...
timeout /t 5 >nul

start "Hub - PHP Client" cmd /k "title Hub-PHP-Client && cd client && php client.php"
goto MENU

:END
exit