# Ruby Client - Hub

Este directorio contiene la aplicación de consola desarrollada en **Ruby** que actúa como cliente unificado para consumir la arquitectura dual del Hub.

## Interacciones del Cliente

1. **Consumo REST (Puerto 8085):** 
   Utiliza la librería estándar `Net::HTTP` para negociar un token de seguridad JWT contra el endpoint de autenticación y posteriormente consultar el catálogo de envíos a través de una petición HTTP GET autenticada. La respuesta JSON se procesa nativamente con la clase `JSON`.
2. **Consumo SOAP (Puerto 8086):** 
   Construye un sobre SOAP (Envelope) en formato de cadena de texto cruda y lo envía mediante una petición HTTP POST usando `Net::HTTP`. La respuesta XML es analizada y parseada utilizando la gema **Nokogiri**, permitiendo extraer los nodos de información y manejar los errores (SOAP Faults) mediante XPath de forma segura y eficiente.

## Requisitos y Ejecución

Es estrictamente necesario que los microservicios REST (8085) y SOAP (8086) de Ruby se encuentren en ejecución simultánea antes de lanzar este script.

Para ejecutar el cliente, asegúrate de haber instalado las dependencias (`bundle install`), abre una terminal en este directorio y utiliza:

```bash
ruby client.rb