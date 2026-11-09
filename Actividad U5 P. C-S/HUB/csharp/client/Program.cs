using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text.Json;
using System.Threading.Tasks;

namespace CSharpClient
{
    // === MODELOS REST ===
    public class LoginRequest
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }

    public class AuthResponse
    {
        public string Token { get; set; } = string.Empty;
        public DateTime Expiration { get; set; }
    }

    public class Shipment
    {
        public string TrackingNumber { get; set; } = string.Empty;
        public string Origin { get; set; } = string.Empty;
        public string Destination { get; set; } = string.Empty;
        public decimal WeightKg { get; set; }
        public decimal DeclaredValue { get; set; }
        public string Status { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; }
    }

    // === CONTRATOS SOAP ===
    [ServiceContract(Namespace = "http://hub.local/services")]
    public interface IShipmentSoapService
    {
        [OperationContract]
        Task<ShipmentResponse> GetShipmentStatusAsync(string trackingNumber);
    }

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

    class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("=========================================");
            Console.WriteLine("  OMNILOGISTICS HUB - CLIENTE C# (.NET 10)");
            Console.WriteLine("=========================================\n");

            string restApiBase = "http://localhost:5001";
            string soapEndpoint = "http://localhost:5002/ShipmentService.svc";
            string trackingNumber = "TRK-987654321-MX";

            using var httpClient = new HttpClient();

            try
            {
                // --- 1. PRUEBA DE CONSUMO REST (JWT Auth) ---
                Console.WriteLine(">>> 1. INICIANDO AUTENTICACIÓN REST (JWT)...");
                
                var loginResponse = await httpClient.PostAsJsonAsync($"{restApiBase}/api/v1/auth/login", new LoginRequest 
                { 
                    Username = "omni_admin", 
                    Password = "SecuredPass2026!" 
                });

                if (loginResponse.IsSuccessStatusCode)
                {
                    var authData = await loginResponse.Content.ReadFromJsonAsync<AuthResponse>();
                    Console.WriteLine($"[OK] Autenticación exitosa. Token obtenido.");

                    // Agregar token al header para la siguiente petición
                    httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", authData?.Token);

                    Console.WriteLine("\n>>> 2. CONSULTANDO SERVICIO REST...");
                    var getResponse = await httpClient.GetAsync($"{restApiBase}/api/v1/shipments");
                    
                    if (getResponse.IsSuccessStatusCode)
                    {
                        var json = await getResponse.Content.ReadAsStringAsync();
                        var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                        var shipments = JsonSerializer.Deserialize<Shipment[]>(json, options);
                        
                        Console.WriteLine($"[OK] Envíos encontrados vía REST: {shipments?.Length ?? 0}");
                        if (shipments?.Length > 0)
                        {
                            Console.WriteLine($"     Ejemplo: {shipments[0].TrackingNumber} -> {shipments[0].Status}");
                        }
                    }
                    else
                    {
                        Console.WriteLine($"[ERROR] Falló la consulta REST: {getResponse.StatusCode}");
                    }
                }
                else
                {
                    Console.WriteLine("[ERROR] Credenciales inválidas para REST.");
                }

                Console.WriteLine("\n-----------------------------------------");

                // --- 2. PRUEBA DE CONSUMO SOAP (WCF) ---
                Console.WriteLine(">>> 3. CONSULTANDO SERVICIO SOAP...");
                
                var binding = new BasicHttpBinding();
                var endpoint = new EndpointAddress(soapEndpoint);
                
                var factory = new ChannelFactory<IShipmentSoapService>(binding, endpoint);
                var client = factory.CreateChannel();

                var response = await client.GetShipmentStatusAsync(trackingNumber);
                
                Console.WriteLine($"[OK] Respuesta SOAP recibida:");
                Console.WriteLine($"     Guía:   {response.TrackingNumber}");
                Console.WriteLine($"     Estado: {response.Status}");
                Console.WriteLine($"     Fecha:  {response.UpdatedAt.ToLocalTime()}");

                ((IClientChannel)client).Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"\n[EXCEPCIÓN CRÍTICA] {ex.Message}");
            }

            Console.WriteLine("\nPresiona cualquier tecla para salir...");
            Console.ReadKey();
        }
    }
}