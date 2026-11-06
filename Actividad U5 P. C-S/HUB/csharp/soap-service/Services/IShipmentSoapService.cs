using CoreWCF;
using CSharpSoapService.Models;

namespace CSharpSoapService.Services;

[ServiceContract(Namespace = "http://hub.local/services")]
public interface IShipmentSoapService
{
    [OperationContract]
    ShipmentResponse GetShipmentStatus(string trackingNumber);

    [OperationContract]
    ShipmentResponse RegisterShipment(ShipmentRequest request);
}