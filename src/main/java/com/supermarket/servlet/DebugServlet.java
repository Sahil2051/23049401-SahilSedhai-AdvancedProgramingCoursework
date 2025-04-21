package com.supermarket.servlet;

import com.supermarket.dao.UserDAO;
import com.supermarket.util.DatabaseUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.logging.Logger;

@WebServlet("/debug")
public class DebugServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DebugServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            // Test database connection
            Connection conn = DatabaseUtil.getConnection();
            if (conn == null) {
                out.println("<h2>Database Connection Failed</h2>");
                return;
            }
            
            out.println("<h2>Database Connection Successful</h2>");
            
            // Check users table
            try (Statement stmt = conn.createStatement()) {
                out.println("<h3>Users Table Contents:</h3>");
                ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                out.println("<table border='1'>");
                out.println("<tr><th>ID</th><th>Username</th><th>Password</th><th>Email</th><th>Created At</th></tr>");
                
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("password") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getTimestamp("created_at") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                // Test password hashing
                out.println("<h3>Password Hashing Test:</h3>");
                String testPassword = "test123";
                String hashedPassword = new RegisterServlet().hashPassword(testPassword);
                out.println("Original Password: " + testPassword + "<br>");
                out.println("Hashed Password: " + hashedPassword + "<br>");
                
                // Test user login
                out.println("<h3>Login Test:</h3>");
                UserDAO userDAO = new UserDAO();
                if (rs.first()) { // If there are any users
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    out.println("Testing login with first user:<br>");
                    out.println("Username: " + username + "<br>");
                    out.println("Password: " + password + "<br>");
                    out.println("Login result: " + (userDAO.loginUser(username, password) != null ? "Success" : "Failed"));
                } else {
                    out.println("No users found in database");
                }
            }
        } catch (Exception e) {
            out.println("<h2>Error:</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            LOGGER.severe("Debug error: " + e.getMessage());
        }
    }
} 