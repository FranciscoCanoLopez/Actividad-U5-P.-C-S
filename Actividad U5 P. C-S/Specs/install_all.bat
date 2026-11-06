@echo off
title HUB - Instalador General de Dependencias
color 0A

echo ============================================================
echo  HUB - INSTALACION GLOBAL DE DEPENDENCIAS
echo ============================================================
echo.

set "SCRIPT_DIR=%~dp0Packages and dependencies"

echo --^> [1/6] Ejecutando instalacion C#...
call "%SCRIPT_DIR%\Csharp.bat"

echo --^> [2/6] Ejecutando instalacion VB.NET...
call "%SCRIPT_DIR%\VBNET.bat"

echo --^> [3/6] Ejecutando instalacion Java...
call "%SCRIPT_DIR%\Java.bat"

echo --^> [4/6] Ejecutando instalacion Python...
call "%SCRIPT_DIR%\Python.bat"

echo --^> [5/6] Ejecutando instalacion PHP...
call "%SCRIPT_DIR%\PHP.bat"

echo --^> [6/6] Ejecutando instalacion Ruby...
call "%SCRIPT_DIR%\Ruby.bat"

echo.
echo ============================================================
echo   PROCESO FINALIZADO CORRECTAMENTE
echo ============================================================
pause