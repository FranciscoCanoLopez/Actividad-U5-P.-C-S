# Java Hub Module

## Overview
Este módulo contiene los servicios **REST** (Spring Boot) y **SOAP** (JAX‑WS) junto con una aplicación cliente.

## REST Service
- **Puerto:** `8081`
- **Inicio:** Ejecuta `run_services.bat` → opción **1** o `mvn clean spring-boot:run` dentro de `rest-service`.
- **Swagger UI:** <http://localhost:8081/swagger-ui.html>
- **JWT:** Configurado en `application.yml` (HS256).

## SOAP Service
- **Puerto:** `8082`
- **Inicio:** `run_services.bat` → opción **2** o `mvn clean compile exec:java` dentro de `soap-service`.
- **WSDL:** <http://localhost:8082/yourService?wsdl>

## Client
- **Inicio:** `run_services.bat` → opción **3** o `mvn clean compile exec:java` dentro de `client`.
- El cliente obtiene un JWT y consume los dos servicios.

## Prerequisitos
- Java 17 y Maven instalados.
- `JAVA_HOME` configurado.

---
[Volver al índice del HUB](../README.md)