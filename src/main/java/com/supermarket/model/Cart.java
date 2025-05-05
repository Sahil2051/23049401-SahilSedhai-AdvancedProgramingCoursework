package com.supermarket.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int userId;
    private List<CartItem> items;
    private double totalAmount;

    public Cart(int userId) {
        this.userId = userId;
        this.items = new ArrayList<>();
        this.totalAmount = 0.0;
    }

    public void addItem(CartItem item) {
        // Check if item already exists in cart
        for (CartItem existingItem : items) {
            if (existingItem.getProductName().equals(item.getProductName())) {
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                updateTotalAmount();
                return;
            }
        }
        items.add(item);
        updateTotalAmount();
    }

    public void removeItem(String productName) {
        items.removeIf(item -> item.getProductName().equals(productName));
        updateTotalAmount();
    }

    public void updateQuantity(String productName, int quantity) {
        for (CartItem item : items) {
            if (item.getProductName().equals(productName)) {
                item.setQuantity(quantity);
                break;
            }
        }
        updateTotalAmount();
    }

    private void updateTotalAmount() {
        totalAmount = items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
        updateTotalAmount();
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public int getItemCount() {
        return items.stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    public void clear() {
        items.clear();
        totalAmount = 0.0;
    }
} 