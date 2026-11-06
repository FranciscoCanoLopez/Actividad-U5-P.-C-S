@echo off
echo ===================================================
echo   Inicializando dependencias de Python 3.11
echo ===================================================

set "HUB_DIR=%~dp0..\..\HUB\python"

echo [1/3] Configurando venv e instalando paquetes para Python REST...
cd /d "%HUB_DIR%\rest-service"
if not exist "venv" python -m venv venv
call "%HUB_DIR%\rest-service\venv\Scripts\activate.bat"
python -m pip install --upgrade pip --quiet
pip install fastapi uvicorn pydantic python-jose[cryptography] passlib[bcrypt]
call deactivate

echo [2/3] Configurando venv e instalando paquetes para Python SOAP...
cd /d "%HUB_DIR%\soap-service"
if not exist "venv" python -m venv venv
call "%HUB_DIR%\soap-service\venv\Scripts\activate.bat"
python -m pip install --upgrade pip --quiet
pip install spyne lxml
call deactivate

echo [3/3] Configurando venv e instalando paquetes para Python Client...
cd /d "%HUB_DIR%\client"
if not exist "venv" python -m venv venv
call "%HUB_DIR%\client\venv\Scripts\activate.bat"
python -m pip install --upgrade pip --quiet
pip install requests zeep
call deactivate

echo Finalizado Python.