# Ruby Hub Module

## Overview
Este módulo implementa los servicios **REST** (Sinatra) y **SOAP** (Sinatra + Nokogiri) y un cliente de consola.

## REST Service
- **Puerto:** `8085`
- **Inicio:** Ejecuta `run_services.bat` → opción **1** o `ruby app.rb` dentro de `rest-service`.
- **Swagger UI:** <http://localhost:8085/swagger>
- **JWT:** HS256 configurado en `app.rb`.

## SOAP Service
- **Puerto:** `8086`
- **Inicio:** `run_services.bat` → opción **2** o `ruby app.rb` dentro de `soap-service`.
- **WSDL:** <http://localhost:8086/wsdl>

## Client
- **Inicio:** `run_services.bat` → opción **3** o `ruby client.rb` dentro de `client`.
- El cliente autentica contra `/api/v1/auth/login` y consume ambos servicios.

## Prerequisitos
- Ruby 3.2+ y Bundler.
- Ejecutar `bundle install` dentro de `rest-service` y `soap-service`.

---
[Volver al índice del HUB](../README.md)