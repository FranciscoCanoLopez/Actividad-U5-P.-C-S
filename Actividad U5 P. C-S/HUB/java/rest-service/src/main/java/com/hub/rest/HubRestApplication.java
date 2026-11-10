package com.hub.rest;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.crypto.SecretKey;
import java.io.IOException;
import java.time.Instant;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@SpringBootApplication
public class HubRestApplication {

    public static void main(String[] args) {
        SpringApplication.run(HubRestApplication.class, args);
        System.out.println("=========================================");
        System.out.println(" HUB - Java REST Service (Spring Boot)");
        System.out.println(" Escuchando en http://localhost:8081");
        System.out.println("=========================================");
    }
}

// --- CONFIGURACIÓN DE SEGURIDAD Y JWT ---
@Configuration
@EnableWebSecurity
class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(AbstractHttpConfigurer::disable)
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/v1/auth/login").permitAll()
                .anyRequest().authenticated()
            )
            .addFilterBefore(new JwtFilter(), UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}

class JwtFilter extends OncePerRequestFilter {
    private final SecretKey key = Keys.hmacShaKeyFor("SecuredPass2026_Hub_Java_JWT_Key!".getBytes());

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) 
            throws ServletException, IOException {
        
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            try {
                String token = header.substring(7);
                String user = Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload().getSubject();
                if (user != null) {
                    SecurityContextHolder.getContext().setAuthentication(
                        new UsernamePasswordAuthenticationToken(user, null, Collections.emptyList())
                    );
                }
            } catch (Exception e) {
                SecurityContextHolder.clearContext();
            }
        }
        chain.doFilter(request, response);
    }
}

// --- MODELOS DE DATOS ---
record LoginRequest(String username, String password) {}
record AuthResponse(String token) {}
record ShipmentResponse(String trackingNumber, String origin, String destination, double weightKg, String status, String updatedAt) {}

// --- CONTROLADORES REST ---
@RestController
@RequestMapping("/api/v1")
class HubController {

    private final SecretKey key = Keys.hmacShaKeyFor("SecuredPass2026_Hub_Java_JWT_Key!".getBytes());

    @PostMapping("/auth/login")
    public AuthResponse login(@RequestBody LoginRequest req) {
        if ("omni_admin".equals(req.username()) && "SecuredPass2026!".equals(req.password())) {
            String token = Jwts.builder()
                    .subject(req.username())
                    .expiration(Date.from(Instant.now().plusSeconds(3600)))
                    .signWith(key)
                    .compact();
            return new AuthResponse(token);
        }
        throw new RuntimeException("Credenciales invalidas");
    }

    @GetMapping("/shipments")
    public List<ShipmentResponse> getShipments() {
        return List.of(
            new ShipmentResponse("TRK-987654321-MX", "Monterrey", "CDMX", 15.5, "IN_TRANSIT", Instant.now().toString())
        );
    }
}