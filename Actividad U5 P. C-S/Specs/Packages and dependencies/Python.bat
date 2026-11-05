# Servidor RESTful
cd python/rest-service
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
pip install fastapi uvicorn pydantic python-jose[cryptography] passlib[bcrypt]

# Servidor SOAP
cd ../soap-service
python -m venv venv
source venv/bin/activate
pip install spyne lxml wsgiref

# Cliente
cd ../client
python -m venv venv
source venv/bin/activate
pip install requests zeep