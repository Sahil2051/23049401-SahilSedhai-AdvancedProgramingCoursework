<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<%
    // Get the product ID from the URL
    String productId = request.getParameter("id");
    
    // In a real application, you would fetch product details from a database
    // For now, we'll use a simple switch case for demonstration
    String productName = "";
    String productPrice = "";
    String productDescription = "";
    String productImage = "";
    String productCategory = "";
    String categoryUrl = "";
    
    if (productId != null) {
        switch(productId) {
            case "1":
                productName = "Fresh Alphonso Mangoes";
                productPrice = "$20.00";
                productDescription = "Sweet and juicy mangoes, perfect for summer";
                productImage = "https://images.unsplash.com/photo-1553279768-865429fa0078?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80";
                productCategory = "Groceries";
                categoryUrl = "category_groceries.jsp";
                break;
            case "2":
                productName = "Mixed Vegetables Pack";
                productPrice = "$15.00";
                productDescription = "Assorted fresh vegetables";
                productImage = "https://images.unsplash.com/photo-1587132137056-bfbf0166836e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80";
                productCategory = "Groceries";
                categoryUrl = "category_groceries.jsp";
                break;
            // Add more cases for other products
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= productName %> - SuperMart</title>
    <style>
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 1rem 0;
            color: #6b7280;
            font-size: 0.875rem;
        }

        .breadcrumb a {
            color: #4f46e5;
            text-decoration: none;
        }

        .breadcrumb span::before {
            content: ">";
            margin: 0 0.5rem;
        }

        .product-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 3rem;
        }

        .product-images {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .main-image {
            aspect-ratio: 4/3;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .main-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .thumbnail-grid {
            display: flex;
            gap: 1rem;
        }

        .thumbnail {
            width: 80px;
            height: 80px;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            overflow: hidden;
            cursor: pointer;
        }

        .thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .thumbnail:hover {
            border-color: #4f46e5;
        }

        .product-info {
            padding-top: 1rem;
        }

        .quantity-selector {
            margin: 2rem 0;
        }

        .quantity-selector label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151;
        }

        .quantity-select {
            width: 120px;
            padding: 0.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            background-color: white;
        }

        .add-to-cart-btn {
            width: 100%;
            padding: 0.875rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.375rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .add-to-cart-btn:hover {
            background-color: #4338ca;
        }

        .product-description {
            margin-top: 2rem;
            color: #4b5563;
            line-height: 1.5;
        }

        .similar-products {
            margin-top: 4rem;
            padding-top: 2rem;
            border-top: 1px solid #e5e7eb;
        }

        .similar-products h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 1.5rem;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 1.5rem;
        }

        .product-card {
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .product-card img {
            width: 100%;
            aspect-ratio: 1;
            object-fit: cover;
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
    </style>
</head>
<body>
    <div class="product-container">
        <!-- Breadcrumb -->
        <nav class="breadcrumb">
            <a href="dashboard.jsp">Home</a>
            <span><a href="<%= categoryUrl %>"><%= productCategory %></a></span>
            <span><%= productName %></span>
        </nav>

        <!-- Product Content -->
        <div class="product-images">
            <div class="main-image">
                <img src="<%= productImage %>" alt="<%= productName %>">
            </div>
            <div class="thumbnail-grid">
                <div class="thumbnail">
                    <img src="<%= productImage %>?w=100" alt="Thumbnail 1">
                </div>
                <div class="thumbnail">
                    <img src="<%= productImage %>?w=100" alt="Thumbnail 2">
                </div>
                <div class="thumbnail">
                    <img src="<%= productImage %>?w=100" alt="Thumbnail 3">
                </div>
            </div>
        </div>

        <div class="product-info">
            <h1 class="product-title"><%= productName %></h1>
            <div class="product-price"><%= productPrice %></div>
            <div class="quantity-selector">
                <label for="quantity">Quantity</label>
                <select id="quantity" class="quantity-select">
                    <option value="10">10 kg</option>
                    <option value="20">20 kg</option>
                    <option value="30">30 kg</option>
                </select>
            </div>
            <button class="add-to-cart-btn" onclick="showNotification()">Add To Cart</button>
            <div class="product-description">
                <%= productDescription %>
            </div>
        </div>
    </div>

    <!-- Similar Products -->
    <div class="similar-products">
        <div class="container">
            <h2>You might also like these!</h2>
            <div class="product-grid">
                <div class="product-card">
                    <img src="https://images.unsplash.com/photo-1587132137056-bfbf0166836e?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Similar Product 1">
                </div>
                <div class="product-card">
                    <img src="https://images.unsplash.com/photo-1601493700631-2b16ec4b4716?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Similar Product 2">
                </div>
                <div class="product-card">
                    <img src="https://images.unsplash.com/photo-1589820296156-2454bb8a6ad1?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Similar Product 3">
                </div>
                <div class="product-card">
                    <img src="https://images.unsplash.com/photo-1577234286642-fc512a5f8f11?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Similar Product 4">
                </div>
                <div class="product-card">
                    <img src="https://images.unsplash.com/photo-1553279768-865429fa0078?ixlib=rb-4.0.3&auto=format&fit=crop&w=200&q=80" alt="Similar Product 5">
                </div>
            </div>
        </div>
    </div>

    <!-- Cart Notification -->
    <div id="cartNotification" class="cart-notification" style="display: none;">
        <div class="notification-title">Item Added To Cart</div>
        <div class="notification-content">
            <%= productName %><br>
            Qty: <span id="selectedQuantity">10</span> kg
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>

    <script>
        function showNotification() {
            const notification = document.getElementById('cartNotification');
            const quantitySelect = document.getElementById('quantity');
            const selectedQuantity = document.getElementById('selectedQuantity');
            
            selectedQuantity.textContent = quantitySelect.value;
            notification.style.display = 'block';
            
            // Hide notification after 5 seconds
            setTimeout(() => {
                notification.style.display = 'none';
            }, 5000);
        }

        // Thumbnail click handler
        document.querySelectorAll('.thumbnail').forEach(thumb => {
            thumb.addEventListener('click', function() {
                const mainImage = document.querySelector('.main-image img');
                mainImage.src = this.querySelector('img').src.replace('w=100', 'w=1000');
            });
        });
    </script>
</body>
</html> 