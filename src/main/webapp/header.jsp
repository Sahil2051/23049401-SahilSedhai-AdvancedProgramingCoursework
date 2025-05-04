<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.supermarket.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isGuest = user != null && user.getId() == 0;
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
            <span class="cart-count">3</span>
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
                <a href="profile.jsp" class="btn btn-outline">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    Profile
                </a>
                <a href="logout" class="btn btn-primary">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                        <polyline points="16 17 21 12 16 7"></polyline>
                        <line x1="21" y1="12" x2="9" y2="12"></line>
                    </svg>
                    Logout
                </a>
            <% } %>
        </div>
    </div>
</nav> 