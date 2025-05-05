package com.supermarket.dao;

import com.supermarket.model.User;
import com.supermarket.util.DatabaseUtil;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.*;
import java.util.Base64;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    private static final String HASH_ALGORITHM = "SHA-256";

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, user_email) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            int rowsAffected = pstmt.executeUpdate();
            LOGGER.info("Registration attempt for user: " + user.getUsername() + 
                       ", rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error registering user: " + e.getMessage());
            return false;
        }
    }

    public void checkTableStructure() {
        String sql = "DESCRIBE users";
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            LOGGER.info("Users table structure:");
            while (rs.next()) {
                String columnName = rs.getString("Field");
                String type = rs.getString("Type");
                String isNull = rs.getString("Null");
                String key = rs.getString("Key");
                LOGGER.info(String.format("Column: %s, Type: %s, Null: %s, Key: %s", 
                    columnName, type, isNull, key));
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking table structure: " + e.getMessage());
        }
    }

    public User loginUser(String username, String password) {
        checkTableStructure(); // Check table structure before proceeding
        
        String hashedPassword = hashPassword(password);
        String sql = "SELECT user_id, username, user_email, password FROM users WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                LOGGER.info("Login attempt for user: " + username + 
                          "\nStored password: " + storedPassword + 
                          "\nProvided password: " + password +
                          "\nHashed provided password: " + hashedPassword);
                
                if (storedPassword.equals(hashedPassword)) {
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("user_email"));
                    LOGGER.info("Login successful for user: " + username);
                    return user;
                } else {
                    LOGGER.warning("Password mismatch for user: " + username);
                }
            } else {
                LOGGER.warning("User not found: " + username);
            }
            return null;
        } catch (SQLException e) {
            LOGGER.severe("Error logging in user: " + e.getMessage());
            return null;
        }
    }

    private void updatePasswordToHashed(String username, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, hashedPassword);
            pstmt.setString(2, username);
            pstmt.executeUpdate();
            LOGGER.info("Updated password to hashed for user: " + username);
        } catch (SQLException e) {
            LOGGER.severe("Error updating password to hashed: " + e.getMessage());
        }
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking username: " + e.getMessage());
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE user_email = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.severe("Error checking email: " + e.getMessage());
        }
        return false;
    }

    public void storeRememberMeToken(String username, String token) {
        String sql = "INSERT INTO remember_me_tokens (username, token) VALUES (?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, token);
            pstmt.executeUpdate();
            LOGGER.info("Remember me token stored for user: " + username);
        } catch (SQLException e) {
            LOGGER.severe("Error storing remember me token: " + e.getMessage());
        }
    }

    public User validateRememberMeToken(String token) {
        String sql = "SELECT u.id, u.username, u.user_email FROM users u " +
                    "JOIN remember_me_tokens rmt ON u.username = rmt.username " +
                    "WHERE rmt.token = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, token);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("user_email"));
                LOGGER.info("Remember me token validated for user: " + user.getUsername());
                return user;
            }
            return null;
        } catch (SQLException e) {
            LOGGER.severe("Error validating remember me token: " + e.getMessage());
            return null;
        }
    }

    public String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hash = digest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.severe("Error hashing password: " + e.getMessage());
            throw new RuntimeException("Error hashing password", e);
        }
    }

    public String generateSecureToken() {
        try {
            SecureRandom random = new SecureRandom();
            byte[] randomBytes = new byte[32];
            random.nextBytes(randomBytes);
            return Base64.getEncoder().encodeToString(randomBytes);
        } catch (Exception e) {
            LOGGER.severe("Error generating secure token: " + e.getMessage());
            throw new RuntimeException("Error generating secure token", e);
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username = ?, user_email = ?, phone = ? WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.severe("Error updating user: " + e.getMessage());
            return false;
        }
    }
} 