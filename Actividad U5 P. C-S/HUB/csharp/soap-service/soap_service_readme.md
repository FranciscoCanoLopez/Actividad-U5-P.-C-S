# C# SOAP Service - Hub

Este módulo contiene la implementación del servidor SOAP para el ecosistema del Hub, desarrollado nativamente en C# utilizando .NET 10 y el framework `CoreWCF`.

Su propósito principal es exponer una interfaz de comunicación fuertemente tipada (XML/WSDL) para garantizar la interoperabilidad y el registro de guías de envío con sistemas heredados y plataformas externas que requieren contratos estrictos.

## 🚀 Tecnologías Utilizadas

* **Framework:** .NET 10.0 (ASP.NET Core Kestrel)
* **Driver SOAP:** `CoreWCF.Http` y `CoreWCF.Primitives`
* **Protocolo de Enlace:** `BasicHttpBinding` (SOAP 1.1)
* **Formato de datos:** XML

## ⚙️ Configuración y Ejecución

El servicio está configurado para ejecutarse de forma independiente en un puerto fijo, evitando colisiones con el servicio RESTful principal.

* **Puerto Asignado:** `5002`
* **URL del Servicio:** `http://localhost:5002/ShipmentService.svc`
* **Contrato WSDL:** `http://localhost:5002/ShipmentService.svc/metadata`

### Comandos de Terminal

Para levantar el servidor SOAP, navega a este directorio en tu terminal y ejecuta:

```bash
# Restaurar dependencias y compilar
dotnet build

# Ejecutar el servidor SOAP
dotnet run
```

## 📦 Contratos y Operaciones (`IShipmentSoapService`)

El servicio expone las siguientes operaciones bajo el namespace `http://hub.local/services`:

1. **`GetShipmentStatus`**:
   * **Descripción**: Consulta el estado actual de una guía de envío.
   * **Entrada**: `trackingNumber` (string).
   * **Salida**: Objeto `ShipmentResponse` (Número de guía, Estado y Fecha de actualización).
   * **Errores**: Devuelve un `FaultException` estándar de SOAP si la guía no existe.

2. **`RegisterShipment`**:
   * **Descripción**: Registra una nueva guía de envío a través del canal SOAP.
   * **Entrada**: Objeto `ShipmentRequest` (TrackingNumber opcional, Origen, Destino, Peso, Valor Declarado).
   * **Salida**: Objeto `ShipmentResponse` con el estado inicial `PENDING`.