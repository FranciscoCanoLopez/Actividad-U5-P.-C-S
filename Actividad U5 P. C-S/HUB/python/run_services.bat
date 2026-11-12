@echo off
title Hub - Python Module Manager
color 0B

:MENU
cls
echo ===================================================
echo               HUB - PYTHON MODULE
echo ===================================================
echo.
echo   1. Iniciar Servidor REST (Puerto 8000)
echo   2. Iniciar Servidor SOAP (Puerto 8005)
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
echo Iniciando Hub REST Service (FastAPI)...
start "Hub - Python REST (8000)" cmd /k "title Hub-Python-REST (8000) && cd rest-service && python -m uvicorn main:app --host 127.0.0.1 --port 8000"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8000/docs"
goto MENU

:SOAP
echo Iniciando Hub SOAP Service (Spyne)...
start "Hub - Python SOAP (8005)" cmd /k "title Hub-Python-SOAP (8005) && cd soap-service && python main.py"
goto MENU

:CLIENT
echo Ejecutando Hub Client (Python)...
start "Hub - Python Client" cmd /k "title Hub-Python-Client && cd client && python main.py"
goto MENU

:ALL
echo Iniciando infraestructura completa del Hub (Python)...
start "Hub - Python REST (8000)" cmd /k "title Hub-Python-REST (8000) && cd rest-service && python -m uvicorn main:app --host 127.0.0.1 --port 8000"
rem Abrir Swagger UI en el navegador
start "" "http://localhost:8000/docs"
start "Hub - Python SOAP (8005)" cmd /k "title Hub-Python-SOAP (8005) && cd soap-service && python main.py"

echo.
echo [INFO] Esperando 5 segundos para que los servidores levanten...
timeout /t 5 >nul

start "Hub - Python Client" cmd /k "title Hub-Python-Client && cd client && python main.py"
goto MENU

:END
exit