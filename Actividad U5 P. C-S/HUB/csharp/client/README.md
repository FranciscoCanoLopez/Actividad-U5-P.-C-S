# Hub - Módulo C# (.NET 10)

Este directorio contiene la implementación en C# del Hub, dividida en una arquitectura de microservicios dual que garantiza la interoperabilidad a través de protocolos modernos y heredados.

## Estructura del Ecosistema

El módulo está compuesto por tres subproyectos independientes:

1. **`rest-service` (Puerto 5001):**
   * Servidor ASP.NET Core Web API.
   * Expone endpoints RESTful con formato JSON.
   * Protegido mediante autenticación JWT Bearer.
   * Documentación interactiva Swagger/OpenAPI (`/swagger`).

2. **`soap-service` (Puerto 5002):**
   * Servidor WCF estructurado sobre `CoreWCF`.
   * Expone contratos de datos XML y el archivo descriptor WSDL.
   * Implementa `BasicHttpBinding` para máxima compatibilidad con sistemas externos (`/ShipmentService.svc`).

3. **`client` (Aplicación de Consola):**
   * Cliente híbrido de prueba.
   * Consume la API REST utilizando `HttpClient` (incluyendo la negociación del token JWT).
   * Consume el servicio SOAP mediante `ChannelFactory` y `BasicHttpBinding`.

## Gestión y Ejecución

Para facilitar el levantamiento de los entornos, se proporciona el script `run_services.bat` en la raíz de este directorio. Este script permite arrancar los servidores en ventanas separadas (ya sea individualmente o en conjunto) sin necesidad de instanciar las terminales de forma manual.