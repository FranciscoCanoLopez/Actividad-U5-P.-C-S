# Java Client - Hub

Este directorio contiene la aplicación de consola desarrollada en **Java 17** que actúa como cliente unificado para consumir la arquitectura dual del Hub.

## Interacciones del Cliente

1. **Consumo REST (Puerto 8081):** 
   Utiliza el cliente nativo `java.net.http.HttpClient` para negociar un token de seguridad JWT contra el endpoint de autenticación y consultar el catálogo de envíos HTTP GET. La des-serialización de las respuestas JSON se gestiona con la librería **Google Gson**.
2. **Consumo SOAP (Puerto 8082):** 
   Construye un sobre XML (SOAP Envelope) dinámico y lo envía mediante una petición HTTP POST pura utilizando el mismo `HttpClient`, evitando la necesidad de generar artefactos o proxies pesados (`wsimport`). La extracción de datos se realiza de forma directa sobre la cadena XML.

## Requisitos y Ejecución

Es estrictamente necesario que los microservicios REST (8081) y SOAP (8082) de Java se encuentren en ejecución simultánea antes de lanzar este script.

Para compilar y ejecutar el cliente, abre una terminal en este directorio y utiliza:

```bash
mvn clean compile exec:java