package com.supermarket.servlet;

import com.supermarket.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "GuestServlet", urlPatterns = {"/guest"})
public class GuestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Create a guest user
        User guestUser = new User();
        guestUser.setUsername("Guest");
        guestUser.setId(0); // Special ID for guest users
        
        // Set the guest user in session
        HttpSession session = request.getSession();
        session.setAttribute("user", guestUser);
        
        // Redirect to the main page
        response.sendRedirect("dashboard.jsp");
    }
} 