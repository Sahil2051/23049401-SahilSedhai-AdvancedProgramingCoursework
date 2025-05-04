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
    <title>Stationary & Office - SuperMart</title>
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
        }

        .category-header p {
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

        .wishlist-btn:hover {
            background-color: #f3f4f6;
            border-color: #d1d5db;
        }

        .wishlist-btn svg {
            color: #6b7280;
            transition: color 0.2s;
        }

        .wishlist-btn:hover svg {
            color: #ef4444;
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
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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
            <h1>Stationary & Office Supplies</h1>
            <p>Find all your office and school supplies here</p>
        </div>

        <div class="product-grid">
            <a href="product_details.jsp?id=1&name=Premium%20Notebook&price=12.99&image=https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw&desc=High-quality%20paper%20for%20writing%20and%20note-taking" class="product-card">
                <img src="https://imgs.search.brave.com/bt_u2hiTpD7webBrgfNv63mW2DLd86WKRPGj15A1gVY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL1Mv/YXBsdXMtbWVkaWEt/bGlicmFyeS1zZXJ2/aWNlLW1lZGlhL2Uy/YzY5MmY4LWYzYjIt/NGE1Yi1hYzViLTQ1/ZWFmOWJkZTI0OC5f/X0NSMCwwLDk3MCw2/MDBfUFQwX1NYOTcw/X1YxX19fLmpwZw" alt="Notebooks" class="product-image">
                <div class="product-info">
                    <h3>Premium Notebook</h3>
                    <p>High-quality paper for writing and note-taking</p>
                    <div class="price">$12.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="event.stopPropagation(); showNotification('Premium Notebook', 12.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Premium Notebook', 12.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </a>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/JGaObmib5LQEPd5rGhXn-Zm4tLh-Sju7lEzifd09sDw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/ODFySm5KMk1Fbkwu/anBn" alt="Pens" class="product-image">
                <div class="product-info">
                    <h3>Gel Pen Set</h3>
                    <p>Smooth writing gel pens in various colors</p>
                    <div class="price">$4.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Gel Pen Set', 4.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Gel Pen Set', 4.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/eYMVDHVLTE1otkMhpCqzE2S_OJj1XecJ5LuD_R5J2wo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFyemdCOWdJWEwu/anBn" alt="Staplers" class="product-image">
                <div class="product-info">
                    <h3>Heavy Duty Stapler</h3>
                    <p>Reliable stapler for office use</p>
                    <div class="price">$12.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Heavy Duty Stapler', 12.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Heavy Duty Stapler', 12.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/HHiFrKbwWB9ye0fzswdYCrqATZePowZUaI0hZPC95UY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZS5tYWRlLWluLWNo/aW5hLmNvbS8xNTVm/MGowMHNvR2JPdWZx/blNrZy9BNC1QYXBl/ci1Db3BpZXItNTAw/LVNoZWV0cy1SZWFt/LTUtUmVhbXMtQm94/LUE0LUNvcHktUGFw/ZXIud2VicA" alt="Paper" class="product-image">
                <div class="product-info">
                    <h3>A4 Paper Ream</h3>
                    <p>500 sheets of high-quality printing paper</p>
                    <div class="price">$6.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('A4 Paper Ream', 6.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('A4 Paper Ream', 6.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/r5sZRGU6LkFkf8-Ev5TgEisGu36un294vc7s7whUSTY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YW5uYWJyZWdtYW5w/b3J0cmFpdHMuY28u/dWsvd3AtY29udGVu/dC91cGxvYWRzLzIw/MTQvMDgvQVJUSUNM/RVMtcGVuY2lsLXJl/dmlld3MtRmFiZXIt/Q2FzdGVsbDMuanBn" alt="Pencils" class="product-image">
                <div class="product-info">
                    <h3>Drawing Pencil Set</h3>
                    <p>Professional grade pencils for artists and designers</p>
                    <div class="price">$14.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Drawing Pencil Set', 14.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Drawing Pencil Set', 14.99)">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <img src="https://imgs.search.brave.com/C__9T5MZx9UQbHZcrBcz2I_XF76nwdv-JB_WdyklNe0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zaG9w/LmdoZW50LmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAyNC8w/My9naGVudC1lcmFz/ZXItbWFya2VyLWNv/bWJvLWFuZ2xlLXZh/cmlldHktMTUwMHgx/NTAwLTEuanBn" alt="Markers" class="product-image">
                <div class="product-info">
                    <h3>Whiteboard Markers</h3>
                    <p>Quick-drying markers with vibrant colors</p>
                    <div class="price">$8.99</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn" onclick="showNotification('Whiteboard Markers', 8.99)">Add To Cart</button>
                        <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Whiteboard Markers', 8.99)">
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
            const notification = document.createElement('div');
            notification.className = 'cart-notification';
            notification.innerHTML = `
                <div class="notification-content">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                    <span>${productName} added to cart!</span>
                </div>
            `;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }

        function addToWishlist(productName, price) {
            const notification = document.createElement('div');
            notification.className = 'cart-notification';
            notification.innerHTML = `
                <div class="notification-content">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                    </svg>
                    <span>${productName} added to wishlist!</span>
                </div>
            `;
            document.body.appendChild(notification);
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
    </script>
</body>
</html> 