package com.hospital.dao;

import com.hospital.model.Department;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DepartmentDAO - Handles all database operations for Department
 */
public class DepartmentDAO {
    
    /**
     * Get all departments
     * @return List of all departments
     */
    public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM departments ORDER BY dept_name";
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                Department dept = new Department();
                dept.setDeptId(rs.getInt("dept_id"));
                dept.setDeptName(rs.getString("dept_name"));
                dept.setDescription(rs.getString("description"));
                dept.setIcon(rs.getString("icon"));
                departments.add(dept);
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
        
        return departments;
    }
    
    /**
     * Get department by ID
     * @param deptId Department ID
     * @return Department object
     */
    public Department getDepartmentById(int deptId) {
        Department dept = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM departments WHERE dept_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                dept = new Department();
                dept.setDeptId(rs.getInt("dept_id"));
                dept.setDeptName(rs.getString("dept_name"));
                dept.setDescription(rs.getString("description"));
                dept.setIcon(rs.getString("icon"));
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
        
        return dept;
    }
    
    /**
     * Add new department (Admin function)
     * @param dept Department object
     * @return true if successful
     */
    public boolean addDepartment(Department dept) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO departments (dept_name, description, icon) VALUES (?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dept.getDeptName());
            pstmt.setString(2, dept.getDescription());
            pstmt.setString(3, dept.getIcon());
            
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
}