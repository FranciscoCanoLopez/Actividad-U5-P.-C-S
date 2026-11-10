package com.hub.client;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class HubClient {

    private static final HttpClient HTTP_CLIENT = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(10))
            .build();
    private static final Gson GSON = new Gson();

    public static void main(String[] args) {
        System.out.println("\n===================================================");
        System.out.println("      HUB - CLIENTE JAVA (REST + SOAP)");
        System.out.println("===================================================\n");

        try {
            // ---------------------------------------------------------
            // 1. CONSUMIR SERVICIO REST (Puerto 8081)
            // ---------------------------------------------------------
            printHeader("1. CONSUMIENDO API REST (Puerto 8081)");

            System.out.println(" -> Autenticando (JWT)...");
            JsonObject creds = new JsonObject();
            creds.addProperty("username", "omni_admin");
            creds.addProperty("password", "SecuredPass2026!");

            HttpRequest authReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:8081/api/v1/auth/login"))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(creds.toString()))
                    .build();

            HttpResponse<String> authRes = HTTP_CLIENT.send(authReq, HttpResponse.BodyHandlers.ofString());
            
            if (authRes.statusCode() != 200) {
                throw new RuntimeException("Fallo la autenticación REST: HTTP " + authRes.statusCode());
            }
            
            String token = GSON.fromJson(authRes.body(), JsonObject.class).get("token").getAsString();
            System.out.println(" [OK] Token JWT obtenido con exito.");

            System.out.println("\n -> Consultando envios activos...");
            HttpRequest getReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:8081/api/v1/shipments"))
                    .header("Authorization", "Bearer " + token)
                    .GET()
                    .build();

            HttpResponse<String> getRes = HTTP_CLIENT.send(getReq, HttpResponse.BodyHandlers.ofString());
            JsonArray envios = GSON.fromJson(getRes.body(), JsonArray.class);
            System.out.println(" [OK] " + envios.size() + " envios encontrados.");

            if (envios.isEmpty()) return;
            String guiaABuscar = envios.get(0).getAsJsonObject().get("trackingNumber").getAsString();
            System.out.println(" [INFO] Guia seleccionada para test SOAP: " + guiaABuscar);

            // ---------------------------------------------------------
            // 2. CONSUMIR SERVICIO SOAP (Puerto 8082)
            // ---------------------------------------------------------
            printHeader("2. CONSUMIENDO SERVICIO SOAP (Puerto 8082)");
            System.out.println(" -> Consultando estatus para guia: " + guiaABuscar);

            // Construir el sobre XML (SOAP Envelope)
            String soapRequest = 
                "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ser=\"http://hub.local/services\">" +
                "   <soapenv:Header/>" +
                "   <soapenv:Body>" +
                "      <ser:getShipmentStatus>" +
                "         <trackingNumber>" + guiaABuscar + "</trackingNumber>" +
                "      </ser:getShipmentStatus>" +
                "   </soapenv:Body>" +
                "</soapenv:Envelope>";

            HttpRequest soapReq = HttpRequest.newBuilder()
                    .uri(URI.create("http://localhost:8082/ShipmentService"))
                    .header("Content-Type", "text/xml; charset=utf-8")
                    .POST(HttpRequest.BodyPublishers.ofString(soapRequest))
                    .build();

            HttpResponse<String> soapRes = HTTP_CLIENT.send(soapReq, HttpResponse.BodyHandlers.ofString());
            
            if (soapRes.statusCode() == 200) {
                System.out.println(" [OK] Respuesta SOAP recibida.");
                // Extracción simple para demostración en consola
                String responseBody = soapRes.body();
                String status = extractXmlTag(responseBody, "status");
                String date = extractXmlTag(responseBody, "updatedAt");
                
                System.out.println("      - Guia:    " + guiaABuscar);
                System.out.println("      - Estatus: " + status);
                System.out.println("      - Fecha:   " + date);
            } else {
                System.out.println(" [ERROR] SOAP Fault: HTTP " + soapRes.statusCode());
                System.out.println(soapRes.body());
            }

        } catch (Exception e) {
            System.out.println(" [ERROR] " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void printHeader(String title) {
        System.out.println("\n---------------------------------------------------");
        System.out.println(" " + title);
        System.out.println("---------------------------------------------------");
    }

    private static String extractXmlTag(String xml, String tag) {
        String openTag = "<" + tag + ">";
        String closeTag = "</" + tag + ">";
        int start = xml.indexOf(openTag);
        int end = xml.indexOf(closeTag);
        if (start != -1 && end != -1) {
            return xml.substring(start + openTag.length(), end);
        }
        return "N/A";
    }
}