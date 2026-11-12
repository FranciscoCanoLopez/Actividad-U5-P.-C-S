# C# Hub Module

## Overview
Este módulo implementa los servicios **REST** y **SOAP** y un cliente de consola usando **.NET 10** y **Kestrel** como servidor embebido.

## REST Service
- **Puerto:** `5001`
- **Inicio:** Ejecuta `run_services.bat` y elige la opción **1** o bien ejecuta directamente `dotnet run` dentro de la carpeta `rest-service`.
- **Swagger UI:** <http://localhost:5001/swagger>
- **JWT:** Usa el algoritmo HS256 con la clave definida en `appsettings.json`.

## SOAP Service
- **Puerto:** `5002`
- **Inicio:** `run_services.bat` opción **2** o `dotnet run` en `soap-service`.
- **WSDL:** <http://localhost:5002/Service.svc?wsdl>

## Client
- **Inicio:** `run_services.bat` opción **3** o `dotnet run` en `client`.
- El cliente autentica contra `/api/v1/auth/login` y consume los endpoints REST y SOAP.

## Prerequisitos
- .NET SDK 10 instalado y añadido al `PATH`.
- `dotnet` disponible en la línea de comandos.

## Notas
- Los archivos **run_services.bat** están configurados para abrir automáticamente la UI de Swagger después de iniciar el servicio REST.
- Los secretos JWT están definidos en `appsettings.json` (no modificar en producción).

---
[Volver al índice del HUB](../README.md)