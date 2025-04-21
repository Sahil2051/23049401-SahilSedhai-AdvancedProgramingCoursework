package Model;

public class CategoryLocation {
    private Category category;
    private String shelfLocation;
    
    public CategoryLocation() {}
    
    public CategoryLocation(Category category, String shelfLocation) {
        this.category = category;
        this.shelfLocation = shelfLocation;
    }
    
    // Getters and Setters
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
    
    public String getShelfLocation() { return shelfLocation; }
    public void setShelfLocation(String shelfLocation) { this.shelfLocation = shelfLocation; }
    
    // Business Logic Methods
    public void print() {
        System.out.println("Category Location:");
        if (category != null) {
            System.out.println("Category: " + category.getCategoryName());
        }
        System.out.println("Shelf Location: " + shelfLocation);
    }
}
