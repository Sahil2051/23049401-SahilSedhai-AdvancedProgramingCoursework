<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electronics & Appliances - Supermarket Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header class="top-header">
        <div class="top-header-content">
            <div class="auth-links">
                <a href="profile.jsp">Profile</a>
                <a href="login.jsp">Login</a>
            </div>
        </div>
    </header>

    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="category_stationary.jsp">Stationary & Office</a>
                <a href="category_groceries.jsp">Groceries</a>
                <a href="category_household.jsp">Household Supplies</a>
                <a href="category_electronics.jsp">Electronics & Appliance</a>
            </div>
            <div class="search-container">
                <input type="text" placeholder="Search in Electronics & Appliances..." aria-label="Search">
            </div>
        </div>
    </nav>

    <div class="main-content">
        <div class="category-header">
            <h1>Electronics & Appliances</h1>
        </div>

        <div class="product-grid">
            <!-- Placeholder for product listings -->
            <div style="text-align: center; padding: 2rem; background: #fff; border-radius: 10px;">
                <h3>Product listings will be displayed here</h3>
                <p>This section will be populated with actual product data from the backend</p>
            </div>
        </div>
    </div>
</body>
</html> 