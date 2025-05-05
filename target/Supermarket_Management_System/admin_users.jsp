<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .user-card {
            transition: transform 0.2s;
        }
        .user-card:hover {
            transform: translateY(-5px);
        }
        .action-buttons {
            opacity: 0;
            transition: opacity 0.2s;
        }
        .user-card:hover .action-buttons {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="admin_dashboard.jsp">
                                <i class="fas fa-chart-line me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white active" href="admin_users.jsp">
                                <i class="fas fa-users me-2"></i>Users
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">User Management</h1>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="fas fa-plus"></i> Add New User
                    </button>
                </div>

                <!-- User List -->
                <div class="row" id="userList">
                    <!-- Users will be loaded here dynamically -->
                </div>
            </main>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addUserForm">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phone">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="addUser()">Add User</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editUserForm">
                        <input type="hidden" name="userId">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phone">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="updateUser()">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Load users on page load
        document.addEventListener('DOMContentLoaded', loadUsers);

        function loadUsers() {
            fetch('admin?action=getUsers')
                .then(response => response.json())
                .then(users => {
                    const userList = document.getElementById('userList');
                    userList.innerHTML = users.map(user => `
                        <div class="col-md-4 mb-4">
                            <div class="card user-card">
                                <div class="card-body">
                                    <h5 class="card-title">${user.username}</h5>
                                    <p class="card-text">
                                        <i class="fas fa-envelope"></i> ${user.user_email}<br>
                                        <i class="fas fa-phone"></i> ${user.phone || 'N/A'}
                                    </p>
                                    <div class="action-buttons">
                                        <button class="btn btn-sm btn-info me-2" onclick="viewUser(${user.user_id})">
                                            <i class="fas fa-eye"></i> View
                                        </button>
                                        <button class="btn btn-sm btn-warning me-2" onclick="editUser(${user.user_id})">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="btn btn-sm btn-danger" onclick="deleteUser(${user.user_id})">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `).join('');
                });
        }

        function addUser() {
            const form = document.getElementById('addUserForm');
            const formData = new FormData(form);
            const data = Object.fromEntries(formData.entries());

            fetch('admin?action=addUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    bootstrap.Modal.getInstance(document.getElementById('addUserModal')).hide();
                    form.reset();
                    loadUsers();
                } else {
                    alert('Error adding user: ' + result.message);
                }
            });
        }

        function editUser(userId) {
            fetch(`admin?action=getUser&userId=${userId}`)
                .then(response => response.json())
                .then(user => {
                    const form = document.getElementById('editUserForm');
                    form.userId.value = user.user_id;
                    form.username.value = user.username;
                    form.email.value = user.user_email;
                    form.phone.value = user.phone || '';
                    
                    new bootstrap.Modal(document.getElementById('editUserModal')).show();
                });
        }

        function updateUser() {
            const form = document.getElementById('editUserForm');
            const formData = new FormData(form);
            const data = Object.fromEntries(formData.entries());

            fetch('admin?action=updateUser', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success) {
                    bootstrap.Modal.getInstance(document.getElementById('editUserModal')).hide();
                    loadUsers();
                } else {
                    alert('Error updating user: ' + result.message);
                }
            });
        }

        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                fetch(`admin?action=deleteUser&userId=${userId}`, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(result => {
                    if (result.success) {
                        loadUsers();
                    } else {
                        alert('Error deleting user: ' + result.message);
                    }
                });
            }
        }

        function viewUser(userId) {
            fetch(`admin?action=getUser&userId=${userId}`)
                .then(response => response.json())
                .then(user => {
                    alert(`User Details:\nUsername: ${user.username}\nEmail: ${user.user_email}\nPhone: ${user.phone || 'N/A'}`);
                });
        }
    </script>
</body>
</html> 