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

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession();
        Boolean isAdminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");
        
        if (isAdminLoggedIn == null || !isAdminLoggedIn) {
            response.sendRedirect(request.getContextPath() + "/admin_login.jsp");
            return;
        }
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            // Get total products count
            String productsSql = "SELECT COUNT(*) as total FROM product";
            try (PreparedStatement pstmt = conn.prepareStatement(productsSql)) {
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("totalProducts", rs.getInt("total"));
                    }
                }
            }
            
            // Get total sales count
            String salesSql = "SELECT COUNT(*) as total FROM sale";
            try (PreparedStatement pstmt = conn.prepareStatement(salesSql)) {
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("totalSales", rs.getInt("total"));
                    }
                }
            }
            
            // Get total users count (changed from customer to users)
            String usersSql = "SELECT COUNT(*) as total FROM users";
            try (PreparedStatement pstmt = conn.prepareStatement(usersSql)) {
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("totalCustomers", rs.getInt("total"));
                    }
                }
            }
            
            // Forward to admin dashboard JSP
            request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred. Please try again later.");
            request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
        }
    }
} 