package Model;

import java.util.Date;

public class Role {
    private int roleId;
    private String roleName;
    private String description;
    private int accessLevel;
    private Date createdDate;
    
    public Role() {}
    
    public Role(int roleId, String roleName, String description, 
                int accessLevel, Date createdDate) {
        this.roleId = roleId;
        this.roleName = roleName;
        this.description = description;
        this.accessLevel = accessLevel;
        this.createdDate = createdDate;
    }
    
    // Getters and Setters
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
    
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getAccessLevel() { return accessLevel; }
    public void setAccessLevel(int accessLevel) { this.accessLevel = accessLevel; }
    
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
    
    // Business Logic Methods
    public boolean hasAccess(int requiredLevel) {
        return accessLevel >= requiredLevel;
    }
    
    public void print() {
        System.out.println("Role Details:");
        System.out.println("ID: " + roleId);
        System.out.println("Name: " + roleName);
        System.out.println("Description: " + description);
        System.out.println("Access Level: " + accessLevel);
        System.out.println("Created Date: " + createdDate);
    }
}
