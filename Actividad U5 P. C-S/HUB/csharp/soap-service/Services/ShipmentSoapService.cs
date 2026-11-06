using System.Collections.Concurrent;
using CoreWCF;
using CSharpSoapService.Models;

namespace CSharpSoapService.Services;

[ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
public class ShipmentSoapService : IShipmentSoapService
{
    private readonly ConcurrentDictionary<string, ShipmentResponse> _database = new();

    public ShipmentSoapService()
    {
        // Semilla de prueba inicial para el Hub
        _database.TryAdd("TRK-987654321-MX", new ShipmentResponse
        {
            TrackingNumber = "TRK-987654321-MX",
            Status = "IN_TRANSIT",
            UpdatedAt = DateTime.UtcNow
        });
    }

    public ShipmentResponse GetShipmentStatus(string trackingNumber)
    {
        if (_database.TryGetValue(trackingNumber, out var response))
        {
            return response;
        }

        // Retorna un Fault (Error SOAP) estructurado si no existe
        throw new FaultException($"La guía '{trackingNumber}' no fue encontrada en el Hub.");
    }

    public ShipmentResponse RegisterShipment(ShipmentRequest request)
    {
        var trackingNumber = string.IsNullOrWhiteSpace(request.TrackingNumber) 
            ? $"TRK-{Random.Shared.Next(100000000, 999999999)}-MX" 
            : request.TrackingNumber;

        var response = new ShipmentResponse
        {
            TrackingNumber = trackingNumber,
            Status = "PENDING",
            UpdatedAt = DateTime.UtcNow
        };

        _database[trackingNumber] = response;
        return response;
    }
}