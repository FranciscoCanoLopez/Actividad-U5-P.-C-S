import sys
import inspect
import collections
import types
import six

# --- PARCHE DE COMPATIBILIDAD CRÍTICA (PYTHON 3.14) ---
# 1. Reconstruir 'getargspec' (eliminado en Python 3.11+)
if not hasattr(inspect, 'getargspec'):
    ArgSpec = collections.namedtuple('ArgSpec', ['args', 'varargs', 'keywords', 'defaults'])
    def getargspec(func):
        spec = inspect.getfullargspec(func)
        return ArgSpec(spec.args, spec.varargs, spec.varkw, spec.defaults)
    inspect.getargspec = getargspec

# 2. Reconstruir el módulo 'cgi' (eliminado en Python 3.13+)
if 'cgi' not in sys.modules:
    from werkzeug.http import parse_options_header
    cgi_mock = types.ModuleType('cgi')
    cgi_mock.parse_header = parse_options_header
    sys.modules['cgi'] = cgi_mock

# 3. Mapear dependencias internas de Spyne a 'six' actualizado
# Inyectar 'get_function_name' que falta en las versiones modernas de six

if not hasattr(six, 'get_function_name'):
    def get_function_name(func):
        return func.__name__ if hasattr(func, '__name__') else str(func)
    six.get_function_name = get_function_name

sys.modules['spyne.util.six'] = six
sys.modules['spyne.util.six.moves'] = six.moves
sys.modules['spyne.util.six.moves.collections_abc'] = six.moves.collections_abc
sys.modules['spyne.util.six.moves.urllib'] = six.moves.urllib
sys.modules['spyne.util.six.moves.urllib.parse'] = six.moves.urllib.parse
sys.modules['spyne.util.six.moves.urllib.request'] = six.moves.urllib.request

# Mapeo de cookies para el servidor WSGI
import http.cookies
sys.modules['spyne.util.six.moves.http_cookies'] = http.cookies
# ------------------------------------------------------

import logging
from datetime import datetime, timezone
from spyne import Application, rpc, ServiceBase, Unicode, Float, ComplexModel, Fault
from spyne.protocol.soap import Soap11
from spyne.server.wsgi import WsgiApplication
from werkzeug.serving import run_simple

# Habilitar logs para debug en terminal
logging.basicConfig(level=logging.DEBUG)

# Simulacion de base de datos en memoria
database = {
    "TRK-987654321-MX": {
        "status": "IN_TRANSIT",
        "updated_at": datetime.now(timezone.utc).isoformat()
    }
}

# --- MODELOS COMPLEJOS WSDL ---
class ShipmentRequest(ComplexModel):
    TrackingNumber = Unicode
    Origin = Unicode
    Destination = Unicode
    WeightKg = Float
    DeclaredValue = Float

class ShipmentResponse(ComplexModel):
    TrackingNumber = Unicode
    Status = Unicode
    UpdatedAt = Unicode

# --- DEFINICION DEL SERVICIO SOAP ---
class ShipmentSoapService(ServiceBase):
    
    @rpc(Unicode, _returns=ShipmentResponse)
    def GetShipmentStatus(ctx, trackingNumber):
        logging.info(f"Peticion SOAP recibida para la guia: {trackingNumber}")
        
        if trackingNumber in database:
            data = database[trackingNumber]
            return ShipmentResponse(
                TrackingNumber=trackingNumber,
                Status=data["status"],
                UpdatedAt=data["updated_at"]
            )
            
        # Lanzar error SOAP estructurado si no existe
        raise Fault(
            faultcode="Client.NotFound",
            faultstring=f"La guia '{trackingNumber}' no fue encontrada en el Hub."
        )

# --- CONFIGURACION DE LA APLICACION SPYNE ---
app = Application(
    [ShipmentSoapService],
    tns='http://hub.local/services',
    in_protocol=Soap11(validator='lxml'),
    out_protocol=Soap11()
)

# Empaquetado WSGI
wsgi_app = WsgiApplication(app)

if __name__ == '__main__':
    port = 8005
    print("=========================================")
    print(f" HUB - Python SOAP Service (Spyne)")
    print(f" Escuchando en http://127.0.0.1:{port}")
    print(f" WSDL: http://127.0.0.1:{port}/?wsdl")
    print("=========================================\n")
    
    # Levantar servidor Werkzeug
    run_simple('127.0.0.1', port, wsgi_app, use_reloader=True)