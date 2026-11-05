# Servidor RESTful (Slim Framework 4)
cd php/rest-service
composer require slim/slim "^4.0"
composer require slim/psr7
composer require firebase/php-jwt
composer require zircote/swagger-php

# Servidor SOAP (Laminas SOAP / Ext-SOAP Native)
cd ../soap-service
composer require laminas/laminas-soap

# Cliente
cd ../client
composer require guzzlehttp/guzzle