<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supermarket Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Auth Container -->
    <div class="auth-container">
        <a href="login.jsp" class="auth-btn login-btn">Login</a>
        <a href="register.jsp" class="auth-btn register-btn">Register</a>
        <a href="admin_login.jsp" class="auth-btn login-btn">Admin</a>
    </div>

    <div class="about-section">
        <div class="about-container">
            <h1 class="about-title">About Our <span class="highlight">Supermarket Management System</span></h1>
            <p class="about-subtitle">Streamlining supermarket operations with cutting-edge technology</p>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <h3>Inventory Management</h3>
                    <p>Efficiently track and manage your inventory with real-time updates and automated stock alerts.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-cash-register"></i>
                    </div>
                    <h3>Point of Sale</h3>
                    <p>Streamlined checkout process with integrated barcode scanning and multiple payment options.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3>Sales Analytics</h3>
                    <p>Comprehensive sales reports and analytics to help you make data-driven business decisions.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>Customer Management</h3>
                    <p>Build strong customer relationships with loyalty programs and personalized shopping experiences.</p>
                </div>
            </div>

            <div class="system-description">
                <p>Welcome to our comprehensive Supermarket Management System, a state-of-the-art solution designed to transform the way supermarkets operate in the digital age. Our system represents the perfect fusion of cutting-edge technology and practical business needs, offering a seamless experience for both store owners and customers alike. With a focus on efficiency, accuracy, and user-friendliness, we've created a platform that addresses every aspect of modern supermarket management.</p>

                <p>At the heart of our system lies a powerful inventory management module that ensures you never run out of stock or overstock items. Real-time tracking, automated reordering, and intelligent stock level predictions help you maintain the perfect balance of products. The integrated point-of-sale system streamlines the checkout process, reducing waiting times and improving customer satisfaction. Our advanced analytics tools provide valuable insights into sales patterns, customer preferences, and market trends, enabling you to make informed business decisions.</p>

                <p>Security and reliability are paramount in our design. We've implemented robust data protection measures and backup systems to ensure your business information remains safe and accessible. The system's modular architecture allows for easy customization and scalability, adapting to your supermarket's unique needs and growth trajectory. Whether you're a small neighborhood store or a large supermarket chain, our solution can be tailored to meet your specific requirements while maintaining the highest standards of performance and security.</p>
            </div>
            
            <div class="mission-statement">
                <h2>Our Mission</h2>
                <p>To revolutionize supermarket operations by providing a comprehensive, user-friendly management system that enhances efficiency, improves customer satisfaction, and drives business growth.</p>
            </div>
            
            <div class="key-benefits">
                <div class="benefit-card">
                    <h3>Increased Efficiency</h3>
                    <p>Automate routine tasks and reduce manual errors with our intuitive interface.</p>
                </div>
                <div class="benefit-card">
                    <h3>Cost Reduction</h3>
                    <p>Optimize inventory levels and reduce wastage with smart stock management.</p>
                </div>
                <div class="benefit-card">
                    <h3>Enhanced Security</h3>
                    <p>Protect your business data with advanced security features and access controls.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div class="team-container">
        <h2 class="team-title">Our Team</h2>
        <div class="team-row">
            <div class="team-member">
                <div class="member-photo">
                    <img src="images/team/sahil.jpg" alt="Sahil Sedhai">
                </div>
                <div class="member-name">Sahil Sedhai</div>
            </div>
            <div class="team-member">
                <div class="member-photo">
                    <img src="images/team/nikita.jpg" alt="Nikita Gauli">
                </div>
                <div class="member-name">Nikita Gauli</div>
            </div>
            <div class="team-member">
                <div class="member-photo">
                    <img src="images/team/aryan.jpg" alt="Aryan Gachchhadar">
                </div>
                <div class="member-name">Aryan Gachchhadar</div>
            </div>
            <div class="team-member">
                <div class="member-photo">
                    <img src="images/team/sohail.jpg" alt="Mohomad Sohail Khan">
                </div>
                <div class="member-name">Mohomad Sohail Khan</div>
            </div>
        </div>
    </div>
</body>
</html> 