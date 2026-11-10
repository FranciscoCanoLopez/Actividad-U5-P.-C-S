package com.hub.soap;

import jakarta.jws.WebService;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

@WebService(endpointInterface = "com.hub.soap.ShipmentService", targetNamespace = "http://hub.local/services")
public class ShipmentServiceImpl implements ShipmentService {
    
    private final Map<String, String> database = new HashMap<>();

    public ShipmentServiceImpl() {
        database.put("TRK-987654321-MX", "IN_TRANSIT");
    }

    @Override
    public ShipmentResponse getShipmentStatus(String trackingNumber) {
        System.out.println(" [LOG] Peticion SOAP recibida para la guia: " + trackingNumber);
        
        if (!database.containsKey(trackingNumber)) {
            throw new RuntimeException("Client.NotFound: La guia '" + trackingNumber + "' no fue encontrada en el Hub.");
        }

        ShipmentResponse response = new ShipmentResponse();
        response.trackingNumber = trackingNumber;
        response.status = database.get(trackingNumber);
        response.updatedAt = Instant.now().toString();
        
        return response;
    }
}