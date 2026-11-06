using CoreWCF;
using CoreWCF.Configuration;
using CoreWCF.Description;
using CSharpSoapService.Services;

var builder = WebApplication.CreateBuilder(args);

// Configurar puerto HTTP fijo en 5002 (Evita colisión con el servicio RESTful)
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenLocalhost(5002);
});

// Registrar servicios de infraestructura CoreWCF
builder.Services.AddServiceModelServices();
builder.Services.AddServiceModelMetadata();
builder.Services.AddSingleton<IServiceBehavior, UseRequestHeadersForMetadataAddressBehavior>();

// Registrar la implementación de nuestro servicio en memoria
builder.Services.AddSingleton<ShipmentSoapService>();

var app = builder.Build();

// Configurar los Endpoints SOAP y el protocolo de enlace (BasicHttpBinding)
app.UseServiceModel(serviceBuilder =>
{
    serviceBuilder.AddService<ShipmentSoapService>((serviceOptions) => { })
                  .AddServiceEndpoint<ShipmentSoapService, IShipmentSoapService>(
                      new BasicHttpBinding(), 
                      "/ShipmentService.svc");
});

// Habilitar la exposición del contrato WSDL en el endpoint de Metadata
var serviceMetadataBehavior = app.Services.GetRequiredService<ServiceMetadataBehavior>();
serviceMetadataBehavior.HttpGetEnabled = true;
serviceMetadataBehavior.HttpGetUrl = new Uri("http://localhost:5002/ShipmentService.svc/metadata");

app.Run();