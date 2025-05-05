package com.supermarket.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.supermarket.util.DatabaseUtil;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT a.admin_id, a.admin_name, a.access_level " +
                        "FROM admin a " +
                        "JOIN admin_credentials ac ON a.admin_id = ac.admin_id " +
                        "WHERE ac.username = ? AND ac.password = ?";
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        // Admin login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("adminId", rs.getInt("admin_id"));
                        session.setAttribute("adminName", rs.getString("admin_name"));
                        session.setAttribute("accessLevel", rs.getString("access_level"));
                        session.setAttribute("adminLoggedIn", true);
                        
                        // Redirect to admin dashboard
                        response.sendRedirect("admin/dashboard");
                    } else {
                        // Invalid credentials
                        request.setAttribute("error", "Invalid username or password");
                        request.getRequestDispatcher("admin_login.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
        }
    }
} 