using System.Collections.Concurrent;
using CSharpRestService.Models;

namespace CSharpRestService.Services;

public class ShipmentService : IShipmentService
{
    private readonly ConcurrentDictionary<string, Shipment> _shipments = new();
    private readonly ConcurrentBag<TrackingEvent> _events = new();

    public ShipmentService()
    {
        // Registro de prueba inicial
        var seedShipment = new Shipment
        {
            TrackingNumber = "TRK-987654321-MX",
            Origin = "Monclova, MX",
            Destination = "Austin, US",
            WeightKg = 12.5m,
            DeclaredValue = 450.00m,
            Status = ShipmentStatus.IN_TRANSIT,
            CreatedAt = DateTime.UtcNow
        };
        _shipments.TryAdd(seedShipment.TrackingNumber, seedShipment);

        _events.Add(new TrackingEvent
        {
            TrackingNumber = seedShipment.TrackingNumber,
            Location = "Monclova Hub",
            StatusUpdate = "IN_TRANSIT",
            Comments = "Envío recibido e inspeccionado en almacén de origen."
        });
    }

    public IEnumerable<Shipment> GetAll() => _shipments.Values;

    public Shipment? GetByTrackingNumber(string trackingNumber)
    {
        _shipments.TryGetValue(trackingNumber, out var shipment);
        return shipment;
    }

    public Shipment Create(Shipment shipment)
    {
        if (string.IsNullOrWhiteSpace(shipment.TrackingNumber))
        {
            shipment.TrackingNumber = $"TRK-{Random.Shared.Next(100000000, 999999999)}-MX";
        }
        shipment.CreatedAt = DateTime.UtcNow;
        _shipments[shipment.TrackingNumber] = shipment;
        return shipment;
    }

    public bool Update(string trackingNumber, Shipment updatedShipment)
    {
        if (!_shipments.ContainsKey(trackingNumber)) return false;
        updatedShipment.TrackingNumber = trackingNumber;
        _shipments[trackingNumber] = updatedShipment;
        return true;
    }

    public bool Delete(string trackingNumber)
    {
        return _shipments.TryRemove(trackingNumber, out _);
    }

    public TrackingEvent AddEvent(string trackingNumber, TrackingEvent trackingEvent)
    {
        trackingEvent.EventId = Guid.NewGuid().ToString();
        trackingEvent.TrackingNumber = trackingNumber;
        trackingEvent.Timestamp = DateTime.UtcNow;
        _events.Add(trackingEvent);
        return trackingEvent;
    }

    public IEnumerable<TrackingEvent> GetEvents(string trackingNumber)
    {
        return _events.Where(e => e.TrackingNumber.Equals(trackingNumber, StringComparison.OrdinalIgnoreCase));
    }
}