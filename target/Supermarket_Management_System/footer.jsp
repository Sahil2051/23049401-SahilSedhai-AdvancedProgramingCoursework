<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    .footer {
        background: linear-gradient(135deg, var(--secondary-color) 0%, #1a252f 100%);
        color: white;
        padding: 4rem 0 2rem;
        margin-top: 4rem;
    }

    .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 2rem;
    }

    .footer-section {
        margin-bottom: 2rem;
    }

    .footer-title {
        color: var(--primary-color);
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        position: relative;
        padding-bottom: 0.5rem;
    }

    .footer-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 50px;
        height: 3px;
        background-color: var(--primary-color);
        border-radius: 2px;
    }

    .footer-about p {
        color: #e9ecef;
        line-height: 1.6;
        margin-bottom: 1rem;
    }

    .footer-links {
        list-style: none;
        padding: 0;
    }

    .footer-links li {
        margin-bottom: 0.75rem;
    }

    .footer-links a {
        color: #e9ecef;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .footer-links a:hover {
        color: var(--primary-color);
        transform: translateX(5px);
    }

    .footer-links i {
        font-size: 0.9rem;
    }

    .contact-info {
        list-style: none;
        padding: 0;
    }

    .contact-info li {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1rem;
        color: #e9ecef;
    }

    .contact-info i {
        color: var(--primary-color);
        font-size: 1.2rem;
    }

    .payment-methods {
        display: flex;
        flex-wrap: wrap;
        gap: 1rem;
        margin-top: 1.5rem;
    }

    .payment-method {
        background-color: white;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
    }

    .payment-method:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .payment-method i {
        color: var(--primary-color);
        font-size: 1.2rem;
    }

    .footer-bottom {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .footer-bottom p {
        color: #adb5bd;
        margin: 0;
    }

    .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1.5rem;
        justify-content: center;
    }

    .social-link {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: rgba(255, 255, 255, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        transition: all 0.3s ease;
    }

    .social-link:hover {
        background-color: var(--primary-color);
        transform: translateY(-3px);
    }

    @media (max-width: 768px) {
        .footer-content {
            grid-template-columns: 1fr;
            text-align: center;
        }

        .footer-title::after {
            left: 50%;
            transform: translateX(-50%);
        }

        .footer-links a {
            justify-content: center;
        }

        .contact-info li {
            justify-content: center;
        }

        .payment-methods {
            justify-content: center;
        }
    }
</style>

<footer class="footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3 class="footer-title">About Us</h3>
            <div class="footer-about">
                <p>Your one-stop destination for all your shopping needs. We offer a wide range of products with exceptional quality and service.</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Quick Links</h3>
            <ul class="footer-links">
                <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="products.jsp?category=stationary"><i class="fas fa-pen"></i> Stationary & Office</a></li>
                <li><a href="products.jsp?category=groceries"><i class="fas fa-shopping-basket"></i> Groceries</a></li>
                <li><a href="products.jsp?category=household"><i class="fas fa-home"></i> Household Supplies</a></li>
                <li><a href="products.jsp?category=electronics"><i class="fas fa-laptop"></i> Electronics</a></li>
                <li><a href="contact.jsp"><i class="fas fa-envelope"></i> Contact Us</a></li>
            </ul>
        </div>

        <div class="footer-section">
            <h3 class="footer-title">Contact Info</h3>
            <ul class="contact-info">
                <li><i class="fas fa-envelope"></i> support@supermart.com</li>
                <li><i class="fas fa-phone"></i> +1 234 567 890</li>
                <li><i class="fas fa-map-marker-alt"></i> 123 Shopping Street, Retail City</li>
            </ul>
            <h3 class="footer-title" style="margin-top: 2rem;">Payment Methods</h3>
            <div class="payment-methods">
                <div class="payment-method">
                    <i class="fab fa-cc-visa"></i>
                    <span>Visa</span>
                </div>
                <div class="payment-method">
                    <i class="fas fa-money-bill-wave"></i>
                    <span>IME</span>
                </div>
                <div class="payment-method">
                    <i class="fas fa-wallet"></i>
                    <span>Khalti</span>
                </div>
                <div class="payment-method">
                    <i class="fas fa-mobile-alt"></i>
                    <span>eSewa</span>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; 2024 SuperMart. All rights reserved.</p>
    </div>
</footer> 