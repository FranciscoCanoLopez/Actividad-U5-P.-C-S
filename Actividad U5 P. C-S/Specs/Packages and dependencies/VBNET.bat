# Servidor RESTful
dotnet new webapi -lang "VB" -n VbRestService -o vbnet/rest-service --no-https
cd vbnet/rest-service
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer

# Servidor SOAP
cd ../..
dotnet new web -lang "VB" -n VbSoapService -o vbnet/soap-service
cd vbnet/soap-service
dotnet add package CoreWCF.Http
dotnet add package CoreWCF.Primitives
dotnet add package CoreWCF.Metadata

# Cliente Consola
cd ../..
dotnet new console -lang "VB" -n VbClient -o vbnet/client