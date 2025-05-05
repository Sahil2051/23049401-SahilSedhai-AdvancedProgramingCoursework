<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if admin is logged in and has super admin access
    Boolean isAdminLoggedIn = (Boolean) session.getAttribute("adminLoggedIn");
    String accessLevel = (String) session.getAttribute("accessLevel");
    
    if (isAdminLoggedIn == null || !isAdminLoggedIn || !"SUPER_ADMIN".equals(accessLevel)) {
        response.sendRedirect(request.getContextPath() + "/admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create New Admin - Supermart</title>
    <style>
        /* Reusing your existing styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        
        .main-content {
            flex: 1;
            padding: 30px;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-container {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .form-header {
            margin-bottom: 2rem;
        }
        
        .form-header h2 {
            color: #2c3e50;
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
        }
        
        .submit-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .submit-btn:hover {
            background-color: #2980b9;
        }
        
        .error-message {
            background-color: #fee;
            color: #e74c3c;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
        
        .success-message {
            background-color: #e8f8f5;
            color: #27ae60;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="main-content">
            <div class="form-container">
                <div class="form-header">
                    <h2>Create New Admin</h2>
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <% if (request.getAttribute("success") != null) { %>
                    <div class="success-message">
                        <%= request.getAttribute("success") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/admin/create" method="post">
                    <div class="form-group">
                        <label for="adminId">Admin ID</label>
                        <input type="number" id="adminId" name="adminId" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="adminName">Name</label>
                        <input type="text" id="adminName" name="adminName" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="adminEmail">Email</label>
                        <input type="email" id="adminEmail" name="adminEmail" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="accessLevel">Access Level</label>
                        <select id="accessLevel" name="accessLevel" required>
                            <option value="">Select Access Level</option>
                            <option value="ADMIN">Admin</option>
                            <option value="MANAGER">Manager</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="submit-btn">Create Admin</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 