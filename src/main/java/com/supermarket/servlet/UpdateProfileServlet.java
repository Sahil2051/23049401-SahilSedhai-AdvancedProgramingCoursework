package com.supermarket.servlet;

import com.supermarket.dao.UserDAO;
import com.supermarket.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newUsername = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");

        // Update user in database
        currentUser.setUsername(newUsername);
        currentUser.setEmail(newEmail);
        currentUser.setPhone(newPhone);

        boolean success = userDAO.updateUser(currentUser);

        if (success) {
            // Update session with new user data
            session.setAttribute("user", currentUser);
            response.sendRedirect("profile.jsp?success=true");
        } else {
            response.sendRedirect("profile.jsp?error=true");
        }
    }
} 