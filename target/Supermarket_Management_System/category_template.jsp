<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Category Name - Supermarket</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f8f9fa;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .category-header {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeIn 0.5s ease-out;
        }

        .category-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #4f46e5;
            letter-spacing: -0.5px;
            margin-bottom: 1rem;
        }

        .category-description {
            color: #6b7280;
            font-size: 1.1rem;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="category-header">
            <h1 class="category-title">Category Name</h1>
            <p class="category-description">Category description goes here</p>
        </div>

        <div class="product-grid">
            <!-- Example Product Card -->
            <div class="product-card">
                <img src="path/to/image.jpg" alt="Product Name" class="product-image">
                <div class="product-info">
                    <h3>Product Name</h3>
                    <p>Product description goes here</p>
                    <div class="price">$XX.XX</div>
                    <div class="product-actions">
                        <button class="add-to-cart-btn">
                            Add To Cart
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="cart-notification">
        <div class="notification-title">
            <i class="fas fa-check-circle"></i>
            Added to Cart
        </div>
        <div class="notification-content">
            Product has been added to your cart successfully.
        </div>
        <div class="notification-product">
            <img src="path/to/product-image.jpg" alt="Product Name">
            <div class="notification-product-info">
                <div class="notification-product-name">Product Name</div>
                <div class="notification-product-price">$XX.XX</div>
            </div>
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>

    <script>
        function showNotification() {
            const notification = document.querySelector('.cart-notification');
            notification.style.display = 'block';
            setTimeout(() => {
                notification.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html> 