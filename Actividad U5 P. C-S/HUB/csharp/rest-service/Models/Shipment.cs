namespace CSharpRestService.Models;

public enum ShipmentStatus
{
    PENDING,
    IN_TRANSIT,
    CUSTOMS_HOLD,
    DELIVERED
}

public class Shipment
{
    public string TrackingNumber { get; set; } = string.Empty;
    public string Origin { get; set; } = string.Empty;
    public string Destination { get; set; } = string.Empty;
    public decimal WeightKg { get; set; }
    public decimal DeclaredValue { get; set; }
    public ShipmentStatus Status { get; set; } = ShipmentStatus.PENDING;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}