<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - SuperMart</title>
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
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
    }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
    }

    .cart-title {
            font-size: 1.875rem;
            font-weight: 600;
            color: #111827;
    }

        .cart-items {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        overflow: hidden;
    }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: center;
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
    }

        .cart-item:last-child {
            border-bottom: none;
    }

        .item-image {
        width: 100px;
        height: 100px;
        object-fit: cover;
            border-radius: 0.5rem;
    }

        .item-details h3 {
            font-size: 1.1rem;
            color: #111827;
            margin-bottom: 0.5rem;
    }

        .item-price {
            color: #4f46e5;
        font-weight: 600;
    }

        .quantity-controls {
        display: flex;
        align-items: center;
            gap: 0.5rem;
    }

    .quantity-btn {
            width: 30px;
            height: 30px;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
            background: white;
            color: #4b5563;
            cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .quantity-btn:hover {
            background: #f3f4f6;
    }

    .quantity-input {
            width: 50px;
            height: 30px;
            border: 1px solid #e5e7eb;
            border-radius: 0.375rem;
        text-align: center;
        }

        .item-total {
        font-weight: 600;
            color: #111827;
    }

    .remove-btn {
            color: #ef4444;
            background: none;
        border: none;
            cursor: pointer;
            padding: 0.5rem;
    }

    .remove-btn:hover {
            color: #dc2626;
    }

        .cart-summary {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-top: 2rem;
    }

        .summary-row {
        display: flex;
        justify-content: space-between;
            margin-bottom: 1rem;
            color: #4b5563;
    }

        .summary-row.total {
            font-weight: 600;
            color: #111827;
            font-size: 1.1rem;
            border-top: 1px solid #e5e7eb;
        padding-top: 1rem;
            margin-top: 1rem;
    }

    .checkout-btn {
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
            margin-top: 1.5rem;
    }

    .checkout-btn:hover {
            background-color: #4338ca;
    }

    .empty-cart {
        text-align: center;
            padding: 3rem;
            color: #6b7280;
    }

    .continue-shopping {
            color: #4f46e5;
        text-decoration: none;
            font-weight: 500;
    }

    .continue-shopping:hover {
            text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="cart-header">
            <h1 class="cart-title">Shopping Cart</h1>
        </div>

        <div class="cart-items">
            <% 
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            if (cartItems != null && !cartItems.isEmpty()) {
                double subtotal = 0;
                for (CartItem item : cartItems) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    subtotal += itemTotal;
            %>
                <div class="cart-item">
                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>" class="item-image">
                    <div class="item-details">
                        <h3><%= item.getProductName() %></h3>
                    </div>
                    <div class="item-price">$<%= String.format("%.2f", item.getPrice()) %></div>
                    <div class="quantity-controls">
                        <button class="quantity-btn" onclick="updateQuantity(<%= item.getProductId() %>, -1)">-</button>
                        <input type="number" class="quantity-input" value="<%= item.getQuantity() %>" min="1" 
                               onchange="updateQuantity(<%= item.getProductId() %>, this.value - <%= item.getQuantity() %>)">
                        <button class="quantity-btn" onclick="updateQuantity(<%= item.getProductId() %>, 1)">+</button>
                    </div>
                    <div class="item-total">$<%= String.format("%.2f", itemTotal) %></div>
                    <button class="remove-btn" onclick="removeItem(<%= item.getProductId() %>)">Remove</button>
                </div>
            <% 
                }
            %>
                <div class="cart-summary">
                    <div class="summary-row">
                        <span>Subtotal</span>
                            <span>$<%= String.format("%.2f", subtotal) %></span>
                        </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>Free</span>
                        </div>
                    <div class="summary-row">
                        <span>Tax (10%)</span>
                        <span>$<%= String.format("%.2f", subtotal * 0.1) %></span>
                        </div>
                    <div class="summary-row total">
                        <span>Total</span>
                        <span>$<%= String.format("%.2f", subtotal * 1.1) %></span>
                    </div>
                    <button class="checkout-btn" onclick="window.location.href='checkout.jsp'">Proceed to Checkout</button>
                </div>
            <% } else { %>
                <div class="empty-cart">
                    <h2>Your cart is empty</h2>
                    <p>Add some items to your cart to continue shopping.</p>
                    <a href="dashboard.jsp" class="continue-shopping">Continue Shopping</a>
            </div>
        <% } %>
    </div>
</div>

<script>
        function updateQuantity(productId, change) {
            const input = event.target.parentElement.querySelector('input');
            const currentValue = parseInt(input.value);
            const newValue = currentValue + change;
            
            if (newValue >= 1) {
                input.value = newValue;
                // Send update request
                fetch('cart/update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productId=' + productId + '&quantity=' + newValue
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    }
                });
            }
        }

        function removeItem(productId) {
            if (confirm('Are you sure you want to remove this item?')) {
                fetch('cart/remove', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productId=' + productId
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    }
                });
            }
        }
    </script>
</body>
</html> 