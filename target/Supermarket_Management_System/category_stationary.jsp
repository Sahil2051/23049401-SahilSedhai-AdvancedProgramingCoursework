<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stationary & Office - Supermarket Management System</title>
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
            <div class="category-header">
                <h1>Stationary & Office Supplies</h1>
                <p>Find all your office and school supplies here</p>
            </div>

            <div class="product-grid">
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Notebooks" class="product-image">
                    <div class="product-info">
                        <h3>Premium Notebooks</h3>
                        <p>High-quality notebooks for all your writing needs</p>
                        <p class="price">$9.99</p>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Pens" class="product-image">
                    <div class="product-info">
                        <h3>Gel Pen Set</h3>
                        <p>Smooth writing gel pens in various colors</p>
                        <p class="price">$4.99</p>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Staplers" class="product-image">
                    <div class="product-info">
                        <h3>Heavy Duty Stapler</h3>
                        <p>Reliable stapler for office use</p>
                        <p class="price">$12.99</p>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200" alt="Paper" class="product-image">
                    <div class="product-info">
                        <h3>A4 Paper Ream</h3>
                        <p>500 sheets of high-quality printing paper</p>
                        <p class="price">$6.99</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html> 