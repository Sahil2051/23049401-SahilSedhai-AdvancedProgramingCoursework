package Model;

public class Supplier {
    private int supplierId;
    private String supplierName;
    private String supplierContact;
    private String supplierEmail;
    private String supplierAddress;
    
    public Supplier() {}
    
    public Supplier(int supplierId, String supplierName, String supplierContact, 
                   String supplierEmail, String supplierAddress) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.supplierContact = supplierContact;
        this.supplierEmail = supplierEmail;
        this.supplierAddress = supplierAddress;
    }
    
    // Getters and Setters
    public int getSupplierId() { return supplierId; }
    public void setSupplierId(int supplierId) { this.supplierId = supplierId; }
    
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    
    public String getSupplierContact() { return supplierContact; }
    public void setSupplierContact(String supplierContact) { this.supplierContact = supplierContact; }
    
    public String getSupplierEmail() { return supplierEmail; }
    public void setSupplierEmail(String supplierEmail) { this.supplierEmail = supplierEmail; }
    
    public String getSupplierAddress() { return supplierAddress; }
    public void setSupplierAddress(String supplierAddress) { this.supplierAddress = supplierAddress; }
    
    // Business Logic Methods
    public boolean isValidEmail() {
        return supplierEmail != null && supplierEmail.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    public void print() {
        System.out.println("Supplier Details:");
        System.out.println("ID: " + supplierId);
        System.out.println("Name: " + supplierName);
        System.out.println("Contact: " + supplierContact);
        System.out.println("Email: " + supplierEmail);
        System.out.println("Address: " + supplierAddress);
    }
}
