# Hub - Módulo Ruby (Sinatra)

Este directorio contiene la implementación en Ruby del Hub, integrando una arquitectura dual de microservicios para garantizar la interoperabilidad entre servicios web modernos (REST) y corporativos heredados (SOAP).

## Estructura del Ecosistema

El módulo está compuesto por tres subproyectos independientes, gestionados con Bundler:

1. **`rest-service` (Puerto 8085):**
   * Servidor basado en el micro-framework **Sinatra** corriendo sobre el servidor web **Puma**.
   * Expone endpoints RESTful con serialización JSON.
   * Cuenta con seguridad mediante tokens JWT (HS256) gestionada por la gema `jwt`.

2. **`soap-service` (Puerto 8086):**
   * Servidor basado en **Sinatra** y **Puma**.
   * Expone contratos de datos XML tipados a través de un archivo WSDL estático (`service.wsdl`).
   * Procesa peticiones y construye respuestas SOAP utilizando la gema **Nokogiri** para la manipulación y análisis de XML.

3. **`client` (Cliente de Consola Híbrido):**
   * Script unificado de pruebas utilizando `Net::HTTP` y `Nokogiri`.
   * Demuestra la capacidad del ecosistema Ruby para actuar tanto como proveedor de servicios (API/SOAP) como consumidor cliente.

## Gestión y Ejecución

Para facilitar el levantamiento de los servicios, se incluye el script automatizado `run_services.bat` en la raíz de este directorio, permitiendo arrancar los servidores y el cliente de forma individual o integral en ventanas de comandos separadas.