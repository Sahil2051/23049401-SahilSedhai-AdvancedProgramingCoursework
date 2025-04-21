package Model;

public class Customer {
    private int customerId;
    private String customerName;
    private String contactInfo;
    private String customerEmail;
    private String customerAddress;
    
    public Customer() {}
    
    public Customer(int customerId, String customerName, String contactInfo, 
                   String customerEmail, String customerAddress) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.contactInfo = contactInfo;
        this.customerEmail = customerEmail;
        this.customerAddress = customerAddress;
    }
    
    // Getters and Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }
    
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
    
    public String getCustomerAddress() { return customerAddress; }
    public void setCustomerAddress(String customerAddress) { this.customerAddress = customerAddress; }
    
    // Business Logic Methods
    public boolean isValidEmail() {
        return customerEmail != null && customerEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    public void print() {
        System.out.println("Customer Details:");
        System.out.println("ID: " + customerId);
        System.out.println("Name: " + customerName);
        System.out.println("Contact: " + contactInfo);
        System.out.println("Email: " + customerEmail);
        System.out.println("Address: " + customerAddress);
    }
}
