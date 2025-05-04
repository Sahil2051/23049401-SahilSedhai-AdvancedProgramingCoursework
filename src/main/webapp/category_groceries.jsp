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
    <title>Groceries - SuperMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        
        body {
            background-color: #f8f9fa;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem 2rem;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            height: 70px;
        }

        .nav-brand {
            color: #4f46e5;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            text-decoration: none;
            color: #4b5563;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.2s;
            padding: 0.5rem 0;
            position: relative;
        }

        .nav-links a:hover {
            color: #4f46e5;
        }

        .nav-links a:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #4f46e5;
            transition: width 0.2s ease-in-out;
        }

        .nav-links a:hover:after {
            width: 100%;
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .search-box {
            position: relative;
            width: 200px;
        }

        .search-input {
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            width: 100%;
            background-color: #f3f4f6;
            font-size: 0.875rem;
        }

        .search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
            pointer-events: none;
        }

        .cart-btn {
            position: relative;
            width: 40px;
            height: 40px;
            border-radius: 20px;
            background: white;
            border: 1px solid #e5e7eb;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .cart-btn:hover {
            background: #4f46e5;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.1);
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ef4444;
            color: white;
            font-size: 0.75rem;
            font-weight: 600;
            width: 20px;
            height: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            font-size: 0.875rem;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            white-space: nowrap;
        }

        .btn-primary {
            background-color: #4f46e5;
            color: white;
            text-decoration: none;
        }

        .btn-outline {
            background-color: transparent;
            border: 1px solid #e5e7eb;
            color: #4b5563;
        }

        .main-content {
            padding: 8rem 4rem 4rem;
            min-height: 100vh;
        }

        .category-header {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeIn 0.5s ease-out;
        }

        .category-header h1 {
            color: #4f46e5;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
            animation: fadeIn 0.5s ease-out;
        }

        .category-header p {
            color: #6b7280;
            font-size: 1.1rem;
            animation: fadeIn 0.5s ease-out;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            padding: 1rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            transition: all 0.3s;
            border: 1px solid #e5e7eb;
            height: 100%;
            display: flex;
            flex-direction: column;
            cursor: pointer;
            text-decoration: none;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        .product-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }

        .product-info {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-info h3 {
            color: #111827;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .product-info p {
            color: #6b7280;
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .price {
            font-weight: 600;
            color: #4f46e5;
            font-size: 1.2rem;
            margin-top: auto;
            padding-top: 1rem;
        }

        .product-actions {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            margin-top: 1rem;
            justify-content: center;
        }

        .add-to-cart-btn {
            background-color: #4f46e5;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s;
            flex: 1;
            max-width: 200px;
        }

        .wishlist-btn {
            background-color: transparent;
            border: 1px solid #e5e7eb;
            padding: 0.75rem;
            border-radius: 0.375rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            width: 48px;
            height: 48px;
        }

        .cart-notification {
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            z-index: 50;
            min-width: 300px;
            display: none;
        }

        .notification-title {
            font-size: 1rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 0.5rem;
        }

        .notification-content {
            color: #6b7280;
            margin-bottom: 1rem;
        }

        .notification-buttons {
            display: flex;
            gap: 1rem;
        }

        .view-cart-btn {
            padding: 0.5rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            color: #374151;
            text-decoration: none;
            font-weight: 500;
        }

        .checkout-btn {
            padding: 0.5rem 1rem;
            background: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.375rem;
            text-decoration: none;
            font-weight: 500;
        }

        .footer {
            background: #f8fafc;
            padding: 5rem 0 2rem;
            margin-top: 6rem;
            position: relative;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, #e5e7eb, transparent);
        }

        .footer .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .footer-content {
            display: grid;
            grid-template-columns: 1.5fr 1fr 1fr;
            gap: 4rem;
            margin-bottom: 4rem;
        }

        .footer-section h3 {
            color: #1f2937;
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            letter-spacing: -0.025em;
        }

        .footer-section p {
            color: #4b5563;
            font-size: 0.9375rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .footer-section ul {
            list-style: none;
            padding: 0;
        }

        .footer-section ul li {
            margin-bottom: 0.75rem;
        }

        .footer-section ul li a {
            color: #4b5563;
            text-decoration: none;
            font-size: 0.9375rem;
            transition: all 0.2s ease;
            display: inline-block;
        }

        .footer-section ul li a:hover {
            color: #4f46e5;
            transform: translateX(4px);
        }

        .footer-extra {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 2rem 0;
            border-top: 1px solid #e5e7eb;
        }

        .social-links {
            display: flex;
            gap: 1rem;
        }

        .social-links a {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4b5563;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .social-links a:hover {
            background: #4f46e5;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.1);
        }

        .payment-methods {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .payment-methods span {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .payment-icons {
            display: flex;
            gap: 1rem;
        }

        .payment-icons img {
            height: 24px;
            opacity: 0.7;
            transition: opacity 0.2s ease;
        }

        .payment-icons img:hover {
            opacity: 1;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }

        .footer-bottom p {
            color: #6b7280;
            font-size: 0.875rem;
            margin: 0;
        }

        .footer-bottom p span {
            color: #4f46e5;
            font-weight: 600;
        }

        @keyframes fadeIn {
            from { 
                opacity: 0; 
                transform: translateY(20px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }
    </style>
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
                <span class="search-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="11" cy="11" r="8"></circle>
                        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                    </svg>
                </span>
                <input type="text" class="search-input" placeholder="Search Products...">
            </div>
            <a href="cart.jsp" class="cart-btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="9" cy="21" r="1"></circle>
                    <circle cx="20" cy="21" r="1"></circle>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                </svg>
                <span class="cart-count">3</span>
            </a>
            <div class="user-actions">
                <% if (isGuest) { %>
                    <a href="login.jsp" class="btn btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                            <polyline points="10 17 15 12 10 7"></polyline>
                            <line x1="15" y1="12" x2="3" y2="12"></line>
                        </svg>
                        Login
                    </a>
                <% } else { %>
                    <a href="profile.jsp" class="btn btn-outline">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        Profile
                    </a>
                    <a href="logout" class="btn btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                        Logout
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <main class="main-content">
        <div class="category-header">
            <h1>Fresh Groceries</h1>
            <p>Quality fresh produce and pantry essentials</p>
        </div>

        <div class="product-grid">
            <div class="product-card">
                <img src="https://imgs.search.brave.com/vvWlrQ31TEOKE4a0taMqqC5sY_Gvu-BaAPI_qIfp410/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/LmhhcnJ5YW5kZGF2/aWQuY29tL3djc3N0/b3JlL0hhcnJ5QW5k/RGF2aWQvaW1hZ2Vz/L2NhdGFsb2cvMjNf/MDAyNDQ5NV8zMFdf/MTM5XzAyOXguanBn/P2hlaWdodD00NTYm/d2lkdGg9NDE4JnNo/YXJwZW49YTAuNSxy/MSx0MSZhdXRvPXdl/YnA" alt="Fresh Fruits" class="product-image">
                <div class="product-info">
                    <h3>Fresh Fruit Basket</h3>
                    <p>Assorted seasonal fruits, hand-picked for quality</p>
                    <div class="price">$24.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Fresh Fruit Basket', 24.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Fresh Fruit Basket', 24.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/gv3qrqaN1uJJ0oSjWbW9lYGbZFYR96y7RI0GtgjMNug/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/Z2FybGljYW5kemVz/dC5jb20vd3AtY29u/dGVudC91cGxvYWRz/LzIwMjIvMDgvdmVn/ZXRhYmxlLW1lZGxl/eS02ODF4MTAyNC5q/cGc" alt="Fresh Vegetables" class="product-image">
                <div class="product-info">
                    <h3>Vegetable Mix</h3>
                    <p>Farm-fresh vegetables for your daily needs</p>
                    <div class="price">$19.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Vegetable Mix', 19.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Vegetable Mix', 19.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/tflmkUnhd9W951dwWjhTNVkGYh965X9AXoFFl7c4FrY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNjM5/MzYxNzM4L3Bob3Rv/LzktZ3JhaW4tYXJ0/aXNhbi1icmVhZC1s/b2FmLmpwZz9zPTYx/Mng2MTImdz0wJms9/MjAmYz1LT3F6SEhN/N2xucno5RV9ZVUxr/VnpaNld5NFlpSUtr/UHd5dWJVZHl6VEln/PQ" alt="Fresh Bread" class="product-image">
                <div class="product-info">
                    <h3>Artisan Bread</h3>
                    <p>Freshly baked artisan bread</p>
                    <div class="price">$5.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Artisan Bread', 5.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Artisan Bread', 5.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/j6cz_EWevXvl-aO0srRwgBd6bOjpZwWernCcghjQCPk/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTAz/OTQ5MDc4Mi9waG90/by9taWxrLXRldHJh/LXBhY2suanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPVZ5Slo3/SlkweUVEYllnczZw/ZDYtRE9ZOWo5Y29y/MWFqWm1vd1cxYVI0/MEk9" alt="Dairy Products" class="product-image">
                <div class="product-info">
                    <h3>Milk</h3>
                    <p>Fresh milk.</p>
                    <div class="price">$15.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Milk', 15.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Milk', 15.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/7KoimawPkldeDq6ZeS2vw8iaSHuMEk_a5hv-wpzp8WY/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMtbmEuc3NsLWlt/YWdlcy1hbWF6b24u/Y29tL2ltYWdlcy9J/LzgxWUtkZ09GTDBM/LmpwZw" alt="Fresh Meat" class="product-image">
                <div class="product-info">
                    <h3>Premium Meat Cuts</h3>
                    <p>Quality meat selections for your recipes</p>
                    <div class="price">$29.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Premium Meat Cuts', 29.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Premium Meat Cuts', 29.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/-rxJ5UFIA417IbplZCrR3Fq14LT4LWY77jGoApC5hns/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zbmFx/YXJ5LmNvbS9jZG4v/c2hvcC9maWxlcy9B/cnRib2FyZDFfYjFj/YmZhNWQtODkzNi00/ZmRmLWE4MTUtYzc5/NGUyYjk1NjQzLmpw/Zz92PTE2ODg2MjUy/NjQmd2lkdGg9MTAw/MA" alt="Snacks" class="product-image">
                <div class="product-info">
                    <h3>Snacks</h3>
                    <p>Nutritious and delicious snack options</p>
                    <div class="price">$12.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Snacks', 12.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Snacks', 12.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="footer.jsp" %>

    <!-- Cart Notification -->
    <div id="cartNotification" class="cart-notification">
        <div class="notification-title">Item Added To Cart</div>
        <div class="notification-content">
            <span id="notificationProductName"></span><br>
            Price: $<span id="notificationProductPrice"></span>
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>

    <script>
        function showNotification(productName, price) {
            const notification = document.getElementById('cartNotification');
            document.getElementById('notificationProductName').textContent = productName;
            document.getElementById('notificationProductPrice').textContent = price;
            notification.style.display = 'block';
            
            setTimeout(() => {
                notification.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html> 