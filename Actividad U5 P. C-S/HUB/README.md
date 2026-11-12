# OmniLogistics Hub - Núcleo de Servicios Web

Este directorio contiene la implementación multi‑lenguaje de la plataforma de logística global **OmniLogistics**. Cada lenguaje ofrece un **servicio RESTful**, un **servicio SOAP** y una **aplicación cliente** que consume ambos.

## Estructura de Subdirectorios

| Lenguaje | REST (puerto) | SOAP (puerto) | Cliente | Docs (Swagger / WSDL) |
|----------|---------------|---------------|---------|-----------------------|
| `csharp` | 5001 | 5002 | `client` | <http://localhost:5001/swagger>
| `vbnet`  | 5003 | 5004 | `client` | <http://localhost:5003/swagger>
| `java`   | 8081 | 8082 | `client` | <http://localhost:8081/swagger-ui.html>
| `python` | 8000 | 8005 | `client` | <http://localhost:8000/docs>
| `php`    | 8083 | 8084 | `client` | <http://localhost:8083/swagger>
| `ruby`   | 8085 | 8086 | `client` | <http://localhost:8085/swagger>

Cada sub‑directorio contiene un `README.md` con instrucciones detalladas de uso (inicio, pruebas y generación de documentación).

---

[Ver la guía completa de cada módulo](csharp/README.md)

Este directorio contiene la implementación multi-lenguaje de la plataforma de logística global OmniLogistics. Contiene 12 servidores web (6 RESTful y 6 SOAP) y sus respectivas aplicaciones cliente.

## Estructura de Subdirectorios

* **`/csharp`**: Implementación .NET 8 (C# 12). RESTful (Web API), SOAP (CoreWCF) y Cliente Consola.
* **`/vbnet`**: Implementación .NET 8 (VB.NET 16). RESTful (Web API), SOAP (CoreWCF) y Cliente Consola.
* **`/java`**: Implementación Java 17. RESTful (Spring Boot 3), SOAP (Jakarta JAX-WS Standalone) y Cliente Consola.
* **`/python`**: Implementación Python 3.11. RESTful (FastAPI/Uvicorn), SOAP (Spyne/WSGI) y Cliente CLI (Requests/Zeep).
* **`/php`**: Implementación PHP 8.2. RESTful (Slim Framework 4), SOAP (Native/Laminas) y Cliente CLI.
* **`/ruby`**: Implementación Ruby 3.2. RESTful (Sinatra), SOAP (WashOut/Rack) y Cliente CLI.
* **`/docs`**: Almacenamiento de contratos OpenAPI (`.yaml`/`.json`) y WSDL (`.wsdl`).
* **`/tests`**: Colecciones exportadas de Postman v10+ y proyectos de SoapUI 5.7+.