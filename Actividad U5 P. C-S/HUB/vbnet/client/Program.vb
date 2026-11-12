Imports System.Net.Http
Imports System.Text
Imports System.Text.Json
Imports System.Xml.Linq

Namespace Client
    Module Program
        Sub Main()
            Console.WriteLine(vbCrLf & "===================================================")
            Console.WriteLine("      HUB - CLIENTE VB.NET (REST + SOAP)")
            Console.WriteLine("===================================================" & vbCrLf)

            Dim httpClient As New HttpClient()
            Dim trackingNumber As String = ""

            Try
                ' --- 1. REST ---
                Console.WriteLine("---------------------------------------------------")
                Console.WriteLine(" 1. CONSUMIENDO API REST (Puerto 5003)")
                Console.WriteLine("---------------------------------------------------")
                Console.WriteLine(" -> Autenticando (JWT)...")

                Dim authPayload = "{ ""username"": ""omni_admin"", ""password"": ""SecuredPass2026!"" }"
                Dim authContent = New StringContent(authPayload, Encoding.UTF8, "application/json")
                Dim authResponse = httpClient.PostAsync("http://localhost:5003/api/v1/auth/login", authContent).Result
                
                If Not authResponse.IsSuccessStatusCode Then Throw New Exception("Fallo la autenticacion REST.")
                
                Dim authResult = JsonSerializer.Deserialize(Of Dictionary(Of String, String))(authResponse.Content.ReadAsStringAsync().Result)
                Dim token = authResult("token")
                Console.WriteLine(" [OK] Token JWT obtenido con exito." & vbCrLf)

                Console.WriteLine(" -> Consultando envios activos...")
                httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {token}")
                Dim shipmentsResponse = httpClient.GetAsync("http://localhost:5003/api/v1/shipments").Result
                Dim shipmentsJson = shipmentsResponse.Content.ReadAsStringAsync().Result
                
                Dim shipments = JsonDocument.Parse(shipmentsJson).RootElement
                Console.WriteLine($" [OK] {shipments.GetArrayLength()} envios encontrados.")
                trackingNumber = shipments(0).GetProperty("trackingNumber").GetString()
                Console.WriteLine($" [INFO] Guia seleccionada para test SOAP: {trackingNumber}" & vbCrLf)

                ' --- 2. SOAP ---
                Console.WriteLine("---------------------------------------------------")
                Console.WriteLine(" 2. CONSUMIENDO SERVICIO SOAP (Puerto 5004)")
                Console.WriteLine("---------------------------------------------------")
                Console.WriteLine($" -> Consultando estatus para guia: {trackingNumber}")

                Dim soapXml = $"<soapenv:Envelope xmlns:soapenv=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:tem=""http://tempuri.org/""><soapenv:Header/><soapenv:Body><tem:getShipmentStatus><tem:trackingNumber>{trackingNumber}</tem:trackingNumber></tem:getShipmentStatus></soapenv:Body></soapenv:Envelope>"
                Dim soapContent = New StringContent(soapXml, Encoding.UTF8, "text/xml")
                
                Dim soapResponse = httpClient.PostAsync("http://localhost:5004/ShipmentService", soapContent).Result
                Dim responseXml = soapResponse.Content.ReadAsStringAsync().Result
                Dim doc = XDocument.Parse(responseXml)
                
                Dim ns As XNamespace = "http://schemas.datacontract.org/2004/07/SoapService"
                Dim status = doc.Descendants(ns + "status").FirstOrDefault()?.Value
                Dim updatedAt = doc.Descendants(ns + "updatedAt").FirstOrDefault()?.Value

                Console.WriteLine(" [OK] Respuesta SOAP recibida.")
                Console.WriteLine($"      - Guia:    {trackingNumber}")
                Console.WriteLine($"      - Estatus: {status}")
                Console.WriteLine($"      - Fecha:   {updatedAt}" & vbCrLf)

            Catch ex As Exception
                Console.WriteLine($" [ERROR] {ex.Message}")
            End Try
        End Sub
    End Module
End Namespace