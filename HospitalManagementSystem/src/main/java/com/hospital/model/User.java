package com.hospital.model;

/**
 * User Model - Represents a patient in the system
 * This class stores patient information
 */
public class User {
    // Private variables (encapsulation)
    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String address;
    private String city;
    
    // Default Constructor (empty)
    public User() {
    }
    
    // Constructor with all fields
    public User(int userId, String fullName, String email, String password, 
                String phone, String address, String city) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.city = city;
    }
    
    // Getters and Setters (to access private variables)
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
}