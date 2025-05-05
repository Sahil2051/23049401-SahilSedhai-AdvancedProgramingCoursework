package com.supermarket.servlet;

import com.supermarket.dao.UserDAO;
import com.supermarket.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.logging.Logger;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());
    private static final String HASH_ALGORITHM = "SHA-256";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        LOGGER.info("Registration attempt for username: " + username + ", email: " + email);

        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            LOGGER.warning("Invalid input parameters");
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Hash the password
        String hashedPassword = hashPassword(password);
        LOGGER.info("Password hashed successfully");

        UserDAO userDAO = new UserDAO();

        // Check if username exists
        if (userDAO.isUsernameExists(username)) {
            LOGGER.warning("Username already exists: " + username);
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if email exists
        if (userDAO.isEmailExists(email)) {
            LOGGER.warning("Email already exists: " + email);
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create and register user
        User user = new User(username, hashedPassword, email);
        if (userDAO.registerUser(user)) {
            LOGGER.info("Registration successful for user: " + username);
            response.sendRedirect("login.jsp?registered=true");
        } else {
            LOGGER.severe("Registration failed for user: " + username);
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    public static String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hash = digest.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            LOGGER.severe("Error hashing password: " + e.getMessage());
            throw new RuntimeException("Error hashing password", e);
        }
    }
} 