# Servidor RESTful
dotnet new webapi -n CSharpRestService -o csharp/rest-service --no-https
cd csharp/rest-service
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer

# Servidor SOAP (CoreWCF)
cd ../..
dotnet new web -n CSharpSoapService -o csharp/soap-service
cd csharp/soap-service
dotnet add package CoreWCF.Http
dotnet add package CoreWCF.Primitives
dotnet add package CoreWCF.Metadata

# Cliente Consola
cd ../..
dotnet new console -n CSharpClient -o csharp/client