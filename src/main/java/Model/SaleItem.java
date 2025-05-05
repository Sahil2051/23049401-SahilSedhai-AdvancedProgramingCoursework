package Model;

public class SaleItem {
    private int saleItemId;
    private Sale sale;
    private Product product;
    private int quantity;
    private double unitPrice;
    
    public SaleItem() {}
    
    public SaleItem(int saleItemId, Sale sale, Product product, 
                    int quantity, double unitPrice) {
        this.saleItemId = saleItemId;
        this.sale = sale;
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }
    
    // Getters and Setters
    public int getSaleItemId() { return saleItemId; }
    public void setSaleItemId(int saleItemId) { this.saleItemId = saleItemId; }
    
    public Sale getSale() { return sale; }
    public void setSale(Sale sale) { this.sale = sale; }
    
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        if (quantity < 0) {
            throw new IllegalArgumentException("Quantity cannot be negative");
        }
        this.quantity = quantity; 
    }
    
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { 
        if (unitPrice < 0) {
            throw new IllegalArgumentException("Unit price cannot be negative");
        }
        this.unitPrice = unitPrice; 
    }
    
    // Business Logic Methods
    public double getSubtotal() {
        return quantity * unitPrice;
    }
    
    public void print() {
        System.out.println("Sale Item Details:");
        System.out.println("ID: " + saleItemId);
        if (product != null) {
            System.out.println("Product: " + product.getProductName());
        }
        System.out.println("Quantity: " + quantity);
        System.out.println("Unit Price: $" + unitPrice);
        System.out.println("Subtotal: $" + getSubtotal());
    }
}
