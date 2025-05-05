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
    <title>Product Details - SuperMart</title>
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

        .product-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            margin-bottom: 4rem;
        }

        .product-gallery {
            position: relative;
        }

        .main-image {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 1rem;
            margin-bottom: 1rem;
        }

        .thumbnail-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }

        .thumbnail {
            width: 100%;
            height: 100px;
            object-fit: cover;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .thumbnail:hover {
            transform: scale(1.05);
        }

        .product-info {
            padding: 2rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            border: 1px solid #e5e7eb;
        }

        .product-title {
            color: #111827;
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .product-price {
            color: #4f46e5;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .product-description {
            color: #6b7280;
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .product-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .meta-item svg {
            color: #4f46e5;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .quantity-btn {
            width: 40px;
            height: 40px;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            background: white;
            color: #4b5563;
            font-size: 1.25rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quantity-btn:hover {
            background: #f3f4f6;
            color: #4f46e5;
        }

        .quantity-input {
            width: 60px;
            height: 40px;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            text-align: center;
            font-size: 1rem;
            font-weight: 500;
        }

        .add-to-cart-btn {
            width: 100%;
            padding: 1rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .add-to-cart-btn:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
        }

        .related-products {
            margin-top: 4rem;
        }

        .section-title {
            color: #111827;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 2rem;
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
        }

        .related-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            transition: all 0.3s;
            border: 1px solid #e5e7eb;
        }

        .related-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
        }

        .related-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .related-info {
            padding: 1.5rem;
        }

        .related-info h3 {
            color: #111827;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .related-price {
            color: #4f46e5;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .cart-notification {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            z-index: 50;
            min-width: 300px;
            display: none;
            animation: fadeIn 0.3s ease-out;
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
                transform: translate(-50%, -40%);
            }
            to {
                opacity: 1;
                transform: translate(-50%, -50%);
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
        <div class="container">
            <div class="product-details">
                <div class="product-gallery">
                    <img src="https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw" alt="Rice 5kg" class="main-image">
                    <div class="thumbnail-grid">
                        <img src="https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw" alt="Thumbnail 1" class="thumbnail">
                        <img src="https://imgs.search.brave.com/JGaObmib5LQEPd5rGhXn-Zm4tLh-Sju7lEzifd09sDw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/ODFySm5KMk1Fbkwu/anBn" alt="Thumbnail 2" class="thumbnail">
                        <img src="https://imgs.search.brave.com/eYMVDHVLTE1otkMhpCqzE2S_OJj1XecJ5LuD_R5J2wo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFyemdCOWdJWEwu/anBn" alt="Thumbnail 3" class="thumbnail">
                        <img src="https://imgs.search.brave.com/HHiFrKbwWB9ye0fzswdYCrqATZePowZUaI0hZPC95UY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZS5tYWRlLWluLWNo/aW5hLmNvbS8xNTVm/MGowMHNvR2JPdWZx/blNrZy9BNC1QYXBl/ci1Db3BpZXItNTAw/LVNoZWV0cy1SZWFt/LTUtUmVhbXMtQm94/LUE0LUNvcHktUGFw/ZXIud2VicA" alt="Thumbnail 4" class="thumbnail">
                    </div>
                </div>

                <div class="product-info">
                    <h1 class="product-title">Rice 5kg</h1>
                    <div class="product-price">$29.99</div>
                    <p class="product-description">
                        High-quality long-grain rice, perfect for everyday cooking. This 5kg bag provides excellent value and maintains freshness with its sealed packaging.
                    </p>
                    <div class="product-meta">
                        <div class="meta-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                            <span>In Stock</span>
                        </div>
                        <div class="meta-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                            <span>Free Shipping</span>
                        </div>
                        <div class="meta-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 20h9"></path>
                                <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                            </svg>
                            <span>5kg Bag</span>
                        </div>
                        <div class="meta-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="3" y1="9" x2="21" y2="9"></line>
                                <line x1="9" y1="21" x2="9" y2="9"></line>
                            </svg>
                            <span>Expires: 2024-12-31</span>
                        </div>
                    </div>
                    <div class="quantity-selector">
                        <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
                        <input type="number" class="quantity-input" value="1" min="1" max="10" id="quantity">
                        <button class="quantity-btn" onclick="increaseQuantity()">+</button>
                    </div>
                    <div class="product-actions">
                        <% if (user != null && user.getId() != 0) { %>
                    <button class="add-to-cart-btn" onclick="addToCart()">
                                <i class="fas fa-shopping-cart"></i>
                        Add to Cart
                    </button>
                        <% } else { %>
                            <a href="login.jsp" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt"></i>
                                Login to Add to Cart
                            </a>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="related-products">
                <h2 class="section-title">You May Also Like</h2>
                <div class="related-grid">
                    <div class="related-card">
                        <img src="https://imgs.search.brave.com/JGaObmib5LQEPd5rGhXn-Zm4tLh-Sju7lEzifd09sDw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/ODFySm5KMk1Fbkwu/anBn" alt="Gel Pen Set" class="related-image">
                        <div class="related-info">
                            <h3>Gel Pen Set</h3>
                            <div class="related-price">$4.99</div>
                        </div>
                    </div>
                    <div class="related-card">
                        <img src="https://imgs.search.brave.com/eYMVDHVLTE1otkMhpCqzE2S_OJj1XecJ5LuD_R5J2wo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFyemdCOWdJWEwu/anBn" alt="Heavy Duty Stapler" class="related-image">
                        <div class="related-info">
                            <h3>Heavy Duty Stapler</h3>
                            <div class="related-price">$12.99</div>
                        </div>
                    </div>
                    <div class="related-card">
                        <img src="https://imgs.search.brave.com/HHiFrKbwWB9ye0fzswdYCrqATZePowZUaI0hZPC95UY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZS5tYWRlLWluLWNo/aW5hLmNvbS8xNTVm/MGowMHNvR2JPdWZx/blNrZy9BNC1QYXBl/ci1Db3BpZXItNTAw/LVNoZWV0cy1SZWFt/LTUtUmVhbXMtQm94/LUE0LUNvcHktUGFw/ZXIud2VicA" alt="A4 Paper Ream" class="related-image">
                        <div class="related-info">
                            <h3>A4 Paper Ream</h3>
                            <div class="related-price">$6.99</div>
                        </div>
                    </div>
                    <div class="related-card">
                        <img src="https://imgs.search.brave.com/r5sZRGU6LkFkf8-Ev5TgEisGu36un294vc7s7whUSTY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YW5uYWJyZWdtYW5w/b3J0cmFpdHMuY28u/dWsvd3AtY29udGVu/dC91cGxvYWRzLzIw/MTQvMDgvQVJUSUNM/RVMtcGVuY2lsLXJl/dmlld3MtRmFiZXIt/Q2FzdGVsbDMuanBn" alt="Drawing Pencil Set" class="related-image">
                        <div class="related-info">
                            <h3>Drawing Pencil Set</h3>
                            <div class="related-price">$14.99</div>
                        </div>
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
            Quantity: <span id="notificationQuantity"></span><br>
            Price: $<span id="notificationProductPrice"></span>
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>

    <script>
        function decreaseQuantity() {
            const input = document.getElementById('quantity');
            if (input.value > 1) {
                input.value = parseInt(input.value) - 1;
            }
        }

        function increaseQuantity() {
            const input = document.getElementById('quantity');
            if (input.value < 10) {
                input.value = parseInt(input.value) + 1;
            }
        }

        function showNotification(productId, productName, price, imageUrl) {
            // Make AJAX request to add item to cart
            fetch('/Supermarket_Management_System_war_exploded/cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'productId': productId,
                    'productName': productName,
                    'price': price,
                    'quantity': document.getElementById('quantity').value,
                    'imageUrl': imageUrl || ''
                })
            })
            .then(response => response.json())
            .then(data => {
                const notification = document.getElementById('cartNotification');
                document.getElementById('notificationProductName').textContent = productName;
                document.getElementById('notificationQuantity').textContent = document.getElementById('quantity').value;
                document.getElementById('notificationProductPrice').textContent = (price * document.getElementById('quantity').value).toFixed(2);
                
                if (data.success) {
                    notification.classList.remove('error');
                    // Update cart count
                    fetch('/Supermarket_Management_System_war_exploded/cart/count')
                        .then(response => response.json())
                        .then(data => {
                            document.querySelector('.cart-count').textContent = data.itemCount;
                        })
                        .catch(error => console.error('Error updating cart count:', error));
                } else {
                    notification.classList.add('error');
                    document.getElementById('notificationProductName').textContent = 'Error';
                    document.getElementById('notificationProductPrice').textContent = data.message;
                }
                
                notification.style.display = 'block';
                setTimeout(() => {
                    notification.style.display = 'none';
                    notification.classList.remove('error');
                }, 3000);
            })
            .catch(error => {
                console.error('Error:', error);
                const notification = document.getElementById('cartNotification');
                notification.classList.add('error');
                document.getElementById('notificationProductName').textContent = 'Error';
                document.getElementById('notificationProductPrice').textContent = 'Failed to add item to cart';
                notification.style.display = 'block';
                setTimeout(() => {
                    notification.style.display = 'none';
                    notification.classList.remove('error');
                }, 3000);
            });
        }

        function addToCart() {
            const quantity = document.getElementById('quantity').value;
            const productId = 1; // Rice 5kg
            const productName = 'Rice 5kg';
            const price = 29.99;
            const imageUrl = document.querySelector('.main-image').src;
            showNotification(productId, productName, price, imageUrl);
        }

        // Thumbnail click functionality
        document.querySelectorAll('.thumbnail').forEach(thumb => {
            thumb.addEventListener('click', () => {
                document.querySelector('.main-image').src = thumb.src;
            });
        });
    </script>
</body>
</html> 