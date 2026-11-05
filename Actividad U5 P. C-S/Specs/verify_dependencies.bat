@echo off
title OmniLogistics Hub - Verificacion de Dependencias y Entorno
color 0B

echo ============================================================
echo   OMNILOGISTICS HUB - VERIFICACION DE HERRAMIENTAS Y SDKS
echo ============================================================
echo.

set FAIL_COUNT=0
set WARN_COUNT=0
set OK_COUNT=0

echo ------------------------------------------------------------
echo [1/6] Verificando entorno .NET - C# / VB.NET...
echo ------------------------------------------------------------
where dotnet >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] .NET CLI encontrado:
    dotnet --version
    set /a OK_COUNT+=1
) else (
    echo [ERROR] .NET SDK no esta instalado o no se encuentra en el PATH.
    echo         Descarga recomendada: .NET 8.0 SDK - https://dotnet.microsoft.com/
    set /a FAIL_COUNT+=1
)
echo.

echo ------------------------------------------------------------
echo [2/6] Verificando entorno Java - JDK 17 + Maven...
echo ------------------------------------------------------------
where java >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Java runtime encontrado:
    java -version 2>&1 | findstr /i "version"
    set /a OK_COUNT+=1
) else (
    echo [ERROR] Java JDK no esta instalado o no se encuentra en el PATH.
    set /a FAIL_COUNT+=1
)

where mvn >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Apache Maven encontrado:
    mvn -version 2>&1 | findstr /i "Apache Maven"
    set /a OK_COUNT+=1
) else (
    echo [ADVERTENCIA] Apache Maven no se encuentra en el PATH.
    echo               Necesario para compilar/resolver dependencias Java.
    set /a WARN_COUNT+=1
)
echo.

echo ------------------------------------------------------------
echo [3/6] Verificando entorno Python 3.11+...
echo ------------------------------------------------------------
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Python encontrado:
    python --version
    set /a OK_COUNT+=1
) else (
    echo [ERROR] Python 3 no esta instalado o no se encuentra en el PATH.
    set /a FAIL_COUNT+=1
)

where pip >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Pip para Python encontrado:
    pip --version
    set /a OK_COUNT+=1
) else (
    echo [ADVERTENCIA] pip no se encuentra en el PATH.
    set /a WARN_COUNT+=1
)
echo.

echo ------------------------------------------------------------
echo [4/6] Verificando entorno PHP 8.2+ - PHP + Composer...
echo ------------------------------------------------------------
where php >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] PHP CLI encontrado:
    php -v 2>&1 | findstr /i "PHP"
    set /a OK_COUNT+=1
) else (
    echo [ERROR] PHP 8.2+ no esta instalado o no se encuentra en el PATH.
    set /a FAIL_COUNT+=1
)

where composer >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Composer encontrado:
    composer --version 2>&1 | findstr /i "Composer"
    set /a OK_COUNT+=1
) else (
    echo [ADVERTENCIA] Composer no se encuentra en el PATH.
    set /a WARN_COUNT+=1
)
echo.

echo ------------------------------------------------------------
echo [5/6] Verificando entorno Ruby 3.2+ - Ruby + Bundler...
echo ------------------------------------------------------------
where ruby >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Ruby interpretador encontrado:
    ruby -v
    set /a OK_COUNT+=1
) else (
    echo [ERROR] Ruby no esta instalado o no se encuentra en el PATH.
    set /a FAIL_COUNT+=1
)

where bundle >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Bundler bundle encontrado:
    bundle -v
    set /a OK_COUNT+=1
) else (
    echo [ADVERTENCIA] Bundler bundle no se encuentra en el PATH.
    set /a WARN_COUNT+=1
)
echo.

echo ------------------------------------------------------------
echo [6/6] Verificando Herramientas Auxiliares - Git / cURL...
echo ------------------------------------------------------------
where git >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] Git CLI encontrado.
    set /a OK_COUNT+=1
) else (
    echo [INFO] Git no detectado en PATH - Opcional.
)

where curl >nul 2>nul
if %errorlevel% equ 0 (
    echo [OK] cURL CLI encontrado.
    set /a OK_COUNT+=1
) else (
    echo [INFO] cURL no detectado en PATH - Opcional.
)
echo.

echo ============================================================
echo   RESUMEN DIAGNOSTICO DEL ENTORNO
echo ============================================================
echo   Herramientas instaladas correctamente : %OK_COUNT%
echo   Advertencias - herramientas faltantes : %WARN_COUNT%
echo   Errores criticos - SDKs faltantes     : %FAIL_COUNT%
echo ============================================================

if %FAIL_COUNT% gtr 0 (
    echo.
    echo [ATENCION] Existen SDKs fundamentales que no estan instalados o configurados en el PATH.
    echo Revise la documentacion en Specs\README.md para mas detalles.
) else if %WARN_COUNT% gtr 0 (
    echo.
    echo [NOTA] Los SDKs principales estan listos, pero faltan gestores de paquetes o herramientas auxiliares.
) else (
    echo.
    echo [CORRECTO] Todo el entorno esta completamente preparado para desarrollar y ejecutar los servicios!
)

echo.
pause