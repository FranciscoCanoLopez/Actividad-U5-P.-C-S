@echo off
echo ===================================================
echo   Inicializando dependencias de PHP 8.2 (Composer)
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\php"

where composer >nul 2>nul
if %errorlevel% neq 0 (
    echo [ADVERTENCIA] 'composer' no esta instalado o no esta en el PATH de Windows.
    echo Descarga e instala Composer desde https://getcomposer.org/
    goto END
)

echo [1/3] Instalando dependencias PHP REST...
cd /d "%HUB_DIR%\rest-service"
call composer require slim/slim "^4.0" slim/psr7 firebase/php-jwt zircote/swagger-php --no-interaction

echo [2/3] Instalando dependencias PHP SOAP...
cd /d "%HUB_DIR%\soap-service"
call composer require laminas/laminas-soap --no-interaction

echo [3/3] Instalando dependencias PHP Client...
cd /d "%HUB_DIR%\client"
call composer require guzzlehttp/guzzle --no-interaction

:END
echo Finalizado PHP.