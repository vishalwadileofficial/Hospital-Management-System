package com.hospital.dao;

import com.hospital.model.Doctor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DoctorDAO - Handles all database operations for Doctor
 */
public class DoctorDAO {
    
    /**
     * Get all doctors
     * @return List of all doctors
     */
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT d.*, dept.dept_name FROM doctors d " +
                        "LEFT JOIN departments dept ON d.dept_id = dept.dept_id";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                Doctor doctor = extractDoctorFromResultSet(rs);
                doctors.add(doctor);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return doctors;
    }
    
    /**
     * Get doctors by city
     * @param city City name
     * @return List of doctors in that city
     */
    public List<Doctor> getDoctorsByCity(String city) {
        List<Doctor> doctors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT d.*, dept.dept_name FROM doctors d " +
                        "LEFT JOIN departments dept ON d.dept_id = dept.dept_id " +
                        "WHERE d.city = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, city);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Doctor doctor = extractDoctorFromResultSet(rs);
                doctors.add(doctor);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return doctors;
    }
    
    /**
     * Get doctors by department
     * @param deptId Department ID
     * @return List of doctors in that department
     */
    public List<Doctor> getDoctorsByDepartment(int deptId) {
        List<Doctor> doctors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT d.*, dept.dept_name FROM doctors d " +
                        "LEFT JOIN departments dept ON d.dept_id = dept.dept_id " +
                        "WHERE d.dept_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Doctor doctor = extractDoctorFromResultSet(rs);
                doctors.add(doctor);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return doctors;
    }
    
    /**
     * Get doctors by city and department
     * @param city City name
     * @param deptId Department ID
     * @return List of doctors matching criteria
     */
    public List<Doctor> getDoctorsByCityAndDept(String city, int deptId) {
        List<Doctor> doctors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT d.*, dept.dept_name FROM doctors d " +
                        "LEFT JOIN departments dept ON d.dept_id = dept.dept_id " +
                        "WHERE d.city = ? AND d.dept_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, city);
            pstmt.setInt(2, deptId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Doctor doctor = extractDoctorFromResultSet(rs);
                doctors.add(doctor);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return doctors;
    }
    
    /**
     * Get doctor by ID
     * @param doctorId Doctor ID
     * @return Doctor object
     */
    public Doctor getDoctorById(int doctorId) {
        Doctor doctor = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT d.*, dept.dept_name FROM doctors d " +
                        "LEFT JOIN departments dept ON d.dept_id = dept.dept_id " +
                        "WHERE d.doctor_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, doctorId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                doctor = extractDoctorFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return doctor;
    }
    
    /**
     * Add new doctor (Admin function)
     * @param doctor Doctor object
     * @return true if successful
     */
    public boolean addDoctor(Doctor doctor) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO doctors (doctor_name, specialization, dept_id, city, " +
                        "phone, email, qualification, experience, consultation_fee, " +
                        "available_days, available_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, doctor.getDoctorName());
            pstmt.setString(2, doctor.getSpecialization());
            pstmt.setInt(3, doctor.getDeptId());
            pstmt.setString(4, doctor.getCity());
            pstmt.setString(5, doctor.getPhone());
            pstmt.setString(6, doctor.getEmail());
            pstmt.setString(7, doctor.getQualification());
            pstmt.setInt(8, doctor.getExperience());
            pstmt.setDouble(9, doctor.getConsultationFee());
            pstmt.setString(10, doctor.getAvailableDays());
            pstmt.setString(11, doctor.getAvailableTime());
            
            int rowsAffected = pstmt.executeUpdate();
            success = (rowsAffected > 0);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    /**
     * Helper method to extract Doctor object from ResultSet
     */
    private Doctor extractDoctorFromResultSet(ResultSet rs) throws SQLException {
        Doctor doctor = new Doctor();
        doctor.setDoctorId(rs.getInt("doctor_id"));
        doctor.setDoctorName(rs.getString("doctor_name"));
        doctor.setSpecialization(rs.getString("specialization"));
        doctor.setDeptId(rs.getInt("dept_id"));
        doctor.setDeptName(rs.getString("dept_name"));
        doctor.setCity(rs.getString("city"));
        doctor.setPhone(rs.getString("phone"));
        doctor.setEmail(rs.getString("email"));
        doctor.setQualification(rs.getString("qualification"));
        doctor.setExperience(rs.getInt("experience"));
        doctor.setConsultationFee(rs.getDouble("consultation_fee"));
        doctor.setAvailableDays(rs.getString("available_days"));
        doctor.setAvailableTime(rs.getString("available_time"));
        return doctor;
    }
}