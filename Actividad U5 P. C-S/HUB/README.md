# OmniLogistics Hub - Núcleo de Servicios Web

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