using System.Runtime.Serialization;

namespace CSharpSoapService.Models;

[DataContract(Namespace = "http://hub.local/types")]
public class ShipmentResponse
{
    [DataMember(Order = 1)]
    public string TrackingNumber { get; set; } = string.Empty;
    
    [DataMember(Order = 2)]
    public string Status { get; set; } = string.Empty;
    
    [DataMember(Order = 3)]
    public DateTime UpdatedAt { get; set; }
}