namespace CSharpRestService.Models;

public class TrackingEvent
{
    public string EventId { get; set; } = Guid.NewGuid().ToString();
    public string TrackingNumber { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    public string Location { get; set; } = string.Empty;
    public string StatusUpdate { get; set; } = string.Empty;
    public string Comments { get; set; } = string.Empty;
}