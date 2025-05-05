package com.supermarket.servlet;

import com.supermarket.dao.UserDAO;
import com.supermarket.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        User user = userDAO.loginUser(username, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Handle remember me functionality
            if (rememberMe != null && rememberMe.equals("on")) {
                String token = userDAO.generateSecureToken();
                userDAO.storeRememberMeToken(username, token);
                
                Cookie rememberMeCookie = new Cookie("rememberMe", token);
                rememberMeCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                rememberMeCookie.setPath("/");
                response.addCookie(rememberMeCookie);
            }
            
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check for remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("rememberMe")) {
                    String token = cookie.getValue();
                    User user = userDAO.validateRememberMeToken(token);
                    if (user != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);
                        response.sendRedirect("dashboard.jsp");
                        return;
                    }
                }
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
} 