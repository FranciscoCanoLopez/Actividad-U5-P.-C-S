require 'sinatra'
require 'nokogiri'
require 'time'

set :port, 8086
set :bind, '0.0.0.0'
set :server, 'puma'

DATABASE = {
  'TRK-987654321-MX' => 'IN_TRANSIT'
}

# Servir el contrato WSDL
get '/ShipmentService' do
  if params.key?('wsdl') || params.key?('WSDL')
    content_type 'text/xml'
    File.read('service.wsdl')
  else
    halt 400, "Se requiere parametro ?wsdl para GET"
  end
end

# Procesar peticiones SOAP
post '/ShipmentService' do
  content_type 'text/xml'
  
  request.body.rewind
  raw_xml = request.body.read
  doc = Nokogiri::XML(raw_xml)
  
  # Extraer el nodo trackingNumber ignorando los namespaces dinámicos de SOAP
  tracking_node = doc.at_xpath('//*[local-name()="trackingNumber"]')
  
  unless tracking_node
    status 500
    return soap_fault("Client.BadRequest", "Falta el nodo trackingNumber en el XML")
  end
  
  tracking_number = tracking_node.text
  puts " [LOG] Peticion SOAP recibida para la guia: #{tracking_number}"
  
  if DATABASE.key?(tracking_number)
    build_soap_response(tracking_number, DATABASE[tracking_number], Time.now.utc.iso8601)
  else
    status 500
    soap_fault("Client.NotFound", "La guia '#{tracking_number}' no fue encontrada en el Hub.")
  end
end

def build_soap_response(tracking, status_str, date)
  <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://hub.local/services">
       <soapenv:Header/>
       <soapenv:Body>
          <ser:getShipmentStatusResponse>
             <trackingNumber>#{tracking}</trackingNumber>
             <status>#{status_str}</status>
             <updatedAt>#{date}</updatedAt>
          </ser:getShipmentStatusResponse>
       </soapenv:Body>
    </soapenv:Envelope>
  XML
end

def soap_fault(code, string)
  <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
       <soapenv:Body>
          <soapenv:Fault>
             <faultcode>#{code}</faultcode>
             <faultstring>#{string}</faultstring>
          </soapenv:Fault>
       </soapenv:Body>
    </soapenv:Envelope>
  XML
end