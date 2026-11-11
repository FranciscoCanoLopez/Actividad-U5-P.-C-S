# PHP REST Service (Slim Framework) - Hub

Este directorio contiene la implementación del microservicio RESTful para el Hub, desarrollado en **PHP 8** utilizando el micro-framework **Slim 4**.

## Características

* **Framework:** Slim Framework 4 (Arquitectura PSR-7).
* **Puerto asignado:** `8083` (Localhost).
* **Seguridad:** Autenticación mediante JSON Web Tokens (JWT) utilizando la librería `firebase/php-jwt`.
* **Gestor de dependencias:** Composer.

## Endpoints

* **POST `/api/v1/auth/login`**: Recibe credenciales JSON (`username`, `password`) en el cuerpo de la petición y retorna un token JWT firmado (HS256).
* **GET `/api/v1/shipments`**: Endpoint protegido (requiere cabecera `Authorization: Bearer <token>`). Retorna el catálogo de envíos activos en formato JSON.

## Instrucciones de Ejecución

Asegúrate de tener PHP 8.x y Composer instalados en tu entorno. Para iniciar este servidor, abre una terminal en este directorio y ejecuta los siguientes comandos:

1. **Instalar dependencias:**
```bash
composer install
composer update
php -S localhost:8083 -t public