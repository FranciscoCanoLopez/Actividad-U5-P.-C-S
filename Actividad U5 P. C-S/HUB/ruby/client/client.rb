require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'

puts "\n==================================================="
puts "      HUB - CLIENTE RUBY (REST + SOAP)"
puts "===================================================\n\n"

begin
  # ---------------------------------------------------------
  # 1. CONSUMIR SERVICIO REST (Puerto 8085)
  # ---------------------------------------------------------
  puts "---------------------------------------------------"
  puts " 1. CONSUMIENDO API REST (Puerto 8085)"
  puts "---------------------------------------------------"
  
  puts " -> Autenticando (JWT)..."
  uri_auth = URI('http://localhost:8085/api/v1/auth/login')
  req_auth = Net::HTTP::Post.new(uri_auth, 'Content-Type' => 'application/json')
  req_auth.body = { username: 'omni_admin', password: 'SecuredPass2026!' }.to_json
  
  res_auth = Net::HTTP.start(uri_auth.hostname, uri_auth.port) { |http| http.request(req_auth) }
  raise "Fallo la autenticación REST: HTTP #{res_auth.code}" unless res_auth.code == '200'
  
  token = JSON.parse(res_auth.body)['token']
  puts " [OK] Token JWT obtenido con exito.\n\n"

  puts " -> Consultando envios activos..."
  uri_shipments = URI('http://localhost:8085/api/v1/shipments')
  req_shipments = Net::HTTP::Get.new(uri_shipments)
  req_shipments['Authorization'] = "Bearer #{token}"
  req_shipments['Content-Type'] = 'application/json'
  
  res_shipments = Net::HTTP.start(uri_shipments.hostname, uri_shipments.port) { |http| http.request(req_shipments) }
  shipments = JSON.parse(res_shipments.body)
  
  puts " [OK] #{shipments.size} envios encontrados."
  tracking_number = shipments[0]['trackingNumber']
  puts " [INFO] Guia seleccionada para test SOAP: #{tracking_number}\n\n"

  # ---------------------------------------------------------
  # 2. CONSUMIR SERVICIO SOAP (Puerto 8086)
  # ---------------------------------------------------------
  puts "---------------------------------------------------"
  puts " 2. CONSUMIENDO SERVICIO SOAP (Puerto 8086)"
  puts "---------------------------------------------------"
  puts " -> Consultando estatus para guia: #{tracking_number}"
  
  uri_soap = URI('http://localhost:8086/ShipmentService')
  req_soap = Net::HTTP::Post.new(uri_soap, 'Content-Type' => 'text/xml')
  
  # Construimos el sobre SOAP crudo (Envelope)
  req_soap.body = <<~XML
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://hub.local/services">
       <soapenv:Header/>
       <soapenv:Body>
          <ser:getShipmentStatus>
             <trackingNumber>#{tracking_number}</trackingNumber>
          </ser:getShipmentStatus>
       </soapenv:Body>
    </soapenv:Envelope>
  XML
  
  res_soap = Net::HTTP.start(uri_soap.hostname, uri_soap.port) { |http| http.request(req_soap) }
  doc = Nokogiri::XML(res_soap.body)
  
  # Manejo de excepciones SOAP (Faults)
  if res_soap.code == '500' && doc.at_xpath('//*[local-name()="faultcode"]')
    raise "SOAP Fault: #{doc.at_xpath('//*[local-name()="faultstring"]').text}"
  end
  
  status_val = doc.at_xpath('//*[local-name()="status"]').text
  updated_at = doc.at_xpath('//*[local-name()="updatedAt"]').text
  
  puts " [OK] Respuesta SOAP recibida."
  puts "      - Guia:    #{tracking_number}"
  puts "      - Estatus: #{status_val}"
  puts "      - Fecha:   #{updated_at}\n\n"

rescue StandardError => e
  puts " [ERROR] #{e.message}\n\n"
end