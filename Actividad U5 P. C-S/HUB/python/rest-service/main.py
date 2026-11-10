import datetime
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from pydantic import BaseModel
import jwt

# Configuracion JWT
SECRET_KEY = "SecuredPass2026!"
ALGORITHM = "HS256"
security = HTTPBearer()

app = FastAPI(
    title="Hub Python REST API",
    description="Servicio RESTful del Hub desarrollado en FastAPI",
    version="1.0.0"
)

# Simulacion de base de datos en memoria
database = [
    {
        "tracking_number": "TRK-987654321-MX",
        "origin": "Monterrey",
        "destination": "CDMX",
        "weight_kg": 15.5,
        "declared_value": 1500.00,
        "status": "IN_TRANSIT",
        "created_at": datetime.datetime.now(datetime.timezone.utc).isoformat()
    }
]

# Modelos Pydantic
class LoginRequest(BaseModel):
    username: str
    password: str

class AuthResponse(BaseModel):
    token: str

class ShipmentResponse(BaseModel):
    tracking_number: str
    origin: str
    destination: str
    weight_kg: float
    declared_value: float
    status: str
    created_at: str

# Dependencia de validacion de Token
def verify_token(credentials: HTTPAuthorizationCredentials = Depends(security)):
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token expirado"
        )
    except jwt.InvalidTokenError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Token invalido"
        )

@app.post("/api/v1/auth/login", response_model=AuthResponse, tags=["Auth"])
def login(request: LoginRequest):
    if request.username == "omni_admin" and request.password == "SecuredPass2026!":
        payload = {
            "sub": request.username,
            "exp": datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(hours=1)
        }
        token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
        return {"token": token}
    
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Credenciales incorrectas"
    )

@app.get("/api/v1/shipments", response_model=list[ShipmentResponse], tags=["Shipments"])
def get_shipments(user: dict = Depends(verify_token)):
    return database