package com.supermarket.servlet;

import com.supermarket.dao.UserDAO;
import com.supermarket.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;

@WebServlet("/test-auth")
public class TestAuthServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TestAuthServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            UserDAO userDAO = new UserDAO();
            
            // Test password hashing
            String testPassword = "123";
            String hashedPassword = userDAO.hashPassword(testPassword);
            
            out.println("<h2>Password Hashing Test</h2>");
            out.println("Original Password: " + testPassword + "<br>");
            out.println("Hashed Password: " + hashedPassword + "<br>");
            
            // Test login with existing user
            User user = userDAO.loginUser("sahil", "123");
            out.println("<h2>Login Test</h2>");
            if (user != null) {
                out.println("Login successful!<br>");
                out.println("User ID: " + user.getId() + "<br>");
                out.println("Username: " + user.getUsername() + "<br>");
                out.println("Email: " + user.getEmail() + "<br>");
            } else {
                out.println("Login failed!");
            }
            
            // Test remember me token
            String token = userDAO.generateSecureToken();
            out.println("<h2>Remember Me Token Test</h2>");
            out.println("Generated Token: " + token + "<br>");
            
            if (user != null) {
                userDAO.storeRememberMeToken(user.getUsername(), token);
                out.println("Token stored successfully!<br>");
                
                User validatedUser = userDAO.validateRememberMeToken(token);
                if (validatedUser != null) {
                    out.println("Token validation successful!<br>");
                    out.println("Validated User: " + validatedUser.getUsername());
                } else {
                    out.println("Token validation failed!");
                }
            }
            
        } catch (Exception e) {
            out.println("<h2>Error:</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            LOGGER.severe("Test error: " + e.getMessage());
        }
    }
} 