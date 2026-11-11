<?php

echo "\n===================================================\n";
echo "      HUB - CLIENTE PHP (REST + SOAP)\n";
echo "===================================================\n\n";

try {
    // ---------------------------------------------------------
    // 1. CONSUMIR SERVICIO REST (Puerto 8083)
    // ---------------------------------------------------------
    printHeader("1. CONSUMIENDO API REST (Puerto 8083)");
    
    echo " -> Autenticando (JWT)...\n";
    $authPayload = json_encode([
        'username' => 'omni_admin',
        'password' => 'SecuredPass2026!'
    ]);

    $ch = curl_init('http://localhost:8083/api/v1/auth/login');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $authPayload);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    
    $authResponse = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode !== 200) {
        throw new Exception("Fallo la autenticacion REST: HTTP $httpCode");
    }

    $tokenData = json_decode($authResponse, true);
    $token = $tokenData['token'];
    echo " [OK] Token JWT obtenido con exito.\n\n";

    echo " -> Consultando envios activos...\n";
    $ch = curl_init('http://localhost:8083/api/v1/shipments');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Authorization: Bearer ' . $token,
        'Content-Type: application/json'
    ]);

    $shipmentsResponse = curl_exec($ch);
    curl_close($ch);

    $shipments = json_decode($shipmentsResponse, true);
    echo " [OK] " . count($shipments) . " envios encontrados.\n";
    
    if (empty($shipments)) {
        exit("No hay envios para consultar.\n");
    }

    $guiaABuscar = $shipments[0]['trackingNumber'];
    echo " [INFO] Guia seleccionada para test SOAP: $guiaABuscar\n";

    // ---------------------------------------------------------
    // 2. CONSUMIR SERVICIO SOAP (Puerto 8084)
    // ---------------------------------------------------------
    printHeader("2. CONSUMIENDO SERVICIO SOAP (Puerto 8084)");
    echo " -> Consultando estatus para guia: $guiaABuscar\n";

    // Deshabilitar caché del WSDL para asegurar que siempre lea la última versión
    $soapOptions = [
        'cache_wsdl' => WSDL_CACHE_NONE,
        'exceptions' => true
    ];

    $soapClient = new SoapClient('http://localhost:8084/service.wsdl', $soapOptions);
    
    // SoapClient mapea automáticamente el arreglo a los parámetros XML definidos en el WSDL
    $soapResponse = $soapClient->getShipmentStatus([
        'trackingNumber' => $guiaABuscar
    ]);

    echo " [OK] Respuesta SOAP recibida.\n";
    echo "      - Guia:    " . $soapResponse->trackingNumber . "\n";
    echo "      - Estatus: " . $soapResponse->status . "\n";
    echo "      - Fecha:   " . $soapResponse->updatedAt . "\n";

} catch (SoapFault $e) {
    echo " [ERROR SOAP] " . $e->getMessage() . "\n";
} catch (Exception $e) {
    echo " [ERROR] " . $e->getMessage() . "\n";
}

echo "\n";

function printHeader($title) {
    echo "---------------------------------------------------\n";
    echo " $title\n";
    echo "---------------------------------------------------\n";
}
?>