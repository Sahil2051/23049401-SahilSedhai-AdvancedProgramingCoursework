package Model;

public class Category {
    private int categoryId;
    private String categoryName;
    private String categoryDescription;
    private String department;
    private CategoryLocation location;
    
    public Category() {}
    
    public Category(int categoryId, String categoryName, String categoryDescription, 
                    String department, CategoryLocation location) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryDescription = categoryDescription;
        this.department = department;
        this.location = location;
    }
    
    // Getters and Setters
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public String getCategoryDescription() { return categoryDescription; }
    public void setCategoryDescription(String categoryDescription) { 
        this.categoryDescription = categoryDescription; 
    }
    
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    public CategoryLocation getLocation() { return location; }
    public void setLocation(CategoryLocation location) { this.location = location; }
    
    // Business Logic Methods
    public void print() {
        System.out.println("Category Details:");
        System.out.println("ID: " + categoryId);
        System.out.println("Name: " + categoryName);
        System.out.println("Description: " + categoryDescription);
        System.out.println("Department: " + department);
        if (location != null) {
            System.out.println("Shelf Location: " + location.getShelfLocation());
        }
    }
}
