# Python Hub Module

## Overview
Este módulo implementa los servicios **REST** (FastAPI) y **SOAP** (Spyne) y un cliente de consola.

## REST Service
- **Puerto:** `8000`
- **Inicio:** Ejecuta `run_services.bat` → opción **1** o `python -m uvicorn main:app --host 127.0.0.1 --port 8000` dentro de `rest-service`.
- **Swagger UI:** <http://localhost:8000/docs>
- **JWT:** HS256 usando la clave definida en `main.py`.

## SOAP Service
- **Puerto:** `8005`
- **Inicio:** `run_services.bat` → opción **2** o `python main.py` dentro de `soap-service`.
- **WSDL:** <http://localhost:8005/?wsdl>

## Client
- **Inicio:** `run_services.bat` → opción **3** o `python main.py` dentro de `client`.
- El cliente solicita un token y consume ambos servicios.

## Prerequisitos
- Python 3.11+ y virtualenv.
- Instalar dependencias con `pip install -r requirements.txt`.

---
[Volver al índice del HUB](../README.md)