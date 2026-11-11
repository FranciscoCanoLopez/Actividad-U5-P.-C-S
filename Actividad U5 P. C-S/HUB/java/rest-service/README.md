# Java REST Service (Spring Boot) - Hub

Este directorio contiene la implementación del microservicio RESTful para el Hub, desarrollado en **Java 17** utilizando **Spring Boot 3**.

## Características

* **Framework:** Spring Boot 3.2.x (Servidor web Tomcat integrado).
* **Puerto asignado:** `8081` (Localhost).
* **Seguridad:** Autenticación mediante JSON Web Tokens (JWT) utilizando la librería `jjwt`.
* **Gestor de dependencias:** Maven.

## Endpoints

* **POST `/api/v1/auth/login`**: Recibe credenciales JSON (`username`, `password`) y retorna un token JWT firmado mediante HS256.
* **GET `/api/v1/shipments`**: Endpoint protegido (requiere cabecera `Authorization: Bearer <token>`). Retorna el catálogo de envíos activos en formato JSON.

## Instrucciones de Ejecución

Para iniciar este servidor, abre una terminal en este directorio y ejecuta:

```bash
mvn clean spring-boot:run