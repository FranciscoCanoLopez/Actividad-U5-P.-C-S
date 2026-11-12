# PHP Hub Module

## Overview
Este módulo contiene los servicios **REST** (Slim) y **SOAP** (ext‑soap) junto con una aplicación cliente.

## REST Service
- **Puerto:** `8083`
- **Inicio:** Ejecuta `run_services.bat` → opción **1** o `php -S localhost:8083 -t public` dentro de `rest-service`.
- **Swagger UI:** <http://localhost:8083/swagger>
- **JWT:** HS256 configurado en `index.php`.

## SOAP Service
- **Puerto:** `8084`
- **Inicio:** `run_services.bat` → opción **2** o `php -S localhost:8084` dentro de `soap-service`.
- **WSDL:** <http://localhost:8084/service.wsdl>

## Client
- **Inicio:** `run_services.bat` → opción **3** o `php client.php` dentro de `client`.
- El cliente solicita un token y consume ambos servicios.

## Prerequisitos
- PHP 8.2+ con la extensión **soap** habilitada.
- Composer instalado (`composer install`).

---
[Volver al índice del HUB](../README.md)