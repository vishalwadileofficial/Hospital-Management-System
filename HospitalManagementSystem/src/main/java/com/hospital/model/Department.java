package com.hospital.model;

/**
 * Department Model - Represents a hospital department
 */
public class Department {
    private int deptId;
    private String deptName;
    private String description;
    private String icon;
    
    // Default Constructor
    public Department() {
    }
    
    // Constructor with fields
    public Department(int deptId, String deptName, String description, String icon) {
        this.deptId = deptId;
        this.deptName = deptName;
        this.description = description;
        this.icon = icon;
    }
    
    // Getters and Setters
    public int getDeptId() {
        return deptId;
    }
    
    public void setDeptId(int deptId) {
        this.deptId = deptId;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getIcon() {
        return icon;
    }
    
    public void setIcon(String icon) {
        this.icon = icon;
    }
}