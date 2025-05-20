<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - SuperMart</title>
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
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .cart-summary {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .cart-item img {
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

        .order-summary {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            height: fit-content;
        }

        .summary-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 1.5rem;
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

        .success-message {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1000;
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }

        .success-message h2 {
            color: #059669;
            margin-bottom: 1.5rem;
        }

        .purchase-report {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin: 1rem 0;
            text-align: left;
        }

        .report-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .report-header h3 {
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .customer-name, .order-date, .order-time {
            color: #4b5563;
            margin: 0.25rem 0;
        }

        .report-items {
            margin-bottom: 1.5rem;
        }

        .report-items h4 {
            color: #1f2937;
            margin-bottom: 1rem;
        }

        .items-list {
            background: white;
            border-radius: 6px;
            padding: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .item-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .item-name {
            font-weight: 500;
        }

        .item-quantity {
            color: #6b7280;
        }

        .item-price {
            text-align: right;
            font-weight: 500;
        }

        .report-summary {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            color: #4b5563;
        }

        .summary-row.total {
            font-weight: 600;
            color: #111827;
            font-size: 1.1rem;
            margin-top: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px solid #e5e7eb;
        }

        .report-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .print-btn, .download-btn {
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .print-btn {
            background-color: #4f46e5;
            color: white;
            border: none;
        }

        .print-btn:hover {
            background-color: #4338ca;
        }

        .download-btn {
            background: white;
            border: 1px solid #e5e7eb;
            color: #4b5563;
        }

        .download-btn:hover {
            border-color: #4f46e5;
            color: #4f46e5;
        }

        .continue-btn {
            margin-top: 1.5rem;
            padding: 0.75rem 1.5rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .continue-btn:hover {
            background-color: #4338ca;
        }

        @media print {
            .success-message {
                position: static;
                transform: none;
                box-shadow: none;
                padding: 0;
            }

            .report-actions, .continue-btn {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="cart-summary">
            <h2>Cart Summary</h2>
            <% 
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
            double subtotal = 0;
            if (cartItems != null && !cartItems.isEmpty()) {
                for (CartItem item : cartItems) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    subtotal += itemTotal;
            %>
                <div class="cart-item">
                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>">
                    <div class="item-details">
                        <h3><%= item.getProductName() %></h3>
                    </div>
                    <div class="item-price">$<%= String.format("%.2f", item.getPrice()) %></div>
                    <div class="quantity-controls">
                        <button class="quantity-btn" onclick="decreaseQuantity(<%= item.getProductId() %>)">-</button>
                        <input type="number" class="quantity-input" value="<%= item.getQuantity() %>" min="1" 
                               onchange="updateQuantity(<%= item.getProductId() %>, this.value - <%= item.getQuantity() %>)">
                        <button class="quantity-btn" onclick="increaseQuantity(<%= item.getProductId() %>)">+</button>
                    </div>
                    <div class="item-total">$<%= String.format("%.2f", itemTotal) %></div>
                    <button class="remove-btn" onclick="removeItem(<%= item.getProductId() %>)">Remove</button>
                </div>
            <% 
                }
            }
            %>
        </div>

        <div class="order-summary">
            <h2 class="summary-title">Order Summary</h2>
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
            <button class="checkout-btn" onclick="confirmPayment()">Confirm Payment</button>
        </div>
    </div>

    <div id="successMessage" class="success-message">
        <h2>Payment Successful!</h2>
        <div class="purchase-report">
            <div class="report-header">
                <h3>Purchase Report</h3>
                <p class="customer-name">Customer: <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "Guest" %></p>
                <p class="order-date">Date: <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %></p>
                <p class="order-time">Time: <%= new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date()) %></p>
            </div>
            
            <div class="report-items">
                <h4>Items Purchased</h4>
                <div class="items-list">
                    <% 
                    if (cartItems != null) {
                        for (CartItem item : cartItems) {
                    %>
                        <div class="item-row">
                            <span class="item-name"><%= item.getProductName() %></span>
                            <span class="item-quantity">x<%= item.getQuantity() %></span>
                            <span class="item-price">$<%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
                        </div>
                    <% 
                        }
                    }
                    %>
                </div>
            </div>

            <div class="report-summary">
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
                    <span>Total Amount</span>
                    <span>$<%= String.format("%.2f", subtotal * 1.1) %></span>
                </div>
            </div>

            <div class="report-actions">
                <button onclick="window.print()" class="print-btn">
                    <i class="fas fa-print"></i> Print Report
                </button>
                <button onclick="downloadPDF()" class="download-btn">
                    <i class="fas fa-download"></i> Download PDF
                </button>
            </div>
        </div>
        <button onclick="window.location.href='dashboard.jsp'" class="continue-btn">Continue Shopping</button>
    </div>

    <script>
        function decreaseQuantity(productId) {
            const input = event.target.parentElement.querySelector('input');
            const currentValue = parseInt(input.value);
            if (currentValue > 1) {
                updateQuantity(productId, -1);
            }
        }

        function increaseQuantity(productId) {
            updateQuantity(productId, 1);
        }

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

        function confirmPayment() {
            // Show success message with purchase report
            document.getElementById('successMessage').style.display = 'block';
            
            // Get current total sales from localStorage or initialize to 0
            let totalSales = parseInt(localStorage.getItem('totalSales') || '0');
            
            // Get total quantity from cart items
            const cartItems = document.querySelectorAll('.cart-item');
            let totalQuantity = 0;
            cartItems.forEach(item => {
                const quantityInput = item.querySelector('.quantity-input');
                totalQuantity += parseInt(quantityInput.value);
            });
            
            // Add current quantity to total sales
            totalSales += totalQuantity;
            
            // Save updated total sales back to localStorage
            localStorage.setItem('totalSales', totalSales);
        }

        function downloadPDF() {
            // This is a placeholder for PDF download functionality
            alert('PDF download functionality will be implemented soon!');
        }
    </script>
</body>
</html> 