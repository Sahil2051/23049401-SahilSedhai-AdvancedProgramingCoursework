<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - SuperMart</title>
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
            line-height: 1.5;
        }

        .container {
            max-width: 1000px;
            margin: 3rem auto;
            padding: 0 1rem;
        }

        .confirmation-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .check-icon {
            width: 48px;
            height: 48px;
            background: #fff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .check-icon i {
            color: #10B981;
            font-size: 24px;
        }

        .confirmation-text h1 {
            font-size: 1.5rem;
            color: #1a1a1a;
            margin-bottom: 0.5rem;
        }

        .confirmation-text p {
            color: #4b5563;
            margin: 0;
        }

        .order-details {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .order-section {
            padding: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .order-section:last-child {
            border-bottom: none;
        }

        .section-title {
            font-size: 1rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .info-item {
            color: #4b5563;
        }

        .info-item a {
            color: #4f46e5;
            text-decoration: none;
        }

        .info-item a:hover {
            text-decoration: underline;
        }

        .summary-section {
            background: #f1f3f5;
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            color: #4b5563;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 0.75rem;
            padding-top: 0.75rem;
            border-top: 1px solid #e5e7eb;
            font-weight: 600;
            color: #1a1a1a;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            text-align: center;
        }

        .btn-primary {
            background-color: #4f46e5;
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background-color: #4338ca;
        }

        .btn-outline {
            background: white;
            border: 1px solid #e5e7eb;
            color: #4b5563;
        }

        .btn-outline:hover {
            border-color: #4f46e5;
            color: #4f46e5;
        }

        .buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="confirmation-header">
            <div class="check-icon">
                <i class="fas fa-check"></i>
            </div>
            <div class="confirmation-text">
                <h1>Thank you, Sohail!</h1>
                <p>Your order is confirmed.</p>
            </div>
        </div>

        <div class="order-details">
            <div class="order-section">
                <h2 class="section-title">Order #131217312</h2>
                <p>We've accepted your order and we're getting it ready.</p>
            </div>

            <div class="order-section">
                <h2 class="section-title">Customer Information</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <strong>Shipping Address</strong><br>
                        Sohail Khan<br>
                        <a href="#">Pathibhara Tole, Itahari<br>
                        Sunsari<br>
                        Nepal</a>
                    </div>
                    <div class="info-item">
                        <strong>Shipping Method</strong><br>
                        UPS Ground (Estimated ship<br>
                        time of 3-6 days)
                    </div>
                    <div class="info-item">
                        <strong>Payment Method</strong><br>
                        <i class="fab fa-cc-visa"></i> Ending in 3217 — $23.60
                    </div>
                </div>
            </div>

            <div class="order-section">
                <h2 class="section-title">Summary (1 item)</h2>
                <div class="summary-section">
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
                    <div class="summary-total">
                        <span>Total</span>
                        <span>$23.60</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="buttons">
            <a href="dashboard.jsp" class="btn btn-primary">Continue Shopping</a>
            <a href="profile.jsp" class="btn btn-outline">View Order History</a>
        </div>
    </div>
</body>
</html> 