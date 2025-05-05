<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.supermarket.model.User" %>
<%@ page import="com.supermarket.model.Cart" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart(user.getId());
        session.setAttribute("cart", cart);
    }
    
    int cartCount = cart.getItemCount();
    int orderCount = 0; // TODO: Implement order functionality
    double totalSpent = 0.0; // TODO: Implement order functionality
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - SuperMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            text-decoration: none;
        }

        .btn-primary {
            background-color: #4f46e5;
            color: white;
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .profile-layout {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 2rem;
        }

        .profile-sidebar {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            border: 1px solid #e5e7eb;
            height: fit-content;
        }

        .profile-nav {
            list-style: none;
            padding: 0;
        }

        .profile-nav li {
            margin-bottom: 0.5rem;
        }

        .profile-nav a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            color: #4b5563;
            text-decoration: none;
            border-radius: 0.5rem;
            transition: all 0.2s;
        }

        .profile-nav a:hover {
            background: #f3f4f6;
            color: #4f46e5;
        }

        .profile-nav a.active {
            background: #4f46e5;
            color: white;
        }

        .profile-content {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            border: 1px solid #e5e7eb;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #4f46e5;
            font-size: 2.5rem;
            font-weight: 600;
        }

        .profile-info h2 {
            color: #111827;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .profile-info p {
            color: #6b7280;
            font-size: 0.95rem;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 600;
            color: #4f46e5;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .section-title {
            color: #111827;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .order-list {
            display: grid;
            gap: 1rem;
        }

        .order-card {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 1.5rem;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .order-id {
            font-weight: 600;
            color: #111827;
        }

        .order-status {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .status-delivered {
            background: #dcfce7;
            color: #166534;
        }

        .status-processing {
            background: #fef3c7;
            color: #92400e;
        }

        .order-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            color: #6b7280;
            font-size: 0.875rem;
        }

        .detail-label {
            font-weight: 500;
            color: #4b5563;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .wishlist-item {
            background: #f8fafc;
            border-radius: 0.75rem;
            overflow: hidden;
            border: 1px solid #e5e7eb;
        }

        .wishlist-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .wishlist-info {
            padding: 1rem;
        }

        .wishlist-info h3 {
            color: #111827;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .wishlist-price {
            color: #4f46e5;
            font-weight: 600;
            font-size: 1rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
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
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .order-items {
            margin-top: 1rem;
            border-top: 1px solid #e5e7eb;
            padding-top: 1rem;
        }

        .order-item {
            display: flex;
            gap: 1rem;
            padding: 0.75rem;
            background: white;
            border-radius: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .order-item:last-child {
            margin-bottom: 0;
        }

        .order-item-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 0.375rem;
        }

        .order-item-info {
            flex: 1;
        }

        .order-item-info h4 {
            color: #111827;
            font-size: 0.95rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .order-item-info p {
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
        }

        .order-item-price {
            color: #4f46e5;
            font-weight: 500;
        }

        .profile-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .profile-info {
            margin-bottom: 20px;
        }
        .edit-form {
            display: none;
            margin-top: 20px;
        }
        .edit-form.active {
            display: block;
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
                <% if (user.getId() == 0) { %>
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
        <div class="container">
            <div class="profile-layout">
                <div class="profile-sidebar">
                    <ul class="profile-nav">
                        <li><a href="#overview" class="active">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                <polyline points="9 22 9 12 15 12 15 22"></polyline>
                            </svg>
                            Overview
                        </a></li>
                        <li><a href="#orders">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                <line x1="8" y1="21" x2="16" y2="21"></line>
                                <line x1="12" y1="17" x2="12" y2="21"></line>
                            </svg>
                            Orders
                        </a></li>
                        <li><a href="#wishlist">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                            Wishlist
                        </a></li>
                        <li><a href="#edit">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                            </svg>
                            Edit
                        </a></li>
                    </ul>
                </div>

                <div class="profile-content">
                    <div id="overview">
                        <div class="profile-header">
                            <div class="profile-avatar">JD</div>
                            <div class="profile-info">
                                <h2><%= user.getUsername() %></h2>
                                <p><%= user.getEmail() %></p>
                            </div>
                        </div>

                        <div class="profile-stats">
                            <div class="stat-card">
                                <div class="stat-value"><%= orderCount %></div>
                                <div class="stat-label">Total Orders</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-value"><%= cartCount %></div>
                                <div class="stat-label">Cart Items</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-value">$<%= String.format("%.2f", totalSpent) %></div>
                                <div class="stat-label">Total Spent</div>
                            </div>
                        </div>

                        <h3 class="section-title">Recent Orders</h3>
                        <div class="order-list">
                            <div class="order-card">
                                <div class="order-header">
                                    <span class="order-id">Order #12345</span>
                                    <span class="order-status status-delivered">Delivered</span>
                                </div>
                                <div class="order-details">
                                    <div>
                                        <span class="detail-label">Date</span><br>
                                        March 15, 2024
                                    </div>
                                    <div>
                                        <span class="detail-label">Total</span><br>
                                        $199.99
                                    </div>
                                    <div>
                                        <span class="detail-label">Items</span><br>
                                        3 items
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="orders" style="display: none;">
                        <h3 class="section-title">Order History</h3>
                        <div class="order-list">
                            <div class="order-card">
                                <div class="order-header">
                                    <span class="order-id">Order #12345</span>
                                    <span class="order-status status-delivered">Delivered</span>
                                </div>
                                <div class="order-details">
                                    <div class="order-detail">
                                        <strong>Date</strong>
                                        <span>March 15, 2024</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Total</strong>
                                        <span>$199.99</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Items</strong>
                                        <span>3 items</span>
                                    </div>
                                </div>
                                <div class="order-items">
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Premium Notebook</h4>
                                            <p>Quantity: 2</p>
                                            <p class="order-item-price">$12.99 each</p>
                                        </div>
                                    </div>
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/JGaObmib5LQEPd5rGhXn-Zm4tLh-Sju7lEzifd09sDw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/ODFySm5KMk1Fbkwu/anBn" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Gel Pen Set</h4>
                                            <p>Quantity: 1</p>
                                            <p class="order-item-price">$4.99 each</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-card">
                                <div class="order-header">
                                    <span class="order-id">Order #12344</span>
                                    <span class="order-status status-processing">Processing</span>
                                </div>
                                <div class="order-details">
                                    <div class="order-detail">
                                        <strong>Date</strong>
                                        <span>March 10, 2024</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Total</strong>
                                        <span>$149.99</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Items</strong>
                                        <span>2 items</span>
                                    </div>
                                </div>
                                <div class="order-items">
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/eYMVDHVLTE1otkMhpCqzE2S_OJj1XecJ5LuD_R5J2wo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YW5uYWJyZWdtYW5w/b3J0cmFpdHMuY28u/dWsvd3AtY29udGVu/dC91cGxvYWRzLzIw/MTQvMDgvQVJUSUNM/RVMtcGVuY2lsLXJl/dmlld3MtRmFiZXIt/Q2FzdGVsbDMuanBn" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Drawing Pencil Set</h4>
                                            <p>Quantity: 1</p>
                                            <p class="order-item-price">$14.99 each</p>
                                        </div>
                                    </div>
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/C__9T5MZx9UQbHZcrBcz2I_XF76nwdv-JB_WdyklNe0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zaG9w/LmdoZW50LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyNC8w/My9naGVudC1lcmFz/ZXItbWFya2VyLWNv/bWJvLWFuZ2xlLXZh/cmlldHktMTUwMHgx/NTAwLTEuanBn" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Whiteboard Markers</h4>
                                            <p>Quantity: 1</p>
                                            <p class="order-item-price">$8.99 each</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-card">
                                <div class="order-header">
                                    <span class="order-id">Order #12343</span>
                                    <span class="order-status status-delivered">Delivered</span>
                                </div>
                                <div class="order-details">
                                    <div class="order-detail">
                                        <strong>Date</strong>
                                        <span>March 5, 2024</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Total</strong>
                                        <span>$89.99</span>
                                    </div>
                                    <div class="order-detail">
                                        <strong>Items</strong>
                                        <span>2 items</span>
                                    </div>
                                </div>
                                <div class="order-items">
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/r5sZRGU6LkFkf8-Ev5TgEisGu36un294vc7s7whUSTY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YW5uYWJyZWdtYW5w/b3J0cmFpdHMuY28u/dWsvd3AtY29udGVu/dC91cGxvYWRzLzIw/MTQvMDgvQVJUSUNM/RVMtcGVuY2lsLXJl/dmlld3MtRmFiZXIt/Q2FzdGVsbDMuanBn" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Drawing Pencil Set</h4>
                                            <p>Quantity: 1</p>
                                            <p class="order-item-price">$14.99 each</p>
                                        </div>
                                    </div>
                                    <div class="order-item">
                                        <img src="https://imgs.search.brave.com/C__9T5MZx9UQbHZcrBcz2I_XF76nwdv-JB_WdyklNe0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zaG9w/LmdoZW50LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyNC8w/My9naGVudC1lcmFz/ZXItbWFya2VyLWNv/bWJvLWFuZ2xlLXZh/cmlldHktMTUwMHgx/NTAwLTEuanBn" alt="Product" class="order-item-image">
                                        <div class="order-item-info">
                                            <h4>Whiteboard Markers</h4>
                                            <p>Quantity: 1</p>
                                            <p class="order-item-price">$8.99 each</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="wishlist" style="display: none;">
                        <h3 class="section-title">My Wishlist</h3>
                        <div class="wishlist-grid">
                            <div class="wishlist-item">
                                <img src="https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw" alt="Product" class="wishlist-image">
                                <div class="wishlist-info">
                                    <h3>Premium Notebook</h3>
                                    <div class="wishlist-price">$12.99</div>
                                </div>
                            </div>
                            <!-- More wishlist items will be dynamically loaded here -->
                        </div>
                    </div>

                    <div id="edit" style="display: none;">
                        <h3 class="section-title">Edit Profile</h3>
                        <form action="update-profile" method="POST">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" class="form-control" id="username" name="username" value="<%= user.getUsername() %>" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="tel" class="form-control" id="phone" name="phone" value="<%= user.getPhone() %>">
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea class="form-control" rows="3"><%= user.getAddress() %></textarea>
                            </div>
                            <div class="btn-group">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-outline">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="footer.jsp" %>

    <script>
        // Tab switching functionality
        document.querySelectorAll('.profile-nav a').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const targetId = link.getAttribute('href').substring(1);
                
                // Hide all sections
                document.querySelectorAll('.profile-content > div').forEach(section => {
                    section.style.display = 'none';
                });
                
                // Show target section
                document.getElementById(targetId).style.display = 'block';
                
                // Update active state
                document.querySelectorAll('.profile-nav a').forEach(navLink => {
                    navLink.classList.remove('active');
                });
                link.classList.add('active');
            });
        });
    </script>
</body>
</html> 