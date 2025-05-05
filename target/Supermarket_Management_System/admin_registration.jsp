<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Registration - Supermart</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f5f5f5;
        }
        
        .registration-container {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        
        .registration-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .registration-header h1 {
            color: #2c3e50;
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
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
            width: 100%;
            padding: 1rem;
            background-color: #3498db;
            color: white;
            border: none;
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
            display: none;
        }
        
        .back-link {
            display: block;
            text-align: center;
            margin-top: 1rem;
            color: #7f8c8d;
            text-decoration: none;
        }
        
        .back-link:hover {
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <div class="registration-header">
            <h1>Admin Registration</h1>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message" style="display: block;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="admin/register" method="post">
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
                    <option value="SUPER_ADMIN">Super Admin</option>
                    <option value="ADMIN">Admin</option>
                    <option value="MANAGER">Manager</option>
                </select>
            </div>
            
            <button type="submit" class="submit-btn">Register Admin</button>
        </form>
        
        <a href="admin_login.jsp" class="back-link">Back to Login</a>
    </div>
</body>
</html> 