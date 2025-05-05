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
    <title>SuperMart - Your Daily Needs</title>
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
            font-size: 1rem;
            transition: all 0.2s;
            padding: 0.5rem 0;
            position: relative;
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

        .nav-links a:hover {
            color: #4f46e5;
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

        .btn-primary:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        .btn-outline:hover {
            border-color: #4f46e5;
            color: #4f46e5;
            background-color: #f8fafc;
        }

        .main-content {
            padding: 8rem 4rem 4rem;
            min-height: 100vh;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeIn 0.5s ease-out;
        }

        .welcome-section h1 {
            color: #4f46e5;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }

        .welcome-section p {
            color: #6b7280;
            font-size: 1.1rem;
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
            margin-top: 1rem;
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

        .wishlist-btn:hover {
            background-color: #f3f4f6;
            border-color: #4f46e5;
        }

        .wishlist-btn:hover svg {
            stroke: #4f46e5;
        }

        .cart-notification {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            z-index: 50;
            min-width: 300px;
            display: none;
            animation: slideIn 0.3s ease-out;
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

        .notification-product {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .notification-product img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #e5e7eb;
        }

        .notification-product-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .notification-product-name {
            font-weight: 500;
            color: #1f2937;
        }

        .notification-product-price {
            color: #4f46e5;
            font-weight: 600;
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
            transition: all 0.2s;
        }

        .view-cart-btn:hover {
            background-color: #f3f4f6;
            transform: translateY(-1px);
        }

        .checkout-btn {
            padding: 0.5rem 1rem;
            background: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.375rem;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
        }

        .checkout-btn:hover {
            background: #4338ca;
            transform: translateY(-1px);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(100%);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .cart-notification.error {
            border-left: 4px solid #dc2626;
        }

        .cart-notification.error .notification-title {
            color: #dc2626;
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

        @keyframes bounce {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
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
        <section class="welcome-section">
            <h1>Welcome to SuperMart</h1>
            <p>Your one-stop shop for all your daily needs</p>
        </section>

        <div class="product-grid">
            <div class="product-card">
                <img src="https://s1.kaercher-media.com/mam/16283780/mainproduct/188070/d0.jpg" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Premium Vacuum Cleaner</h3>
                    <p>High-performance vacuum with advanced filtration system</p>
                    <div class="price">$199.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(15, 'Premium Vacuum Cleaner', 199.99, 'https://s1.kaercher-media.com/mam/16283780/mainproduct/188070/d0.jpg')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Premium Vacuum Cleaner', 199.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://i5.walmartimages.com/seo/Robot-Vacuum-Cleaner-Strong-Suction-Slim-Robotic-Vacuum-Cleaner-Low-Noise-Smart-Vacuum-Robot-Sweeping-Home-Carpet-Cleaner-Hard-Floors-Robot-Sweeper-H_4534f5cf-43bb-434b-a0f2-37fcaa5c5dfc.4777d0e56e7c575769edd928102f8e28.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Smart Vacuum Robot</h3>
                    <p>Automated cleaning with smart navigation technology</p>
                    <div class="price">$299.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(16, 'Smart Vacuum Robot', 299.99, 'https://i5.walmartimages.com/seo/Robot-Vacuum-Cleaner-Strong-Suction-Slim-Robotic-Vacuum-Cleaner-Low-Noise-Smart-Vacuum-Robot-Sweeping-Home-Carpet-Cleaner-Hard-Floors-Robot-Sweeper-H_4534f5cf-43bb-434b-a0f2-37fcaa5c5dfc.4777d0e56e7c575769edd928102f8e28.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Smart Vacuum Robot', 299.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://cdn.thewirecutter.com/wp-content/media/2024/01/robotvacuums-2048px-mielerx3top.jpg?auto=webp&quality=75&width=1024" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Compact Vacuum</h3>
                    <p>Lightweight and powerful for everyday cleaning</p>
                    <div class="price">$149.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(17, 'Compact Vacuum', 149.99, 'https://cdn.thewirecutter.com/wp-content/media/2024/01/robotvacuums-2048px-mielerx3top.jpg?auto=webp&quality=75&width=1024')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Compact Vacuum', 149.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://s1.kaercher-media.com/media/image/selection/99368/m3/karcher-professional-robotic-vacuums.webp" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Professional Vacuum</h3>
                    <p>Industrial-grade cleaning performance</p>
                    <div class="price">$399.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(18, 'Professional Vacuum', 399.99, 'https://s1.kaercher-media.com/media/image/selection/99368/m3/karcher-professional-robotic-vacuums.webp')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Professional Vacuum', 399.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://images-cdn.ubuy.qa/67c17e7d344dd426892f3300-handheld-vacuum-cordless-portable-car.jpg" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Handheld Vacuum</h3>
                    <p>Perfect for quick cleanups and spot cleaning</p>
                    <div class="price">$79.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(19, 'Handheld Vacuum', 79.99, 'https://images-cdn.ubuy.qa/67c17e7d344dd426892f3300-handheld-vacuum-cordless-portable-car.jpg')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Handheld Vacuum', 79.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://s3-assets.sylvane.com/media/images/articles/wet-dry-vacuum-usage-sq.webp" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Wet/Dry Vacuum</h3>
                    <p>Versatile cleaning for all surfaces and conditions</p>
                    <div class="price">$249.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(20, 'Wet/Dry Vacuum', 249.99, 'https://s3-assets.sylvane.com/media/images/articles/wet-dry-vacuum-usage-sq.webp')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Wet/Dry Vacuum', 249.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://people.com/thmb/pNU3inYTOt-0yGf-fSExjdZBKeM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(1999x0:2001x2)/peo-car-vacuums-test-dirt-devil-scorpion-plus-corded-handheld-cleaner-sd30025b-walmart-dburreson-020-10-1-60d02502982545b6b1b4d1707dee7e1d.jpeg" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Car Vacuum Cleaner</h3>
                    <p>Specialized design for automotive cleaning</p>
                    <div class="price">$89.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(21, 'Car Vacuum Cleaner', 89.99, 'https://people.com/thmb/pNU3inYTOt-0yGf-fSExjdZBKeM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(1999x0:2001x2)/peo-car-vacuums-test-dirt-devil-scorpion-plus-corded-handheld-cleaner-sd30025b-walmart-dburreson-020-10-1-60d02502982545b6b1b4d1707dee7e1d.jpeg')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Car Vacuum Cleaner', 89.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://s1.kaercher-media.com/images/pim/SV_7_floor_nozzle_app_21_CI15502x502_1.jpg" alt="Featured product" class="product-image">
                <div class="product-info">
                    <h3>Steam Vacuum</h3>
                    <p>Deep cleaning with steam sanitization</p>
                    <div class="price">$329.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification(22, 'Steam Vacuum', 329.99, 'https://s1.kaercher-media.com/images/pim/SV_7_floor_nozzle_app_21_CI15502x502_1.jpg')">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Steam Vacuum', 329.99)">
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
            <div class="notification-product">
                <img id="notificationProductImage" src="" alt="">
                <div class="notification-product-info">
                    <span id="notificationProductName" class="notification-product-name"></span>
                    <span class="notification-product-price">$<span id="notificationProductPrice"></span></span>
                </div>
            </div>
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>

    <script>
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
                    'quantity': '1',
                    'imageUrl': imageUrl || ''
                })
            })
            .then(response => response.json())
            .then(data => {
                const notification = document.getElementById('cartNotification');
                document.getElementById('notificationProductName').textContent = productName;
                document.getElementById('notificationProductPrice').textContent = price;
                document.getElementById('notificationProductImage').src = imageUrl;
                
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

        function addToWishlist(productName, price) {
            // Implement wishlist functionality
        }
    </script>
</body>
</html> 