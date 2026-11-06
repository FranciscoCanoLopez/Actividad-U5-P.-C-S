using CSharpRestService.Models;

namespace CSharpRestService.Services;

public interface IShipmentService
{
    IEnumerable<Shipment> GetAll();
    Shipment? GetByTrackingNumber(string trackingNumber);
    Shipment Create(Shipment shipment);
    bool Update(string trackingNumber, Shipment updatedShipment);
    bool Delete(string trackingNumber);
    TrackingEvent AddEvent(string trackingNumber, TrackingEvent trackingEvent);
    IEnumerable<TrackingEvent> GetEvents(string trackingNumber);
}