package Model;

public class Inventory {
    private Product product;
    private int productQuantity;
    
    public Inventory() {}
    
    public Inventory(Product product, int productQuantity) {
        this.product = product;
        this.productQuantity = productQuantity;
    }
    
    // Getters and Setters
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    
    public int getProductQuantity() { return productQuantity; }
    public void setProductQuantity(int productQuantity) { 
        if (productQuantity < 0) {
            throw new IllegalArgumentException("Quantity cannot be negative");
        }
        this.productQuantity = productQuantity; 
    }
    
    // Business Logic Methods
    public void addStock(int quantity) {
        if (quantity < 0) {
            throw new IllegalArgumentException("Cannot add negative quantity");
        }
        this.productQuantity += quantity;
    }
    
    public void removeStock(int quantity) {
        if (quantity < 0) {
            throw new IllegalArgumentException("Cannot remove negative quantity");
        }
        if (quantity > productQuantity) {
            throw new IllegalArgumentException("Insufficient stock");
        }
        this.productQuantity -= quantity;
    }
    
    public void print() {
        System.out.println("Inventory Details:");
        if (product != null) {
            System.out.println("Product: " + product.getProductName());
        }
        System.out.println("Quantity: " + productQuantity);
    }
}
