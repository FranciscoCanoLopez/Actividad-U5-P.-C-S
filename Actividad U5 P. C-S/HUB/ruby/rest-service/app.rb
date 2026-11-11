require 'sinatra'
require 'sinatra/json'
require 'jwt'

set :port, 8085
set :bind, '0.0.0.0'
set :server, 'puma'

# Secret para JWT (¡En producción usa variables de entorno!)
JWT_SECRET = 'SecuredPass2026_Hub_Ruby_JWT_Key!'

# Base de datos simulada en memoria
DATABASE = {
  'TRK-987654321-MX' => {
    trackingNumber: 'TRK-987654321-MX',
    origin: 'Monterrey',
    destination: 'CDMX',
    weightKg: 15.5,
    status: 'IN_TRANSIT',
    updatedAt: Time.now.utc.iso8601
  }
}

# Filtro Before para verificar JWT en rutas protegidas
before '/api/v1/shipments' do
  auth_header = request.env['HTTP_AUTHORIZATION']
  if auth_header && auth_header.match(/^Bearer (.*)/)
    token = $1
    begin
      JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
    rescue JWT::DecodeError
      halt 401, json(error: 'Token inválido o expirado')
    end
  else
    halt 401, json(error: 'Token no proporcionado')
  end
end

# Endpoint de Login (Generación de JWT)
post '/api/v1/auth/login' do
  request.body.rewind
  payload = JSON.parse(request.body.read) rescue {}

  if payload['username'] == 'omni_admin' && payload['password'] == 'SecuredPass2026!'
    token_payload = {
      iss: 'http://localhost:8085',
      sub: payload['username'],
      iat: Time.now.to_i,
      exp: Time.now.to_i + 3600
    }
    token = JWT.encode(token_payload, JWT_SECRET, 'HS256')
    json(token: token)
  else
    status 401
    json(error: 'Credenciales inválidas')
  end
end

# Endpoint de Envíos (Protegido)
get '/api/v1/shipments' do
  json DATABASE.values
end