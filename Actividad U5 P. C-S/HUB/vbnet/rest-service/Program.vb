Imports System.IdentityModel.Tokens.Jwt
Imports System.Security.Claims
Imports System.Text
Imports System.Text.Json
Imports Microsoft.AspNetCore.Authentication.JwtBearer
Imports Microsoft.AspNetCore.Builder
Imports Microsoft.AspNetCore.Hosting
Imports Microsoft.AspNetCore.Http
Imports Microsoft.Extensions.DependencyInjection
Imports Microsoft.IdentityModel.Tokens

Namespace RestService
    Module Program
        Sub Main(args As String())
            Dim builder = WebApplication.CreateBuilder(args)
            builder.WebHost.UseUrls("http://localhost:5003")

            Dim jwtSecret = "SecuredPass2026_Hub_VBNET_JWT_Key_12345!"
            Dim key = Encoding.ASCII.GetBytes(jwtSecret)

            builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).
                AddJwtBearer(Sub(options)
                                 options.TokenValidationParameters = New TokenValidationParameters With {
                                     .ValidateIssuerSigningKey = True,
                                     .IssuerSigningKey = New SymmetricSecurityKey(key),
                                     .ValidateIssuer = True,
                                     .ValidIssuer = "http://localhost:5003",
                                     .ValidateAudience = False
                                 }
                             End Sub)
            builder.Services.AddAuthorization()

            Imports Microsoft.OpenApi.Models

    ' Configuración Swagger para VB.NET (similar a C#)
    builder.Services.AddEndpointsApiExplorer()
    builder.Services.AddSwaggerGen(Sub(c)
        c.SwaggerDoc("v1", New OpenApiInfo With {.Title = "OmniLogistics VB.NET REST API", .Version = "v1"})
        ' Seguridad JWT
        c.AddSecurityDefinition("Bearer", New OpenApiSecurityScheme With {
            .Description = "Encabezado de autorización JWT usando el esquema Bearer.",
            .Name = "Authorization",
            .In = ParameterLocation.Header,
            .Type = SecuritySchemeType.Http,
            .Scheme = "bearer",
            .BearerFormat = "JWT"
        })
        c.AddSecurityRequirement(New OpenApiSecurityRequirement From {
            { New OpenApiSecuritySchemeReference("Bearer"), New List(Of String)() }
        })
    End Sub)

    Dim app = builder.Build()

    ' Habilitar Swagger UI
    app.UseSwagger()
    app.UseSwaggerUI(Sub(c)
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "OmniLogistics VB.NET REST API v1")
    End Sub)

    app.UseCors(Sub(policy) policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader())

    app.UseAuthentication()
    app.UseAuthorization()

    app.MapPost("/api/v1/auth/login", Function(context As HttpContext) As IResult
        Return LoginHandler(context, jwtSecret)
    End Function)

    app.MapGet("/api/v1/shipments", Function() As IResult
        Return Results.Ok(database)
    End Function).RequireAuthorization()

    Console.WriteLine("=========================================")
    Console.WriteLine(" HUB - VB.NET REST Service (Kestrel)")
    Console.WriteLine(" Escuchando en http://localhost:5003")
    Console.WriteLine("=========================================")
    app.Run()
            app.UseAuthentication()
            app.UseAuthorization()

            Dim database = New List(Of Object) From {
                New With {
                    .trackingNumber = "TRK-987654321-MX",
                    .origin = "Monterrey",
                    .destination = "CDMX",
                    .weightKg = 15.5,
                    .status = "IN_TRANSIT",
                    .updatedAt = DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")
                }
            }

            app.MapPost("/api/v1/auth/login", Function(context As HttpContext) As IResult
                                                  Return LoginHandler(context, jwtSecret)
                                              End Function)

            app.MapGet("/api/v1/shipments", Function() As IResult
                                                Return Results.Ok(database)
                                            End Function).RequireAuthorization()

            Console.WriteLine("=========================================")
            Console.WriteLine(" HUB - VB.NET REST Service (Kestrel)")
            Console.WriteLine(" Escuchando en http://localhost:5003")
            Console.WriteLine("=========================================")
            app.Run()
        End Sub

        Private Function LoginHandler(context As HttpContext, secret As String) As IResult
            Dim requestBody = New IO.StreamReader(context.Request.Body).ReadToEndAsync().Result
            Try
                Dim payload = JsonSerializer.Deserialize(Of Dictionary(Of String, String))(requestBody)
                If payload IsNot Nothing AndAlso payload.ContainsKey("username") AndAlso payload.ContainsKey("password") Then
                    If payload("username") = "omni_admin" AndAlso payload("password") = "SecuredPass2026!" Then
                        Dim tokenHandler = New JwtSecurityTokenHandler()
                        Dim tokenDescriptor = New SecurityTokenDescriptor With {
                            .Subject = New ClaimsIdentity(New Claim() {New Claim(ClaimTypes.Name, "omni_admin")}),
                            .Expires = DateTime.UtcNow.AddHours(1),
                            .Issuer = "http://localhost:5003",
                            .SigningCredentials = New SigningCredentials(New SymmetricSecurityKey(Encoding.ASCII.GetBytes(secret)), SecurityAlgorithms.HmacSha256Signature)
                        }
                        Return Results.Ok(New With {.token = tokenHandler.WriteToken(tokenHandler.CreateToken(tokenDescriptor))})
                    End If
                End If
            Catch ex As Exception
            End Try
            Return Results.Unauthorized()
        End Function
    End Module
End Namespace