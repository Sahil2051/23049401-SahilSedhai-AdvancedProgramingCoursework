package com.supermarket.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.supermarket.model.CartItem;
import com.supermarket.util.DatabaseUtil;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get cart items from session
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems != null && !cartItems.isEmpty()) {
            // Calculate total quantity
            int totalQuantity = cartItems.stream()
                    .mapToInt(CartItem::getQuantity)
                    .sum();
            
            // Update total sales in session
            Integer totalSales = (Integer) session.getAttribute("totalSales");
            if (totalSales == null) {
                totalSales = 0;
            }
            totalSales += totalQuantity;
            session.setAttribute("totalSales", totalSales);
            
            // Clear the cart
            cartItems.clear();
            session.setAttribute("cartItems", cartItems);
            
            // Redirect to success page
            response.sendRedirect("checkout_success.jsp");
        } else {
            // If cart is empty, redirect back to cart page
            response.sendRedirect("cart.jsp");
        }
    }
} 