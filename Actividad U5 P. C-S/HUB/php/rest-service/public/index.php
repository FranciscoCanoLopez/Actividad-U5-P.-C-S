<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();
$app->addRoutingMiddleware();
$app->addErrorMiddleware(true, true, true);

$jwtSecret = "SecuredPass2026_Hub_PHP_JWT_Key!";

// Simulacion de base de datos
$database = [
    "TRK-987654321-MX" => [
        "trackingNumber" => "TRK-987654321-MX",
        "origin" => "Monterrey",
        "destination" => "CDMX",
        "weightKg" => 15.5,
        "status" => "IN_TRANSIT",
        "updatedAt" => gmdate("Y-m-d\TH:i:s\Z")
    ]
];

// Endpoint de Autenticación
$app->post('/api/v1/auth/login', function (Request $request, Response $response) use ($jwtSecret) {
    $data = json_decode($request->getBody()->getContents(), true);
    
    if (isset($data['username']) && $data['username'] === 'omni_admin' && 
        isset($data['password']) && $data['password'] === 'SecuredPass2026!') {
        
        $payload = [
            'iss' => 'http://localhost:8083',
            'sub' => $data['username'],
            'iat' => time(),
            'exp' => time() + 3600
        ];
        
        $token = JWT::encode($payload, $jwtSecret, 'HS256');
        $response->getBody()->write(json_encode(['token' => $token]));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
    }
    
    $response->getBody()->write(json_encode(['error' => 'Credenciales invalidas']));
    return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
});

// Middleware de Autenticación JWT para proteger las rutas
$authMiddleware = function ($request, $handler) use ($jwtSecret) {
    $header = $request->getHeaderLine('Authorization');
    if (!$header || !preg_match('/Bearer\s(\S+)/', $header, $matches)) {
        $response = new \Slim\Psr7\Response();
        $response->getBody()->write(json_encode(['error' => 'Token no proporcionado']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
    }

    $token = $matches[1];
    try {
        JWT::decode($token, new Key($jwtSecret, 'HS256'));
        return $handler->handle($request);
    } catch (Exception $e) {
        $response = new \Slim\Psr7\Response();
        $response->getBody()->write(json_encode(['error' => 'Token invalido o expirado']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
    }
};

// Endpoint protegido para obtener envíos
$app->get('/api/v1/shipments', function (Request $request, Response $response) use ($database) {
    $response->getBody()->write(json_encode(array_values($database)));
    return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
})->add($authMiddleware);

$app->run();