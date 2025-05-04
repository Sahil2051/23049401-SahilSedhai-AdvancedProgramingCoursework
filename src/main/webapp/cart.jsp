<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - SuperMart</title>
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            display: grid;
            grid-template-columns: 1fr 350px;
            gap: 2rem;
        }

        .cart-title {
            font-size: 1.875rem;
            font-weight: 600;
            color: #111827;
            margin-bottom: 2rem;
        }

        .cart-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 1rem;
        }

        .cart-table th {
            text-align: left;
            color: #6b7280;
            font-weight: 500;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .cart-item {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .item-image {
            width: 80px;
            height: 80px;
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 8px;
        }

        .item-details {
            flex: 1;
        }

        .item-name {
            font-weight: 500;
            color: #111827;
            margin-bottom: 0.25rem;
        }

        .item-description {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .quantity-select {
            padding: 0.5rem;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            background: white;
        }

        .cart-summary {
            background: #f3f4f6;
            border-radius: 12px;
            padding: 1.5rem;
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

        .summary-total {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
            font-weight: 600;
            color: #111827;
        }

        .checkout-btn {
            display: block;
            width: 100%;
            padding: 0.75rem;
            background: #4f46e5;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            margin-top: 1.5rem;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .checkout-btn:hover {
            background: #4338ca;
        }

        .empty-cart {
            text-align: center;
            padding: 3rem;
            color: #6b7280;
        }

        .delete-btn {
            background-color: transparent;
            border: none;
            color: #ef4444;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0.375rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .delete-btn:hover {
            background-color: #fee2e2;
        }

        .delete-btn svg {
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <div class="cart-main">
            <h1 class="cart-title">Your Cart</h1>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="cart-item">
                                <div class="item-image">
                                    <img src="https://images.unsplash.com/photo-1553279768-865429fa0078?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Fresh Mangoes">
                                </div>
                                <div class="item-details">
                                    <div class="item-name">10 Kg Mangoes</div>
                                    <div class="item-description">Fresh, Sweet Alphonso Mangoes</div>
                                </div>
                            </div>
                        </td>
                        <td>$20.00</td>
                        <td>
                            <select class="quantity-select">
                                <option value="10">10 kg</option>
                                <option value="20">20 kg</option>
                                <option value="30">30 kg</option>
                            </select>
                        </td>
                        <td>
                            <button class="delete-btn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 6h18"></path>
                                    <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
                                    <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
                                </svg>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="cart-item">
                                <div class="item-image">
                                    <img src="https://imgs.search.brave.com/r0bdOePwLMC6Nz_-m_OkdQ-MsGXhLB0LU54rVtUFocw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NzFLZ0JISUxWNkwu/anBn" alt="Cleaning Set">
                                </div>
                                <div class="item-details">
                                    <div class="item-name">Home Cleaning Set</div>
                                    <div class="item-description">Complete household cleaning kit</div>
                                </div>
                            </div>
                        </td>
                        <td>$35.00</td>
                        <td>
                            <select class="quantity-select">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </td>
                        <td>
                            <button class="delete-btn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 6h18"></path>
                                    <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
                                    <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
                                </svg>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="cart-item">
                                <div class="item-image">
                                    <img src="https://images.unsplash.com/photo-1546868871-7041f2a55e12?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Smart Watch">
                                </div>
                                <div class="item-details">
                                    <div class="item-name">Smart Watch Pro</div>
                                    <div class="item-description">Fitness tracking & notifications</div>
                                </div>
                            </div>
                        </td>
                        <td>$199.99</td>
                        <td>
                            <select class="quantity-select">
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </td>
                        <td>
                            <button class="delete-btn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 6h18"></path>
                                    <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
                                    <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
                                </svg>
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="text-align: right; margin-top: 1rem;">
                <div style="font-weight: 500;">Subtotal: $254.99</div>
            </div>
        </div>

        <div class="cart-summary">
            <h2 class="summary-title">Summary (3 items)</h2>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>$254.99</span>
            </div>
            <div class="summary-row">
                <span>Shipping</span>
                <span>$10.00</span>
            </div>
            <div class="summary-row">
                <span>Est. Taxes</span>
                <span>$25.50</span>
            </div>
            <div class="summary-row summary-total">
                <span>Total</span>
                <span>$290.49</span>
            </div>
            <a href="payment.jsp" class="checkout-btn">Checkout</a>
        </div>
    </div>
</body>
</html> 