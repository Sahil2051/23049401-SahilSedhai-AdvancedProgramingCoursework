<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.supermarket.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isGuest = user != null && user.getId() == 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supermarket Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="nav-brand">SuperMart</a>
        <ul class="nav-links">
            <li><a href="dashboard.jsp">Home</a></li>
            <li><a href="category_stationary.jsp">Stationary & Office</a></li>
            <li><a href="category_groceries.jsp">Groceries</a></li>
            <li><a href="category_household.jsp">Household Supplies</a></li>
            <li><a href="category_electronics.jsp">Electronics & Appliance</a></li>
        </ul>
        <div class="nav-right">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search products...">
                <button class="btn btn-primary">Search</button>
            </div>
            <% if (isGuest) { %>
                <a href="register.jsp" class="btn btn-primary">Sign Up</a>
                <a href="login.jsp" class="btn btn-primary">Login</a>
            <% } else { %>
                <a href="profile.jsp" class="btn btn-primary">Profile</a>
                <a href="logout" class="btn btn-primary">Logout</a>
            <% } %>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            <section class="welcome-section">
                <h1>Welcome to Supermarket Management System</h1>
                <p>Your one-stop shop for all your daily needs</p>
                <% if (isGuest) { %>
                    <p class="guest-notice">You are browsing as a guest. Sign up to save your preferences and access more features!</p>
                <% } %>
            </section>

            <div class="product-grid">
                <!-- Featured Products -->
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Product" class="product-image">
                    <div class="product-info">
                        <h3>Featured Product 1</h3>
                        <p>Description of the product goes here</p>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Product" class="product-image">
                    <div class="product-info">
                        <h3>Featured Product 2</h3>
                        <p>Description of the product goes here</p>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Product" class="product-image">
                    <div class="product-info">
                        <h3>Featured Product 3</h3>
                        <p>Description of the product goes here</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html> 