Imports System.ServiceModel
Imports System.Runtime.Serialization
Imports Microsoft.AspNetCore.Builder
Imports Microsoft.AspNetCore.Hosting
Imports Microsoft.Extensions.DependencyInjection
Imports SoapCore

Namespace SoapService
    ' 1. Contratos
    <ServiceContract>
    Public Interface IShipmentService
        <OperationContract>
        Function getShipmentStatus(trackingNumber As String) As ShipmentResponse
    End Interface

    <DataContract>
    Public Class ShipmentResponse
        <DataMember> Public Property trackingNumber As String
        <DataMember> Public Property status As String
        <DataMember> Public Property updatedAt As String
    End Class

    ' 2. Implementación
    Public Class ShipmentServiceImpl
        Implements IShipmentService

        Public Function getShipmentStatus(trackingNumber As String) As ShipmentResponse Implements IShipmentService.getShipmentStatus
            Console.WriteLine($" [LOG] Peticion SOAP recibida para la guia: {trackingNumber}")
            
            If trackingNumber = "TRK-987654321-MX" Then
                Return New ShipmentResponse With {
                    .trackingNumber = trackingNumber,
                    .status = "IN_TRANSIT",
                    .updatedAt = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")
                }
            End If
            Throw New FaultException("La guia no fue encontrada en el Hub.")
        End Function
    End Class

    ' 3. Servidor
    Module Program
        Sub Main(args As String())
            Dim builder = WebApplication.CreateBuilder(args)
            builder.WebHost.UseUrls("http://localhost:5004")
            
            builder.Services.AddSoapCore()
            builder.Services.AddSingleton(Of IShipmentService, ShipmentServiceImpl)()

            Dim app = builder.Build()
            app.UseRouting()
            app.UseEndpoints(Sub(endpoints)
                                 endpoints.UseSoapEndpoint(Of IShipmentService)("/ShipmentService", New SoapEncoderOptions(), SoapSerializer.DataContractSerializer)
                             End Sub)

            Console.WriteLine("=========================================")
            Console.WriteLine(" HUB - VB.NET SOAP Service (SoapCore)")
            Console.WriteLine(" WSDL: http://localhost:5004/ShipmentService?wsdl")
            Console.WriteLine("=========================================")
            app.Run()
        End Sub
    End Module
End Namespace