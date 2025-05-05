package com.supermarket.servlet;

import com.supermarket.util.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.logging.Logger;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TestServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Test database connection
            Connection conn = DatabaseUtil.getConnection();
            if (conn != null) {
                LOGGER.info("Database connection successful");
                
                // Test table creation
                try (Statement stmt = conn.createStatement()) {
                    // Create users table
                    stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                            "id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "username VARCHAR(50) NOT NULL UNIQUE, " +
                            "password VARCHAR(255) NOT NULL, " +
                            "email VARCHAR(100) NOT NULL UNIQUE, " +
                            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                            ")");
                    
                    // Create remember_me_tokens table
                    stmt.execute("CREATE TABLE IF NOT EXISTS remember_me_tokens (" +
                            "id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "username VARCHAR(50) NOT NULL, " +
                            "token VARCHAR(255) NOT NULL, " +
                            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                            "FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE, " +
                            "INDEX idx_token (token), " +
                            "INDEX idx_username (username)" +
                            ")");
                    
                    LOGGER.info("Tables created successfully");
                }
                
                response.getWriter().println("Database connection and table creation successful!");
            } else {
                LOGGER.severe("Database connection failed");
                response.getWriter().println("Database connection failed!");
            }
        } catch (Exception e) {
            LOGGER.severe("Error in test servlet: " + e.getMessage());
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
} 