<?php
// Deshabilitar la caché del WSDL para evitar dolores de cabeza en desarrollo
ini_set("soap.wsdl_cache_enabled", "0");

class ShipmentService {
    private $database = [
        "TRK-987654321-MX" => "IN_TRANSIT"
    ];

    public function getShipmentStatus($request) {
        $trackingNumber = $request->trackingNumber;
        
        // error_log imprime directamente en la terminal del servidor de PHP
        error_log(" [LOG] Peticion SOAP recibida para la guia: " . $trackingNumber);

        if (!isset($this->database[$trackingNumber])) {
            throw new SoapFault("Client.NotFound", "La guia '{$trackingNumber}' no fue encontrada en el Hub.");
        }

        // Retornamos un arreglo asociativo que SoapServer convertirá en XML automáticamente
        return [
            "trackingNumber" => $trackingNumber,
            "status" => $this->database[$trackingNumber],
            "updatedAt" => gmdate("Y-m-d\TH:i:s\Z")
        ];
    }
}

// Inicializar el servidor nativo apuntando a nuestro archivo físico
$server = new SoapServer("service.wsdl");
$server->setClass("ShipmentService");
$server->handle();
?>