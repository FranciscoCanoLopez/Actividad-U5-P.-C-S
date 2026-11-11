# Java SOAP Service (JAX-WS) - Hub

Este directorio contiene la implementación del microservicio SOAP para el Hub, desarrollado nativamente en **Java 17** utilizando la especificación estándar **JAX-WS (Jakarta XML Web Services)** y la implementación de referencia **Metro**.

## Características

* **Framework:** JAX-WS (Servidor HTTP nativo de la JVM).
* **Puerto asignado:** `8082` (Localhost).
* **Protocolo:** SOAP 1.1 / XML.
* **Gestor de dependencias:** Maven.

## Endpoints

* **Base URL:** `http://localhost:8082/ShipmentService`
* **Archivo Descriptor WSDL:** `http://localhost:8082/ShipmentService?wsdl`

## Operaciones Expuestas

1. **`getShipmentStatus(trackingNumber: string)`**: Recibe el número de guía y retorna un objeto complejo `ShipmentResponse` validando la existencia del registro en la base de datos en memoria.

## Instrucciones de Ejecución

Para iniciar este servidor, abre una terminal en este directorio y ejecuta:

```bash
mvn clean compile exec:java