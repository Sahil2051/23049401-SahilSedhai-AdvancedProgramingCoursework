<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - SuperMart</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .success-container {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .success-icon {
            color: #059669;
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .success-title {
            color: #059669;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .success-message {
            color: #4b5563;
            margin-bottom: 2rem;
        }

        .continue-btn {
            padding: 0.75rem 1.5rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .continue-btn:hover {
            background-color: #4338ca;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">✓</div>
        <h1 class="success-title">Order Confirmed!</h1>
        <p class="success-message">Your order has been placed successfully. Thank you for shopping with us!</p>
        <a href="dashboard.jsp" class="continue-btn">Continue Shopping</a>
    </div>
</body>
</html> 