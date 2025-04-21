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
            pstmt.setString(2, hashPassword(user.getPassword()));
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

    public User loginUser(String username, String password) {
        String hashedPassword = hashPassword(password);
        String sql = "SELECT user_id, username, user_email, password FROM users WHERE username = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                // Check both hashed and plain text password during transition
                if (storedPassword.equals(hashedPassword) || storedPassword.equals(password)) {
                    // If password is plain text, update it to hashed
                    if (storedPassword.equals(password)) {
                        updatePasswordToHashed(username, hashedPassword);
                    }
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("user_email"));
                    LOGGER.info("Login successful for user: " + username);
                    return user;
                }
            }
            LOGGER.warning("Login failed for user: " + username);
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
        String sql = "SELECT u.user_id, u.username, u.user_email FROM users u " +
                    "JOIN remember_me_tokens rmt ON u.username = rmt.username " +
                    "WHERE rmt.token = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, token);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
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
} 