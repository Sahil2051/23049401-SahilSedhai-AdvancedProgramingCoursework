        .cart-notification {
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            z-index: 1000;
            min-width: 320px;
            display: none;
            animation: slideIn 0.3s ease-out;
            transform-origin: top right;
        }

        .cart-notification.error {
            border-color: #ef4444;
            background-color: #fef2f2;
        }

        .notification-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .notification-title svg {
            width: 20px;
            height: 20px;
            color: #4f46e5;
        }

        .notification-content {
            color: #4b5563;
            margin-bottom: 1.25rem;
        }

        .notification-product {
            display: flex;
            gap: 1rem;
            align-items: center;
            padding: 0.75rem;
            background: #f9fafb;
            border-radius: 0.5rem;
        }

        .notification-product img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 0.375rem;
            border: 1px solid #e5e7eb;
        }

        .notification-product-info {
            flex: 1;
        }

        .notification-product-name {
            font-weight: 500;
            color: #111827;
            margin-bottom: 0.25rem;
        }

        .notification-product-price {
            color: #4f46e5;
            font-weight: 600;
        }

        .notification-buttons {
            display: flex;
            gap: 1rem;
        }

        .view-cart-btn, .checkout-btn {
            flex: 1;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            font-weight: 500;
            text-decoration: none;
            text-align: center;
            transition: all 0.2s;
        }

        .view-cart-btn {
            background-color: #f3f4f6;
            color: #374151;
            border: 1px solid #e5e7eb;
        }

        .view-cart-btn:hover {
            background-color: #e5e7eb;
            transform: translateY(-1px);
        }

        .checkout-btn {
            background-color: #4f46e5;
            color: white;
            border: none;
        }

        .checkout-btn:hover {
            background-color: #4338ca;
            transform: translateY(-1px);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

    <!-- Cart Notification -->
    <div id="cartNotification" class="cart-notification">
        <div class="notification-title">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
            Item Added To Cart
        </div>
        <div class="notification-content">
            <div class="notification-product">
                <img id="notificationProductImage" src="" alt="">
                <div class="notification-product-info">
                    <div id="notificationProductName" class="notification-product-name"></div>
                    <div class="notification-product-price">$<span id="notificationProductPrice"></span></div>
                </div>
            </div>
        </div>
        <div class="notification-buttons">
            <a href="cart.jsp" class="view-cart-btn">View Cart</a>
            <a href="checkout.jsp" class="checkout-btn" onclick="return proceedToCheckout()">Checkout</a>
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
                document.getElementById('notificationProductImage').src = imageUrl || '';
                
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

        function proceedToCheckout() {
            // Check if cart is empty
            fetch('/Supermarket_Management_System_war_exploded/cart/count')
                .then(response => response.json())
                .then(data => {
                    if (data.itemCount === 0) {
                        alert('Your cart is empty. Please add items before proceeding to checkout.');
                        return false;
                    }
                    // Redirect to checkout page
                    window.location.href = 'checkout.jsp';
                    return true;
                })
                .catch(error => {
                    console.error('Error checking cart:', error);
                    alert('An error occurred while processing your request. Please try again.');
                    return false;
                });
            return false; // Prevent default link behavior
        }

        function addToWishlist(productName, price) {
            // Implement wishlist functionality
        }
    </script> 

    <div class="product-grid">
        <div class="product-card">
            <img src="https://imgs.search.brave.com/vvWlrQ31TEOKE4a0taMqqC5sY_Gvu-BaAPI_qIfp410/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/LmhhcnJ5YW5kZGF2/aWQuY29tL3djc3N0/b3JlL0hhcnJ5QW5k/RGF2aWQvaW1hZ2Vz/L2NhdGFsb2cvMjNf/MDAyNDQ5NV8zMFdf/MTM5XzAyOXguanBn/P2hlaWdodD00NTYm/d2lkdGg9NDE4JnNo/YXJwZW49YTAuNSxy/MSx0MSZhdXRvPXdl/YnA" alt="Fresh Fruits" class="product-image">
            <div class="product-info">
                <h3>Fresh Fruit Basket</h3>
                <p>Assorted seasonal fruits, hand-picked for quality</p>
                <div class="price">$24.99</div>
                <div class="product-actions">
                    <button class="add-to-cart-btn" onclick="showNotification(1, 'Fresh Fruit Basket', 24.99, 'https://imgs.search.brave.com/vvWlrQ31TEOKE4a0taMqqC5sY_Gvu-BaAPI_qIfp410/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4x/LmhhcnJ5YW5kZGF2/aWQuY29tL3djc3N0/b3JlL0hhcnJ5QW5k/RGF2aWQvaW1hZ2Vz/L2NhdGFsb2cvMjNf/MDAyNDQ5NV8zMFdf/MTM5XzAyOXguanBn/P2hlaWdodD00NTYm/d2lkdGg9NDE4JnNo/YXJwZW49YTAuNSxy/MSx0MSZhdXRvPXdl/YnA')">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        Add To Cart
                    </button>
                    <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Fresh Fruit Basket', 24.99)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
                    <button class="add-to-cart-btn" onclick="showNotification(2, 'Vegetable Mix', 19.99, 'https://imgs.search.brave.com/gv3qrqaN1uJJ0oSjWbW9lYGbZFYR96y7RI0GtgjMNug/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/Z2FybGljYW5kemVz/dC5jb20vd3AtY29u/dGVudC91cGxvYWRz/LzIwMjIvMDgvdmVn/ZXRhYmxlLW1lZGxl/eS02ODF4MTAyNC5q/cGc')">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        Add To Cart
                    </button>
                    <button class="wishlist-btn" onclick="event.stopPropagation(); addToWishlist('Vegetable Mix', 19.99)">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>
    </div> 