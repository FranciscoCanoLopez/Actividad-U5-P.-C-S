@echo off
title Hub - Java Module Manager
color 0A

:MENU
cls
echo ===================================================
echo               HUB - JAVA MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 8081)
echo   2. Iniciar Servidor SOAP (Puerto 8082)
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
echo Iniciando Hub REST Service (Spring Boot)...
start "Hub - Java REST (8081)" cmd /k "title Hub-Java-REST (8081) && cd rest-service && mvn clean spring-boot:run"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8081/swagger-ui.html"
goto MENU

:SOAP
echo Iniciando Hub SOAP Service (JAX-WS)...
start "Hub - Java SOAP (8082)" cmd /k "title Hub-Java-SOAP (8082) && cd soap-service && mvn clean compile exec:java"
goto MENU

:CLIENT
echo Ejecutando Hub Client (Java)...
start "Hub - Java Client" cmd /k "title Hub-Java-Client && cd client && mvn clean compile exec:java"
goto MENU

:ALL
echo Iniciando infraestructura completa del Hub (Java)...
start "Hub - Java REST (8081)" cmd /k "title Hub-Java-REST (8081) && cd rest-service && mvn clean spring-boot:run"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8081/swagger-ui.html"
start "Hub - Java SOAP (8082)" cmd /k "title Hub-Java-SOAP (8082) && cd soap-service && mvn clean compile exec:java"

echo.
echo [INFO] Esperando 12 segundos para que Tomcat (Spring Boot) inicie correctamente...
timeout /t 12 >nul

start "Hub - Java Client" cmd /k "title Hub-Java-Client && cd client && mvn clean compile exec:java"
goto MENU

:END
exit
