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
    <title>Payment - SuperMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .payment-section {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .summary-section {
            background: #f1f3f5;
            padding: 2rem;
            border-radius: 8px;
            height: fit-content;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #1a1a1a;
        }

        .shipping-address {
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
        }

        .address-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .edit-link {
            color: #4f46e5;
            text-decoration: none;
            font-size: 0.875rem;
        }

        .shipping-method {
            margin-bottom: 2rem;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 6px;
            border: 1px solid #e5e7eb;
        }

        .method-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #4b5563;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .payment-cards {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .payment-card {
            width: 50px;
            height: 32px;
            border: 1px solid #e5e7eb;
            border-radius: 4px;
            padding: 0.25rem;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0.6;
            transition: opacity 0.2s;
        }

        .payment-card.active {
            opacity: 1;
            border-color: #4f46e5;
        }

        .card-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 1rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            color: #4b5563;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
            font-weight: 600;
            color: #1a1a1a;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background-color: #4f46e5;
            color: white;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .secure-badge {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #4b5563;
            font-size: 0.875rem;
            margin-top: 1rem;
        }

        .back-link {
            color: #4f46e5;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 2rem;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .card-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9ca3af;
        }

        .input-wrapper {
            position: relative;
        }

        .gift-card-section {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
        }

        .gift-card-input {
            display: flex;
            gap: 0.5rem;
        }

        .gift-card-input input {
            flex: 1;
        }

        .btn-outline {
            background: white;
            border: 1px solid #e5e7eb;
            color: #4b5563;
            padding: 0.5rem 1rem;
        }
    </style>
    <!-- Add popup styles -->
    <style>
        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .popup-content {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            text-align: center;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .popup-content i {
            color: #10B981;
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .popup-content h2 {
            color: #1F2937;
            margin-bottom: 1rem;
        }

        .popup-content p {
            color: #6B7280;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <!-- Add popup HTML -->
    <div class="popup-overlay" id="successPopup">
        <div class="popup-content">
            <i class="fas fa-check-circle"></i>
            <h2>Order Placed Successfully!</h2>
            <p>Your order has been confirmed. Redirecting to order details...</p>
        </div>
    </div>
    <div class="container">
        <div class="payment-section">
            <a href="cart.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Return to Customer Information
            </a>

            <div class="shipping-address">
                <div class="address-header">
                    <h2 class="section-title">Shipping Address</h2>
                    <a href="#" class="edit-link">Edit</a>
                </div>
                <p>Pathibhara Tole, Itahari-4, Sunsari</p>
            </div>

            <div class="shipping-method">
                <h2 class="section-title">Shipping Method</h2>
                <div class="method-option">
                    <div>
                        <input type="radio" id="upsGround" name="shipping" checked>
                        <label for="upsGround">UPS Ground</label>
                    </div>
                    <span>$2.20</span>
                </div>
            </div>

            <h2 class="section-title">Payment Method</h2>
            
            <div class="payment-cards">
                <div class="payment-card active">
                    <i class="fab fa-cc-visa fa-lg"></i>
                </div>
                <div class="payment-card">
                    <i class="fab fa-cc-mastercard fa-lg"></i>
                </div>
                <div class="payment-card">
                    <i class="fab fa-cc-amex fa-lg"></i>
                </div>
            </div>

            <form id="paymentForm" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="cardNumber">Card number</label>
                    <div class="input-wrapper">
                        <input type="text" id="cardNumber" class="form-control" placeholder="1234 5678 9012 3456" maxlength="19">
                        <i class="fas fa-lock card-icon"></i>
                    </div>
                </div>

                <div class="card-row">
                    <div class="form-group">
                        <label for="cardName">Name on card</label>
                        <input type="text" id="cardName" class="form-control" placeholder="John Doe">
                    </div>
                    <div class="form-group">
                        <label for="expiry">MM/YY</label>
                        <input type="text" id="expiry" class="form-control" placeholder="MM/YY" maxlength="5">
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <div class="input-wrapper">
                            <input type="password" id="cvv" class="form-control" placeholder="123" maxlength="4">
                            <i class="fas fa-question-circle card-icon"></i>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">Complete Order</button>

                <div class="secure-badge">
                    <i class="fas fa-lock"></i>
                    Secure checkout
                </div>
            </form>
        </div>

        <div class="summary-section">
            <h2 class="section-title">Summary (1 item)</h2>
            
            <div class="summary-item">
                <span>Subtotal</span>
                <span>$20.00</span>
            </div>
            <div class="summary-item">
                <span>Shipping</span>
                <span>$2.20</span>
            </div>
            <div class="summary-item">
                <span>Est. Taxes</span>
                <span>$1.40</span>
            </div>

            <div class="gift-card-section">
                <label for="giftCard">Gift card or discount code</label>
                <div class="gift-card-input">
                    <input type="text" id="giftCard" class="form-control" placeholder="Enter code">
                    <button class="btn btn-outline">Apply</button>
                </div>
            </div>

            <div class="summary-total">
                <span>Total</span>
                <span>$23.60</span>
            </div>
        </div>
    </div>

    <script>
        // Format card number with spaces
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = value.replace(/\d{4}(?=.)/g, '$& ');
            e.target.value = formattedValue;
        });

        // Format expiry date
        document.getElementById('expiry').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            if (value.length >= 2) {
                value = value.slice(0,2) + '/' + value.slice(2);
            }
            e.target.value = value;
        });

        // Basic form validation
        function validateForm() {
            const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
            const cardName = document.getElementById('cardName').value;
            const expiry = document.getElementById('expiry').value;
            const cvv = document.getElementById('cvv').value;

            if (cardNumber.length < 16) {
                alert('Please enter a valid card number');
                return false;
            }
            if (cardName.length < 3) {
                alert('Please enter the name on card');
                return false;
            }
            if (!expiry.match(/^\d{2}\/\d{2}$/)) {
                alert('Please enter a valid expiry date (MM/YY)');
                return false;
            }
            if (cvv.length < 3) {
                alert('Please enter a valid CVV');
                return false;
            }

            // Show success popup
            const popup = document.getElementById('successPopup');
            popup.style.display = 'flex';

            // Redirect after 2 seconds
            setTimeout(() => {
                window.location.href = 'order_complete.jsp';
            }, 2000);

            return false;
        }
    </script>
</body>
</html> 