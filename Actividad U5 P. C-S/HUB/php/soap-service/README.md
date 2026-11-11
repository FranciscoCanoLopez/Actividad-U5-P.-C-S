# PHP SOAP Service (ext-soap) - Hub

Este directorio contiene la implementación del microservicio SOAP para el Hub, desarrollado en **PHP 8** utilizando la extensión nativa `SoapServer`.

## Características

* **Framework:** PHP Nativo (`ext-soap`).
* **Puerto asignado:** `8084` (Localhost).
* **Protocolo:** SOAP 1.1 / XML.
* **Contrato:** WSDL estático (`service.wsdl`).

## Endpoints

* **Archivo Descriptor WSDL:** `http://localhost:8084/service.wsdl`
* **Punto de Enlace (Endpoint):** `http://localhost:8084/server.php`

## Operaciones Expuestas

1. **`getShipmentStatus(trackingNumber: string)`**: Recibe un número de guía y retorna una estructura XML validando la existencia del registro en la base de datos en memoria. La extensión de PHP se encarga automáticamente de la serialización del arreglo asociativo a una respuesta SOAP válida.

## Instrucciones de Ejecución

Asegúrate de que la extensión SOAP esté habilitada en tu archivo `php.ini` (`extension=soap`). Para iniciar el servidor, abre una terminal en este directorio y ejecuta el servidor web interno de PHP:

```bash
php -S localhost:8084