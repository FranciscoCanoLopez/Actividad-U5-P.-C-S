# Specs & Entorno de Despliegue Local

Carpeta orientada a la infraestructura de scripts local, control de puertos y automatización de paquetes.

## Archivos Contenidos

* **`install_all.bat`**: Orquestador principal de instalación. Ejecuta en orden todos los scripts ubicados en `Packages and dependencies/`.
* **`ports.md`**: Matriz de mapeo de puertos local para evitar colisiones de red entre los 12 servidores simultáneos.
* **`/Packages and dependencies`**:
  * `Csharp.bat`: Ejecuta restore de paquetes NuGet para REST, SOAP y Cliente C#.
  * `VBNET.bat`: Ejecuta restore de paquetes NuGet para el entorno VB.NET.
  * `Java.bat`: Ejecuta el plugin `mvn dependency:resolve` para los proyectos REST y SOAP.
  * `Python.bat`: Crea los entornos virtuales (`venv`) e instala paquetes `pip`.
  * `PHP.bat`: Instala dependencias con `composer install`.
  * `Ruby.bat`: Ejecuta `bundle install` en cada subcarpeta de Ruby.