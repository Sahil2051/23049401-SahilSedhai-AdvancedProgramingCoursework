<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Supermarket Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="auth-page">
    <div class="auth-container full-screen">
        <div class="auth-content">
            <div class="auth-header">
                <h1 class="auth-title">Admin Login</h1>
                <p class="auth-subtitle">Please login to access admin dashboard</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <div class="d-flex align-items-center">
                        <svg class="me-2" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 0C4.48 0 0 4.48 0 10C0 15.52 4.48 20 10 20C15.52 20 20 15.52 20 10C20 4.48 15.52 0 10 0ZM11 15H9V13H11V15ZM11 11H9V5H11V11Z" fill="currentColor"/>
                        </svg>
                        <%= request.getAttribute("error") %>
                    </div>
                </div>
            <% } %>
            
            <form class="auth-form" action="adminLogin" method="POST">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-group">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" placeholder="Enter admin username" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Enter admin password" required>
                    </div>
                </div>
                
                <button type="submit" class="auth-submit-btn">Login as Admin</button>
            </form>
            
            <div class="auth-footer">
                <a href="index.jsp">Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html> 