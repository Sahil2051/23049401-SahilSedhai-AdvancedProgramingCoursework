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

        .report-container {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .report-header {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .report-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .report-items {
            margin-bottom: 1.5rem;
        }

        .report-items h3 {
            margin-bottom: 1rem;
            color: #1f2937;
        }

        .items-table {
            background: white;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .table-header {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            padding: 1rem;
            background: #f3f4f6;
            font-weight: 600;
            color: #374151;
        }

        .table-body {
            padding: 0.5rem;
        }

        .table-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            padding: 0.75rem 1rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-row:last-child {
            border-bottom: none;
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

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn i {
            font-size: 1rem;
        }

        @media print {
            .buttons, .report-actions {
                display: none;
            }
            
            .report-container {
                box-shadow: none;
                padding: 0;
            }
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

            <div class="order-section">
                <h2 class="section-title">Purchase Report</h2>
                <div class="report-container">
                    <div class="report-header">
                        <div class="report-info">
                            <p><strong>Order Date:</strong> <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %></p>
                            <p><strong>Order Time:</strong> <%= new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date()) %></p>
                        </div>
                    </div>
                    
                    <div class="report-items">
                        <h3>Items Purchased</h3>
                        <div class="items-table">
                            <div class="table-header">
                                <span>Item</span>
                                <span>Quantity</span>
                                <span>Price</span>
                                <span>Total</span>
                            </div>
                            <div class="table-body">
                                <!-- This will be populated dynamically with cart items -->
                                <div class="table-row">
                                    <span>Sample Item 1</span>
                                    <span>2</span>
                                    <span>$10.00</span>
                                    <span>$20.00</span>
                                </div>
                                <div class="table-row">
                                    <span>Sample Item 2</span>
                                    <span>1</span>
                                    <span>$15.00</span>
                                    <span>$15.00</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="report-summary">
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>$35.00</span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span>Free</span>
                        </div>
                        <div class="summary-row">
                            <span>Tax (10%)</span>
                            <span>$3.50</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total Amount</span>
                            <span>$38.50</span>
                        </div>
                    </div>

                    <div class="report-actions">
                        <button class="btn btn-primary" onclick="window.print()">
                            <i class="fas fa-print"></i> Print Report
                        </button>
                        <button class="btn btn-outline" onclick="downloadPDF()">
                            <i class="fas fa-download"></i> Download PDF
                        </button>
                    </div>
                </div>
            </div>

            <div class="buttons">
                <a href="dashboard.jsp" class="btn btn-primary">Continue Shopping</a>
                <a href="profile.jsp" class="btn btn-outline">View Order History</a>
            </div>
        </div>
    </div>

    <script>
        function downloadPDF() {
            // This is a placeholder for PDF download functionality
            alert('PDF download functionality will be implemented soon!');
        }
    </script>
</body>
</html> 