using System.Runtime.Serialization;

namespace CSharpSoapService.Models;

[DataContract(Namespace = "http://hub.local/types")]
public class ShipmentRequest
{
    [DataMember(Order = 1)]
    public string TrackingNumber { get; set; } = string.Empty;
    
    [DataMember(Order = 2)]
    public string Origin { get; set; } = string.Empty;
    
    [DataMember(Order = 3)]
    public string Destination { get; set; } = string.Empty;
    
    [DataMember(Order = 4)]
    public decimal WeightKg { get; set; }
    
    [DataMember(Order = 5)]
    public decimal DeclaredValue { get; set; }
}