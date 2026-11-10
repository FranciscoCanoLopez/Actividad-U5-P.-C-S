# Hub - Python Client

Este directorio contiene la aplicación de consola desarrollada en Python que actúa como cliente unificado para consumir la arquitectura dual del Hub.

## Interacciones del Cliente

1. **Consumo REST (Puerto 8000):** 
   Utiliza la librería estándar `requests` para negociar un token de seguridad JWT contra el endpoint de autenticación y posteriormente realiza una petición HTTP GET para obtener el catálogo de envíos activos en formato JSON.
2. **Consumo SOAP (Puerto 8005):** 
   Emplea la librería `zeep` para parsear dinámicamente el contrato WSDL expuesto por Spyne. Genera el sobre XML (SOAP Envelope) necesario en segundo plano, ejecuta la llamada RPC remota y des-serializa la respuesta XML en un objeto Python nativo.

## Requisitos y Ejecución

Es estrictamente necesario que los microservicios REST y SOAP de Python se encuentren en ejecución simultánea antes de lanzar este script.

Para instalar las dependencias locales y correr el cliente, ejecuta:

```bash
pip install -r requirements.txt
python main.py