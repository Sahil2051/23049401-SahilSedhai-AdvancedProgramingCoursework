package Model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Sale {
    private int saleId;
    private Date saleDate;
    private double totalAmount;
    private Customer customer;
    private User user;
    private List<SaleItem> saleItems;
    
    public Sale() {
        this.saleItems = new ArrayList<>();
    }
    
    public Sale(int saleId, Date saleDate, double totalAmount, 
                Customer customer, User user) {
        this.saleId = saleId;
        this.saleDate = saleDate;
        this.totalAmount = totalAmount;
        this.customer = customer;
        this.user = user;
        this.saleItems = new ArrayList<>();
    }
    
    // Getters and Setters
    public int getSaleId() { return saleId; }
    public void setSaleId(int saleId) { this.saleId = saleId; }
    
    public Date getSaleDate() { return saleDate; }
    public void setSaleDate(Date saleDate) { this.saleDate = saleDate; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { 
        if (totalAmount < 0) {
            throw new IllegalArgumentException("Total amount cannot be negative");
        }
        this.totalAmount = totalAmount; 
    }
    
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    
    public List<SaleItem> getSaleItems() { return saleItems; }
    public void setSaleItems(List<SaleItem> saleItems) { this.saleItems = saleItems; }
    
    // Business Logic Methods
    public void addSaleItem(SaleItem item) {
        if (item != null) {
            saleItems.add(item);
            calculateTotal();
        }
    }
    
    public void removeSaleItem(SaleItem item) {
        if (item != null) {
            saleItems.remove(item);
            calculateTotal();
        }
    }
    
    private void calculateTotal() {
        totalAmount = saleItems.stream()
            .mapToDouble(item -> item.getQuantity() * item.getUnitPrice())
            .sum();
    }
    
    public void print() {
        System.out.println("Sale Details:");
        System.out.println("ID: " + saleId);
        System.out.println("Date: " + saleDate);
        System.out.println("Total Amount: $" + totalAmount);
        if (customer != null) {
            System.out.println("Customer: " + customer.getCustomerName());
        }
        if (user != null) {
            System.out.println("Processed by: " + user.getUsername());
        }
        System.out.println("Items:");
        for (SaleItem item : saleItems) {
            item.print();
        }
    }
}
