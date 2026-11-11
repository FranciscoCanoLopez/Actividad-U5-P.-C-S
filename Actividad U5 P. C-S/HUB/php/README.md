# Hub - Módulo PHP (Slim + ext-soap)

Este directorio contiene la implementación en PHP del Hub, integrando una arquitectura dual de microservicios para garantizar la interoperabilidad entre servicios web modernos (REST) y corporativos heredados (SOAP).

## Estructura del Ecosistema

El módulo está compuesto por tres subproyectos independientes compatibles con PHP 8:

1. **`rest-service` (Puerto 8083):**
   * Servidor basado en el micro-framework **Slim 4**.
   * Expone endpoints RESTful con serialización JSON.
   * Cuenta con seguridad mediante tokens JWT (HS256) gestionada por `firebase/php-jwt`.
   * Dependencias gestionadas vía Composer.

2. **`soap-service` (Puerto 8084):**
   * Servidor nativo utilizando la extensión **`ext-soap`** (`SoapServer`).
   * Expone contratos de datos XML tipados a través de un archivo WSDL estático (`service.wsdl`).
   * No requiere frameworks adicionales.

3. **`client` (Cliente de Consola Híbrido):**
   * Script unificado de pruebas.
   * Utiliza **cURL** para consumir la autenticación y endpoints REST.
   * Utiliza **`SoapClient`** para parsear el WSDL y consumir el servicio SOAP de manera orientada a objetos.

## Gestión y Ejecución

Para facilitar el levantamiento de los servicios, se incluye el script automatizado `run_services.bat` en la raíz de este directorio, permitiendo arrancar los servidores (utilizando el servidor web interno de PHP CLI) y el cliente de forma individual o integral en ventanas de comandos separadas.