package Model;

import java.util.Date;

public class Product {
    private int productId;
    private String productName;
    private double productPrice;
    private Date expirationDate;
    private Category category;
    private Supplier supplier;
    private Inventory inventory;
    
    public Product() {}
    
    public Product(int productId, String productName, double productPrice, 
                  Date expirationDate, Category category, Supplier supplier) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.expirationDate = expirationDate;
        this.category = category;
        this.supplier = supplier;
    }
    
    // Getters and Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    
    public double getProductPrice() { return productPrice; }
    public void setProductPrice(double productPrice) { 
        if (productPrice < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
        this.productPrice = productPrice; 
    }
    
    public Date getExpirationDate() { return expirationDate; }
    public void setExpirationDate(Date expirationDate) { this.expirationDate = expirationDate; }
    
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    
    public Supplier getSupplier() { return supplier; }
    public void setSupplier(Supplier supplier) { this.supplier = supplier; }
    
    public Inventory getInventory() { return inventory; }
    public void setInventory(Inventory inventory) { this.inventory = inventory; }
    
    // Business Logic Methods
    public boolean isExpired() {
        return expirationDate != null && expirationDate.before(new Date());
    }
    
    public boolean isInStock() {
        return inventory != null && inventory.getProductQuantity() > 0;
    }
    
    public void print() {
        System.out.println("Product Details:");
        System.out.println("ID: " + productId);
        System.out.println("Name: " + productName);
        System.out.println("Price: $" + productPrice);
        System.out.println("Expiration Date: " + expirationDate);
        if (category != null) {
            System.out.println("Category: " + category.getCategoryName());
        }
        if (supplier != null) {
            System.out.println("Supplier: " + supplier.getSupplierName());
        }
        if (inventory != null) {
            System.out.println("Quantity in Stock: " + inventory.getProductQuantity());
        }
    }
}
