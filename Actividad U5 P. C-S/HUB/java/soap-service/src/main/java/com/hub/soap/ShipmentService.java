package com.hub.soap;

import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import jakarta.jws.WebService;

@WebService(targetNamespace = "http://hub.local/services")
public interface ShipmentService {
    @WebMethod
    ShipmentResponse getShipmentStatus(@WebParam(name = "trackingNumber") String trackingNumber);
}