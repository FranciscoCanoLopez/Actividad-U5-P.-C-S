# VB.NET Hub Module

## Overview
Este módulo contiene los servicios **REST** y **SOAP** y un cliente de consola, desarrollados con **.NET 10** y el servidor embebido **Kestrel**.

## REST Service
- **Puerto:** `5003`
- **Inicio:** Ejecuta `run_services.bat` y elige la opción **1** o ejecuta directamente `dotnet run` dentro de la carpeta `rest-service`.
- **Swagger UI:** <http://localhost:5003/swagger>
- **JWT:** Implementado con `Microsoft.AspNetCore.Authentication.JwtBearer` y clave definida en el código (`jwtSecret`).

## SOAP Service
- **Puerto:** `5004`
- **Inicio:** `run_services.bat` opción **2** o `dotnet run` dentro de `soap-service`.
- **WSDL:** <http://localhost:5004/Service.svc?wsdl>

## Client
- **Inicio:** `run_services.bat` opción **3** o `dotnet run` dentro de `client`.
- El cliente se autentica contra `/api/v1/auth/login` y consume los endpoints REST y SOAP.

## Prerequisitos
- .NET SDK 10 instalado y añadido al `PATH`.
- `dotnet` disponible en la línea de comandos.

## Notas
- Los scripts `run_services.bat` están configurados para abrir automáticamente la UI de Swagger después de iniciar el servicio REST.
- Los secretos JWT están hard‑codeados en el código de ejemplo; reemplazarlos por variables de entorno en producción.

---
[Volver al índice del HUB](../README.md)