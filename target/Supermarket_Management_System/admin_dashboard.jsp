<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.supermarket.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SuperMart</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            animation: fadeIn 0.5s ease-out;
        }

        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #4f46e5;
            letter-spacing: -0.5px;
        }

        .home-btn {
            padding: 0.75rem 1.5rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            margin-right: 1rem;
        }

        .home-btn:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.1);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .refresh-btn {
            padding: 0.75rem 1.5rem;
            background-color: #4f46e5;
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .refresh-btn:hover {
            background-color: #4338ca;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.1);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            animation: fadeIn 0.5s ease-out;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.2s;
            border: 1px solid #e5e7eb;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }

        .stat-title {
            color: #6b7280;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            color: #111827;
            font-size: 1.875rem;
            font-weight: 600;
        }

        .stat-icon {
            width: 2.5rem;
            height: 2.5rem;
            background-color: #4f46e5;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .stat-icon svg {
            width: 1.5rem;
            height: 1.5rem;
            color: white;
        }

        /* User Management Styles */
        .user-management {
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-top: 2rem;
            animation: fadeIn 0.5s ease-out;
            border: 1px solid #e5e7eb;
        }

        .user-management-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .user-management-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: #4f46e5;
            letter-spacing: -0.5px;
        }

        .user-count {
            margin: 1rem 0;
            font-size: 1.1rem;
            font-weight: 500;
            color: #4f46e5;
            padding: 0.5rem 1rem;
            background: #f3f4f6;
            border-radius: 0.5rem;
            display: inline-block;
        }

        .user-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 1rem;
        }

        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.25rem;
            background: #f8f9fa;
            border-radius: 0.75rem;
            transition: all 0.2s;
            border: 1px solid #e5e7eb;
        }

        .user-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            background: #f1f5f9;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .user-name {
            font-weight: 600;
            color: #1f2937;
            font-size: 1.1rem;
        }

        .user-email {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .user-phone {
            color: #6b7280;
            font-size: 0.875rem;
        }

        .delete-btn {
            padding: 0.75rem 1.25rem;
            background-color: #ef4444;
            color: white;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .delete-btn:hover {
            background-color: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(239, 68, 68, 0.1);
        }

        .delete-btn i {
            font-size: 0.875rem;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 2rem;
            border-radius: 1rem;
            max-width: 500px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            animation: slideIn 0.3s ease-out;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .user-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            flex: 1;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
        }

        .btn-danger {
            background-color: #f3f4f6;
            color: #374151;
            border: 1px solid #e5e7eb;
        }

        .btn-danger:hover {
            background-color: #e5e7eb;
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from { 
                opacity: 0; 
                transform: translateY(20px); 
            }
            to { 
                opacity: 1; 
                transform: translateY(0); 
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="dashboard-header">
            <h1 class="dashboard-title">Admin Dashboard</h1>
            <div class="header-actions">
                <a href="../index.jsp" class="home-btn">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <button class="refresh-btn" onclick="refreshDashboard()">
                    <i class="fas fa-sync-alt"></i>
                    Refresh
                </button>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                    </svg>
                </div>
                <div class="stat-title">Total Users</div>
                <div class="stat-value" id="totalUsers">0</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                    </svg>
                </div>
                <div class="stat-title">Total Products</div>
                <div class="stat-value" id="totalProducts">0</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                    </svg>
                </div>
                <div class="stat-title">Total Sales</div>
                <div class="stat-value" id="totalSales">0</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                    </svg>
                </div>
                <div class="stat-title">Total Revenue</div>
                <div class="stat-value" id="totalRevenue">$0.00</div>
            </div>
        </div>

        <!-- User Management Section -->
        <div class="user-management">
            <div class="user-management-header">
                <h2>User Management</h2>
                <button class="btn-primary" onclick="showAddUserModal()">
                    <i class="fas fa-plus"></i> Add New User
                </button>
            </div>
            <div class="user-count">Total Users: <span id="userCount">0</span></div>
            <div id="userList" class="user-list">
                <!-- User items will be dynamically added here -->
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <h3>Add New User</h3>
            <form id="addUserForm">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Phone</label>
                    <input type="tel" class="form-control" name="phone">
                </div>
                <div class="user-actions">
                    <button type="button" class="btn btn-primary" onclick="addUser()">Add User</button>
                    <button type="button" class="btn btn-danger" onclick="hideAddUserModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <h3>Edit User</h3>
            <form id="editUserForm">
                <input type="hidden" name="userId">
                <div class="form-group">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Phone</label>
                    <input type="tel" class="form-control" name="phone">
                </div>
                <div class="user-actions">
                    <button type="button" class="btn btn-primary" onclick="updateUser()">Save Changes</button>
                    <button type="button" class="btn btn-danger" onclick="hideEditUserModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Add context path variable
        const contextPath = '${pageContext.request.contextPath}';
        
        // Stats update functions
        function updateStats() {
            // Get total sales from localStorage
            const totalSales = parseInt(localStorage.getItem('totalSales')) || 0;
            document.getElementById('totalSales').textContent = totalSales;

            // Calculate total revenue (assuming average order value of $50)
            const totalRevenue = totalSales * 50;
            document.getElementById('totalRevenue').textContent = '$' + totalRevenue.toFixed(2);

            // Get total users from session
            fetch(contextPath + '/admin?action=getStats')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalUsers').textContent = data.totalUsers || '0';
                    document.getElementById('totalProducts').textContent = data.totalProducts || '0';
                })
                .catch(error => {
                    console.error('Error fetching stats:', error);
                });
        }

        function refreshStats() {
            updateStats();
            loadUsers();
        }

        // User Management Functions
        function loadUsers() {
            console.log('Fetching users from server...');
            fetch(contextPath + '/admin?action=getUsers')
                .then(response => {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(users => {
                    console.log('Raw user data received:', JSON.stringify(users, null, 2));
                    const userList = document.getElementById('userList');
                    const userCount = document.getElementById('userCount');
                    
                    if (!Array.isArray(users)) {
                        console.error('Expected array of users but got:', users);
                        return;
                    }
                    
                    userCount.textContent = users.length;
                    
                    // Clear existing content
                    userList.innerHTML = '';
                    
                    // Add each user to the list
                    users.forEach((user, index) => {
                        const userElement = document.createElement('div');
                        userElement.className = 'user-item';
                        userElement.setAttribute('data-user-id', user.user_id);
                        
                        const userInfo = document.createElement('div');
                        userInfo.className = 'user-info';
                        
                        const userNameSpan = document.createElement('span');
                        userNameSpan.className = 'user-name';
                        userNameSpan.textContent = user.username;
                        
                        const userEmailSpan = document.createElement('span');
                        userEmailSpan.className = 'user-email';
                        userEmailSpan.textContent = user.user_email;
                        
                        const userPhoneSpan = document.createElement('span');
                        userPhoneSpan.className = 'user-phone';
                        userPhoneSpan.textContent = user.phone || 'No phone number';
                        
                        userInfo.appendChild(userNameSpan);
                        userInfo.appendChild(userEmailSpan);
                        userInfo.appendChild(userPhoneSpan);
                        
                        const deleteButton = document.createElement('button');
                        deleteButton.className = 'delete-btn';
                        deleteButton.innerHTML = '<i class="fas fa-trash"></i> Delete';
                        deleteButton.onclick = function() {
                            console.log('Delete button clicked for user:', user.user_id);
                            deleteUser(user.user_id);
                        };
                        
                        userElement.appendChild(userInfo);
                        userElement.appendChild(deleteButton);
                        userList.appendChild(userElement);
                    });
                })
                .catch(error => {
                    console.error('Error loading users:', error);
                    document.getElementById('userList').innerHTML = '<div class="alert alert-danger">Error loading users: ' + error.message + '</div>';
                });
        }

        function showAddUserModal() {
            document.getElementById('addUserModal').style.display = 'block';
        }

        function hideAddUserModal() {
            document.getElementById('addUserModal').style.display = 'none';
            document.getElementById('addUserForm').reset();
        }

        function showEditUserModal() {
            document.getElementById('editUserModal').style.display = 'block';
        }

        function hideEditUserModal() {
            document.getElementById('editUserModal').style.display = 'none';
            document.getElementById('editUserForm').reset();
        }

        function addUser() {
            const form = document.getElementById('addUserForm');
            const formData = new FormData(form);
            const data = Object.fromEntries(formData.entries());

            fetch(contextPath + '/admin?action=addUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    hideAddUserModal();
                    loadUsers();
                    updateStats();
                } else {
                    alert('Error adding user: ' + result.message);
                }
            });
        }

        function editUser(userId) {
            if (!userId) {
                console.error('No user ID provided for editing');
                return;
            }
            
            fetch(contextPath + '/admin?action=getUser&userId=' + userId)
                .then(response => response.json())
                .then(user => {
                    const form = document.getElementById('editUserForm');
                    form.userId.value = user.user_id;
                    form.username.value = user.username;
                    form.email.value = user.user_email;
                    form.phone.value = user.phone || '';
                    showEditUserModal();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error loading user details for editing');
                });
        }

        function updateUser() {
            const form = document.getElementById('editUserForm');
            const formData = new FormData(form);
            const data = Object.fromEntries(formData.entries());

            fetch(contextPath + '/admin?action=updateUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    hideEditUserModal();
                    loadUsers();
                } else {
                    alert('Error updating user: ' + result.message);
                }
            });
        }

        function deleteUser(userId) {
            console.log('Attempting to delete user with ID:', userId);
            if (!userId) {
                console.error('No user ID provided for deletion');
                alert('Error: No user ID provided');
                return;
            }
            
            if (confirm('Are you sure you want to delete this user?')) {
                fetch(contextPath + '/admin?action=deleteUser&userId=' + userId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(result => {
                    console.log('Delete response:', result);
                    if (result.success) {
                        // Remove the user item from the UI
                        const userItem = document.querySelector(`.user-item[data-user-id="${userId}"]`);
                        if (userItem) {
                            userItem.remove();
                        }
                        // Update the user count
                        const userCount = document.getElementById('userCount');
                        userCount.textContent = parseInt(userCount.textContent) - 1;
                        // Refresh the stats
                        updateStats();
                    } else {
                        alert('Error deleting user: ' + result.message);
                    }
                })
                .catch(error => {
                    console.error('Error during delete operation:', error);
                    alert('Error deleting user: ' + error.message);
                });
            }
        }

        // Call this when the page loads
        window.onload = function() {
            console.log('Page loading...');
            // Load initial data
            updateStats();
            loadUsers();
        };
    </script>
</body>
</html> 