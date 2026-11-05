@echo off
echo ===================================================
echo   Inicializando dependencias de Ruby 3.2 (Bundler)
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\ruby"

where bundle >nul 2>nul
if %errorlevel% neq 0 (
    echo [ADVERTENCIA] 'bundle' no esta instalado o no esta en el PATH de Windows.
    echo Instala Ruby installer con DevKit y ejecuta 'gem install bundler'.
    goto END
)

echo [1/3] Inicializando Ruby REST...
cd /d "%HUB_DIR%\rest-service"
if not exist "Gemfile" call bundle init

echo [2/3] Inicializando Ruby SOAP...
cd /d "%HUB_DIR%\soap-service"
if not exist "Gemfile" call bundle init

echo [3/3] Inicializando Ruby Client...
cd /d "%HUB_DIR%\client"
if not exist "Gemfile" call bundle init

:END
echo Finalizado Ruby.