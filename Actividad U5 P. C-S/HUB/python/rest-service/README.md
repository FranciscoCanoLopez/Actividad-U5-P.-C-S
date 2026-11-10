# Python REST Service (FastAPI) - Hub

Este directorio contiene el microservicio RESTful del Hub, desarrollado en Python utilizando el framework **FastAPI**.

## Características

* **Framework:** FastAPI (Python 3.10+).
* **Servidor ASGI:** Uvicorn.
* **Puerto asignado:** `8000` (Localhost).
* **Seguridad:** Autenticación JWT (`pyjwt`) implementando esquema Bearer.
* **Documentación Automática:** Swagger UI disponible nativamente en `/docs`.

## Endpoints Principales

* `POST /api/v1/auth/login`: Autenticación para obtener token JWT (credenciales hardcodeadas: `omni_admin` / `SecuredPass2026!`).
* `GET /api/v1/shipments`: Retorna el catálogo inicial de envíos (Requiere Bearer Token).

## Instrucciones de Ejecución

Para iniciar el servidor, es recomendable usar un entorno virtual (`venv`). Ejecuta los siguientes comandos en tu terminal desde esta carpeta:

```bash
pip install -r requirements.txt
python -m uvicorn main:app --host 127.0.0.1 --port 8000