import requests
from zeep import Client
import time

def print_header(title):
    print(f"\n{'-'*50}")
    print(f" {title}")
    print(f"{'-'*50}")

def run_client():
    print("\n===================================================")
    print("      HUB - CLIENTE PYTHON (REST + SOAP)")
    print("===================================================")

    # 1. CONSUMIR SERVICIO REST
    print_header("1. CONSUMIENDO API REST (Puerto 8000)")
    
    # a) Autenticacion
    print(" -> Autenticando (JWT)...")
    auth_url = "http://127.0.0.1:8000/api/v1/auth/login"
    credentials = {"username": "omni_admin", "password": "SecuredPass2026!"}
    
    try:
        response = requests.post(auth_url, json=credentials)
        response.raise_for_status()
        token = response.json()["token"]
        print(" [OK] Token JWT obtenido con exito.")
    except Exception as e:
        print(f" [ERROR] Fallo la autenticacion REST: {e}")
        return

    # b) Consultar catalogo de envios
    print("\n -> Consultando envios activos...")
    shipments_url = "http://127.0.0.1:8000/api/v1/shipments"
    headers = {"Authorization": f"Bearer {token}"}
    
    try:
        response = requests.get(shipments_url, headers=headers)
        response.raise_for_status()
        envios = response.json()
        print(f" [OK] {len(envios)} envios encontrados.")
        
        if not envios:
            print(" [INFO] No hay envios para consultar via SOAP.")
            return
            
        guia_a_buscar = envios[0]["tracking_number"]
        print(f" [INFO] Guia seleccionada para test SOAP: {guia_a_buscar}")
        
    except Exception as e:
        print(f" [ERROR] Fallo la consulta REST: {e}")
        return


    # 2. CONSUMIR SERVICIO SOAP
    print_header("2. CONSUMIENDO SERVICIO SOAP (Puerto 8005)")
    print(f" -> Consultando estatus para guia: {guia_a_buscar}")
    
    wsdl_url = 'http://127.0.0.1:8005/?wsdl'
    
    try:
        # Zeep lee el XML y autogenera los metodos nativos
        client = Client(wsdl=wsdl_url)
        
        # Consumimos la funcion RPC que definimos en el servidor Spyne
        resultado = client.service.GetShipmentStatus(trackingNumber=guia_a_buscar)
        
        print(" [OK] Respuesta SOAP (Des-serializada):")
        print(f"      - Guia:   {resultado.TrackingNumber}")
        print(f"      - Estatus: {resultado.Status}")
        print(f"      - Actualizacion: {resultado.UpdatedAt}")
        
    except Exception as e:
        print(f" [ERROR] Fallo la consulta SOAP: {e}")

if __name__ == '__main__':
    # Pequeña pausa para asegurar que los servidores esten listos (si se lanzan al mismo tiempo)
    time.sleep(1)
    run_client()