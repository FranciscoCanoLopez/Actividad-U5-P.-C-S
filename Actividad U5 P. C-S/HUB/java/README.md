# Hub - Módulo Java (Spring Boot + JAX-WS)

Este directorio contiene la implementación en Java del Hub, integrando una arquitectura dual de microservicios para garantizar la interoperabilidad entre servicios web modernos (REST) y corporativos heredados (SOAP).

## Estructura del Ecosistema

El módulo está compuesto por tres subproyectos independientes gestionados con Maven y compilados en Java 17:

1. **`rest-service` (Puerto 8081):**
   * Servidor basado en **Spring Boot 3**.
   * Expone endpoints RESTful con serialización JSON.
   * Cuenta con seguridad mediante tokens JWT (HS256) gestionada por `jjwt`.

2. **`soap-service` (Puerto 8082):**
   * Servidor nativo de la JVM utilizando la especificación **JAX-WS (Metro)**.
   * Expone contratos de datos XML tipados y el descriptor WSDL en la ruta `/ShipmentService?wsdl`.

3. **`client` (Cliente de Consola Híbrido):**
   * Script unificado de pruebas.
   * Utiliza el `HttpClient` nativo (introducido en Java 11) para consumir la autenticación y endpoints REST, parseando la respuesta con la librería **Gson**.
   * Construye un sobre XML crudo (SOAP Envelope) para consumir eficientemente el servicio SOAP sin necesidad de proxies autogenerados.

## Gestión y Ejecución

Para facilitar el levantamiento de los servicios, se incluye el script automatizado `run_services.bat` en la raíz de este directorio, permitiendo arrancar los servidores y el cliente de forma individual o integral en ventanas de comandos separadas empleando los comandos nativos de Maven (`mvn`).