<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Supermarket Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="nav-brand">SuperMart</a>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
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
            <a href="login.jsp" class="btn btn-primary">Login</a>
            <a href="profile.jsp" class="btn btn-primary">Profile</a>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            <div class="profile-card">
                <div class="profile-header">
                    <h2>User Profile</h2>
                </div>
                <div class="form-group">
                    <label>Full Name</label>
                    <p>John Doe</p>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <p>john.doe@example.com</p>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <p>123 Main Street, City, Country</p>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <p>+1 234 567 8900</p>
                </div>
            </div>

            <div class="profile-card">
                <div class="profile-header">
                    <h2>Recent Orders</h2>
                </div>
                <div class="product-grid">
                    <div class="product-card">
                        <img src="https://via.placeholder.com/300x200" alt="Order" class="product-image">
                        <div class="product-info">
                            <h3>Order #12345</h3>
                            <p>Placed on: 2024-01-20</p>
                            <p>Status: Delivered</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html> 