# Hub - Módulo Python (FastAPI + Spyne)

Este directorio contiene la implementación en Python del Hub, integrando una arquitectura dual de microservicios para garantizar la interoperabilidad entre servicios web modernos (REST) y corporativos heredados (SOAP).

## Estructura del Ecosistema

El módulo está compuesto por tres subproyectos independientes:

1. **`rest-service` (Puerto 8000):**
   * Servidor ASGI basado en **FastAPI** y **Uvicorn**.
   * Expone endpoints RESTful con serialización JSON.
   * Cuenta con seguridad mediante tokens JWT (`pyjwt`).
   * Incluye documentación interactiva nativa en `/docs`.

2. **`soap-service` (Puerto 8005):**
   * Servidor WSGI basado en **Spyne** y **Werkzeug**.
   * Expone contratos de datos XML tipados y el descriptor WSDL (`/?wsdl`).
   * Implementa un parche de compatibilidad dinámico optimizado para soportar entornos de ejecución recientes (Python 3.14+).

3. **`client` (Cliente de Consola Híbrido):**
   * Script unificado de pruebas.
   * Utiliza la librería `requests` para consumir la autenticación y endpoints REST.
   * Utiliza la librería `zeep` para parsear dinámicamente el WSDL y consumir el servicio SOAP mediante llamadas RPC.

## Gestión y Ejecución

Para facilitar el levantamiento de los servicios, se incluye el script automatizado `run_services.bat` en la raíz de este directorio, permitiendo arrancar los servidores y el cliente de forma individual o integral en ventanas de comandos separadas.