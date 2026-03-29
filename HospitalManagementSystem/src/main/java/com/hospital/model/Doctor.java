package com.hospital.model;

/**
 * Doctor Model - Represents a doctor in the system
 */
public class Doctor {
    private int doctorId;
    private String doctorName;
    private String specialization;
    private int deptId;
    private String deptName; // For display purposes
    private String city;
    private String phone;
    private String email;
    private String qualification;
    private int experience;
    private double consultationFee;
    private String availableDays;
    private String availableTime;
    
    // Default Constructor
    public Doctor() {
    }
    
    // Constructor with essential fields
    public Doctor(int doctorId, String doctorName, String specialization, 
                  String city, String phone, String qualification, int experience) {
        this.doctorId = doctorId;
        this.doctorName = doctorName;
        this.specialization = specialization;
        this.city = city;
        this.phone = phone;
        this.qualification = qualification;
        this.experience = experience;
    }
    
    // Getters and Setters
    public int getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    
    public String getDoctorName() {
        return doctorName;
    }
    
    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
    
    public String getSpecialization() {
        return specialization;
    }
    
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
    
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
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getQualification() {
        return qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
    
    public int getExperience() {
        return experience;
    }
    
    public void setExperience(int experience) {
        this.experience = experience;
    }
    
    public double getConsultationFee() {
        return consultationFee;
    }
    
    public void setConsultationFee(double consultationFee) {
        this.consultationFee = consultationFee;
    }
    
    public String getAvailableDays() {
        return availableDays;
    }
    
    public void setAvailableDays(String availableDays) {
        this.availableDays = availableDays;
    }
    
    public String getAvailableTime() {
        return availableTime;
    }
    
    public void setAvailableTime(String availableTime) {
        this.availableTime = availableTime;
    }
}