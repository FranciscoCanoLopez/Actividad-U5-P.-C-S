# C# RESTful Service

Este módulo contiene la implementación del servidor de APIs RESTful para el sistema OmniLogistics, desarrollado en C# y .NET 10.

## 🚀 Tecnologías Utilizadas
* **Framework:** ASP.NET Core (Web API) .NET 10
* **Lenguaje:** C# 12
* **Documentación:** Swagger / OpenAPI (Swashbuckle v10+)
* **Seguridad:** Autenticación JWT (JSON Web Tokens)
* **Formato de datos:** JSON

## ⚙️ Configuración y Ejecución

El servicio está configurado para ejecutarse localmente y exponer sus endpoints en un puerto fijo para evitar colisiones con los demás microservicios del ecosistema.

* **Puerto Asignado:** `5001`
* **URL Base:** `http://localhost:5001`
* **Interfaz Swagger UI:** `http://localhost:5001/swagger`

### Comandos de Terminal
Para ejecutar el servidor desde la raíz de este directorio (`HUB/csharp/rest-service`), utiliza:

```bash
# Compilar el proyecto
dotnet build

# Ejecutar el servidor
dotnet run
```

## 🔒 Autenticación y Seguridad

Todos los endpoints de gestión logística están protegidos y requieren un token Bearer.
Para obtener un token válido, utiliza el endpoint de autenticación con las credenciales demo:

* **Endpoint:** `POST /api/v1/auth/login`
* **Usuario:** `omni_admin`
* **Contraseña:** `SecuredPass2026!`

El token devuelto tiene una validez de 1 hora y debe incluirse en los encabezados HTTP de las peticiones subsecuentes:
`Authorization: Bearer <tu_token_jwt>`

## 📦 Endpoints Principales (Shipments)

El controlador principal `ShipmentsController` provee la gestión del ciclo de vida de las guías de envío:

* `GET /api/v1/shipments` - Obtiene todas las guías.
* `GET /api/v1/shipments/{trackingNumber}` - Obtiene los detalles de una guía específica.
* `POST /api/v1/shipments` - Crea una nueva guía de envío.
* `PUT /api/v1/shipments/{trackingNumber}` - Actualiza una guía existente.
* `DELETE /api/v1/shipments/{trackingNumber}` - Elimina una guía.
* `POST /api/v1/shipments/{trackingNumber}/events` - Agrega un evento de rastreo.
* `GET /api/v1/shipments/{trackingNumber}/events` - Historial de eventos de rastreo.