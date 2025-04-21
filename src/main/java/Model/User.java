package Model;

public class User {
    private int userId;
    private String username;
    private String userEmail;
    private String phone;
    private Role role;
    
    public User() {}
    
    public User(int userId, String username, String userEmail, 
                String phone, Role role) {
        this.userId = userId;
        this.username = username;
        this.userEmail = userEmail;
        this.phone = phone;
        this.role = role;
    }
    
    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    
    // Business Logic Methods
    public boolean isValidPhone() {
        return phone != null && phone.matches("^\\+?[0-9]{10,}$");
    }
    
    public boolean isValidEmail() {
        return userEmail != null && userEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    public void print() {
        System.out.println("User Details:");
        System.out.println("ID: " + userId);
        System.out.println("Username: " + username);
        System.out.println("Email: " + userEmail);
        System.out.println("Phone: " + phone);
        if (role != null) {
            System.out.println("Role: " + role.getRoleName());
        }
    }
}
