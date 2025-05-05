package com.supermarket.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;
import com.supermarket.util.DatabaseUtil;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.BufferedReader;
import java.security.MessageDigest;
import java.util.Base64;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(AdminServlet.class.getName());
    private static final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("getStats".equals(action)) {
            getStats(request, response);
        } else if ("getUsers".equals(action)) {
            getUsers(request, response);
        } else if ("getUser".equals(action)) {
            getUser(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("addUser".equals(action)) {
            addUser(request, response);
        } else if ("updateUser".equals(action)) {
            updateUser(request, response);
        } else if ("deleteUser".equals(action)) {
            deleteUser(request, response);
        }
    }

    private void getStats(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        
        // Get total users from database
        int totalUsers = 0;
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT COUNT(*) as total FROM users";
            logger.info("Executing SQL query: " + sql);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        totalUsers = rs.getInt("total");
                        logger.info("Total users found in database: " + totalUsers);
                    }
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting user count: " + e.getMessage(), e);
            e.printStackTrace();
        }

        // Create response object
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", totalUsers);
        stats.put("totalProducts", 32); // Static value for total products
        logger.info("Sending response with totalUsers: " + totalUsers + ", totalProducts: 32");

        // Send JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse = gson.toJson(stats);
        logger.info("JSON response: " + jsonResponse);
        out.print(jsonResponse);
        out.flush();
    }

    private void getUsers(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        List<Map<String, Object>> users = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            logger.info("Database connection established successfully");
            
            String sql = "SELECT user_id, username, user_email, phone FROM users ORDER BY user_id";
            logger.info("Executing SQL query: " + sql);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> user = new HashMap<>();
                        
                        // Get and validate each field
                        int userId = rs.getInt("user_id");
                        String username = rs.getString("username");
                        String email = rs.getString("user_email");
                        String phone = rs.getString("phone");
                        
                        // Log raw data from database
                        logger.info(String.format("Raw database data - ID: %d, Username: '%s', Email: '%s', Phone: '%s'",
                            userId, username, email, phone));
                        
                        // Validate and set user data
                        if (userId <= 0) {
                            logger.warning("Invalid user ID found: " + userId);
                            continue;
                        }
                        
                        if (username == null || username.trim().isEmpty()) {
                            logger.warning("Empty username found for user ID: " + userId);
                            username = "Unknown User";
                        }
                        
                        // Set the user data
                        user.put("user_id", userId);
                        user.put("username", username.trim());
                        user.put("user_email", email != null ? email.trim() : "");
                        user.put("phone", phone != null ? phone.trim() : "");
                        
                        // Log the processed user data
                        logger.info(String.format("Processed user data - ID: %d, Username: '%s'",
                            userId, username));
                        
                        users.add(user);
                    }
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting users: " + e.getMessage(), e);
            e.printStackTrace();
        }

        // Log the final data being sent
        logger.info("Total users to be sent: " + users.size());
        for (Map<String, Object> user : users) {
            logger.info("User data being sent: " + user);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse = gson.toJson(users);
        logger.info("Final JSON response: " + jsonResponse);
        out.print(jsonResponse);
        out.flush();
    }

    private void getUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        Map<String, Object> user = new HashMap<>();
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT user_id, username, user_email, phone FROM users WHERE user_id = ?";
            logger.info("Executing SQL query: " + sql + " with userId: " + userId);
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        user.put("user_id", rs.getInt("user_id"));
                        user.put("username", rs.getString("username"));
                        user.put("user_email", rs.getString("user_email"));
                        user.put("phone", rs.getString("phone"));
                        logger.info("Found user: " + user);
                    }
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error getting user: " + e.getMessage(), e);
        }

        logger.info("Sending user details: " + user);
        sendJsonResponse(response, user);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Read request body
            BufferedReader reader = request.getReader();
            Map<String, String> data = gson.fromJson(reader, Map.class);
            logger.info("Received user data: " + data);
            
            // Hash password
            String hashedPassword = hashPassword(data.get("password"));
            
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "INSERT INTO users (username, password, user_email, phone) VALUES (?, ?, ?, ?)";
                logger.info("Executing SQL query: " + sql);
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, data.get("username"));
                    stmt.setString(2, hashedPassword);
                    stmt.setString(3, data.get("email"));
                    stmt.setString(4, data.get("phone"));
                    
                    int rowsAffected = stmt.executeUpdate();
                    result.put("success", rowsAffected > 0);
                    result.put("message", rowsAffected > 0 ? "User added successfully" : "Failed to add user");
                    logger.info("Add user result: " + result);
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error adding user: " + e.getMessage(), e);
            result.put("success", false);
            result.put("message", "Error adding user: " + e.getMessage());
        }

        sendJsonResponse(response, result);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Read request body
            BufferedReader reader = request.getReader();
            Map<String, String> data = gson.fromJson(reader, Map.class);
            logger.info("Received update data: " + data);
            
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "UPDATE users SET username = ?, user_email = ?, phone = ? WHERE user_id = ?";
                logger.info("Executing SQL query: " + sql);
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, data.get("username"));
                    stmt.setString(2, data.get("email"));
                    stmt.setString(3, data.get("phone"));
                    stmt.setInt(4, Integer.parseInt(data.get("userId")));
                    
                    int rowsAffected = stmt.executeUpdate();
                    result.put("success", rowsAffected > 0);
                    result.put("message", rowsAffected > 0 ? "User updated successfully" : "Failed to update user");
                    logger.info("Update user result: " + result);
                }
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating user: " + e.getMessage(), e);
            result.put("success", false);
            result.put("message", "Error updating user: " + e.getMessage());
        }

        sendJsonResponse(response, result);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null || userIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("User ID is required");
            }
            
            int userId = Integer.parseInt(userIdStr);
            logger.info("Deleting user with ID: " + userId);
            
            try (Connection conn = DatabaseUtil.getConnection()) {
                // First check if user exists
                String checkSql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, userId);
                    try (ResultSet rs = checkStmt.executeQuery()) {
                        if (rs.next() && rs.getInt(1) == 0) {
                            result.put("success", false);
                            result.put("message", "User not found");
                            sendJsonResponse(response, result);
                            return;
                        }
                    }
                }
                
                // Proceed with deletion
                String sql = "DELETE FROM users WHERE user_id = ?";
                logger.info("Executing SQL query: " + sql);
                
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    
                    int rowsAffected = stmt.executeUpdate();
                    result.put("success", rowsAffected > 0);
                    result.put("message", rowsAffected > 0 ? "User deleted successfully" : "Failed to delete user");
                    logger.info("Delete user result: " + result);
                }
            }
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Invalid user ID format: " + e.getMessage(), e);
            result.put("success", false);
            result.put("message", "Invalid user ID format");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting user: " + e.getMessage(), e);
            result.put("success", false);
            result.put("message", "Error deleting user: " + e.getMessage());
        }

        sendJsonResponse(response, result);
    }

    private String hashPassword(String password) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(hash);
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse = gson.toJson(data);
        logger.info("Sending JSON response: " + jsonResponse);
        out.print(jsonResponse);
        out.flush();
    }
} 