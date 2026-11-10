# Python SOAP Service (Spyne) - Hub

Este directorio contiene la implementación del microservicio SOAP para el Hub, desarrollado nativamente en Python utilizando el framework **Spyne**.

## Características

* **Framework:** Spyne
* **Servidor WSGI:** Werkzeug
* **Puerto asignado:** `8005` (Localhost).
* **Protocolo:** SOAP 1.1 / XML
* **Espacio de nombres (TNS):** `http://hub.local/services`

## Endpoints

* **Base URL:** `http://127.0.0.1:8005/`
* **Archivo Descriptor WSDL:** `http://127.0.0.1:8005/?wsdl`

## Operaciones Expuestas

1. **`GetShipmentStatus(trackingNumber: string)`**: Recibe el número de guía como un `Unicode` primitivo y retorna un objeto complejo `ShipmentResponse`. Si la guía no existe, levanta una excepción de tipo `Fault` nativa de SOAP.

## Instrucciones de Ejecución

Para iniciar este servidor abre una terminal independiente, instala las dependencias y ejecuta el script principal:

```bash
pip install --no-cache-dir -r requirements.txt
python main.py