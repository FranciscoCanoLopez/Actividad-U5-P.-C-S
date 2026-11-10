package com.hub.soap;

import jakarta.xml.ws.Endpoint;

public class HubSoapApplication {
    public static void main(String[] args) {
        String url = "http://localhost:8082/ShipmentService";
        
        // Publicar el servicio en el servidor nativo de la JVM
        Endpoint.publish(url, new ShipmentServiceImpl());
        
        System.out.println("=========================================");
        System.out.println(" HUB - Java SOAP Service (JAX-WS Metro)");
        System.out.println(" Escuchando en " + url);
        System.out.println(" WSDL: " + url + "?wsdl");
        System.out.println("=========================================\n");
    }
}