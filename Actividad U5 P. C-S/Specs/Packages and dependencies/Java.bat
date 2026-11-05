@echo off
echo ===================================================
echo   Inicializando dependencias de Java - Maven
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\java"

where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo [ADVERTENCIA] Apache Maven no esta instalado o no esta en el PATH de Windows.
    echo Por favor instala Maven y agregalo al PATH para gestionar dependencias Java.
    goto END
)

echo [1/2] Verificando Java REST...
cd /d "%HUB_DIR%\rest-service"
if exist "pom.xml" (
    call mvn dependency:resolve
) else (
    echo [INFO] pom.xml no encontrado en rest-service. Se generara en la Fase 3.
)

echo [2/2] Verificando Java SOAP...
cd /d "%HUB_DIR%\soap-service"
if exist "pom.xml" (
    call mvn dependency:resolve
) else (
    echo [INFO] pom.xml no encontrado en soap-service. Se generara en la Fase 3.
)

:END
echo Finalizado Java.