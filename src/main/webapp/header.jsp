<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.supermarket.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.model.CartItem" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isGuest = user == null;
    int cartCount = 0;
    
    if (!isGuest) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems != null) {
            cartCount = cartItems.stream()
                    .mapToInt(CartItem::getQuantity)
                    .sum();
        }
    }
%>
<link rel="stylesheet" href="css/styles.css">
<nav class="navbar">
    <a href="dashboard.jsp" class="nav-brand">SuperMart</a>
    <ul class="nav-links">
        <li><a href="dashboard.jsp">Home</a></li>
        <li><a href="category_stationary.jsp">Stationary & Office</a></li>
        <li><a href="category_groceries.jsp">Groceries</a></li>
        <li><a href="category_household.jsp">Household Supplies</a></li>
        <li><a href="category_electronics.jsp">Electronics & Appliance</a></li>
    </ul>
    <div class="nav-right">
        <div class="search-box">
            <span class="search-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </span>
            <input type="text" class="search-input" placeholder="Search Products...">
        </div>
        <a href="cart.jsp" class="cart-btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
            <span class="cart-count"><%= cartCount %></span>
        </a>
        <div class="user-actions">
            <% if (isGuest) { %>
                <a href="login.jsp" class="btn btn-primary">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
                        <polyline points="10 17 15 12 10 7"></polyline>
                        <line x1="15" y1="12" x2="3" y2="12"></line>
                    </svg>
                    Login
                </a>
            <% } else { %>
                <div class="user-profile">
                    <button class="profile-btn" onclick="toggleProfileMenu()">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        <%= user.getUsername() %>
                    </button>
                    <div class="profile-menu" id="profileMenu">
                        <a href="profile.jsp" class="menu-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                <circle cx="12" cy="7" r="4"></circle>
                            </svg>
                            My Profile
                        </a>
                        <a href="orders.jsp" class="menu-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path>
                                <line x1="3" y1="6" x2="21" y2="6"></line>
                                <path d="M16 10a4 4 0 0 1-8 0"></path>
                            </svg>
                            My Orders
                        </a>
                        <a href="wishlist.jsp" class="menu-item">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
                            </svg>
                            Wishlist
                        </a>
                        <div class="menu-divider"></div>
                        <a href="logout" class="menu-item text-danger">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                <polyline points="16 17 21 12 16 7"></polyline>
                                <line x1="21" y1="12" x2="9" y2="12"></line>
                            </svg>
                            Logout
                        </a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</nav>

<style>
    .user-profile {
        position: relative;
    }

    .profile-btn {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        background: none;
        border: 1px solid #e5e7eb;
        border-radius: 6px;
        color: #4b5563;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s;
    }

    .profile-btn:hover {
        border-color: #4f46e5;
        color: #4f46e5;
    }

    .profile-menu {
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 0.5rem;
        background: white;
        border: 1px solid #e5e7eb;
        border-radius: 8px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        min-width: 200px;
        display: none;
        z-index: 1000;
    }

    .profile-menu.show {
        display: block;
    }

    .menu-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1rem;
        color: #4b5563;
        text-decoration: none;
        transition: all 0.2s;
    }

    .menu-item:hover {
        background-color: #f3f4f6;
        color: #4f46e5;
    }

    .menu-divider {
        height: 1px;
        background-color: #e5e7eb;
        margin: 0.5rem 0;
    }

    .text-danger {
        color: #ef4444;
    }

    .text-danger:hover {
        color: #dc2626;
    }
</style>

<script>
    function toggleProfileMenu() {
        const menu = document.getElementById('profileMenu');
        menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
    }

    // Close the menu when clicking outside
    document.addEventListener('click', function(event) {
        const menu = document.getElementById('profileMenu');
        const profileBtn = document.querySelector('.profile-btn');
        if (!profileBtn.contains(event.target) && !menu.contains(event.target)) {
            menu.style.display = 'none';
        }
    });
</script> 