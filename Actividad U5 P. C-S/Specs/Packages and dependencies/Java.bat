@echo off
echo ===================================================
echo   Inicializando dependencias de Java (Maven)
echo ===================================================

set BASE_DIR=%~dp0..\..\HUB\java

echo [1/2] Descargando dependencias Java REST...
cd /d "%BASE_DIR%\rest-service"
call mvn dependency:resolve

echo [2/2] Descargando dependencias Java SOAP...
cd /d "%BASE_DIR%\soap-service"
call mvn dependency:resolve

echo Finalizado entorno Java.
pause