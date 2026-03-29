package com.hospital.dao;

import com.hospital.model.Appointment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * AppointmentDAO - Handles all database operations for Appointment
 */
public class AppointmentDAO {
    
    /**
     * Book a new appointment
     * @param appointment Appointment object
     * @return true if successful
     */
    public boolean bookAppointment(Appointment appointment) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO appointments (user_id, doctor_id, appointment_date, " +
                        "appointment_time, status) VALUES (?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, appointment.getUserId());
            pstmt.setInt(2, appointment.getDoctorId());
            pstmt.setString(3, appointment.getAppointmentDate());
            pstmt.setString(4, appointment.getAppointmentTime());
            pstmt.setString(5, appointment.getStatus());
            
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
     * Get all appointments for a specific user
     * @param userId User ID
     * @return List of appointments
     */
    public List<Appointment> getAppointmentsByUser(int userId) {
        List<Appointment> appointments = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT a.*, d.doctor_name, d.specialization, u.full_name " +
                        "FROM appointments a " +
                        "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                        "JOIN users u ON a.user_id = u.user_id " +
                        "WHERE a.user_id = ? " +
                        "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Appointment apt = new Appointment();
                apt.setAppointmentId(rs.getInt("appointment_id"));
                apt.setUserId(rs.getInt("user_id"));
                apt.setDoctorId(rs.getInt("doctor_id"));
                apt.setAppointmentDate(rs.getString("appointment_date"));
                apt.setAppointmentTime(rs.getString("appointment_time"));
                apt.setStatus(rs.getString("status"));
                apt.setDoctorName(rs.getString("doctor_name"));
                apt.setSpecialization(rs.getString("specialization"));
                apt.setPatientName(rs.getString("full_name"));
                appointments.add(apt);
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
        
        return appointments;
    }
    
    /**
     * Get all appointments (Admin function)
     * @return List of all appointments
     */
    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT a.*, d.doctor_name, d.specialization, u.full_name " +
                        "FROM appointments a " +
                        "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                        "JOIN users u ON a.user_id = u.user_id " +
                        "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
            
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                Appointment apt = new Appointment();
                apt.setAppointmentId(rs.getInt("appointment_id"));
                apt.setUserId(rs.getInt("user_id"));
                apt.setDoctorId(rs.getInt("doctor_id"));
                apt.setAppointmentDate(rs.getString("appointment_date"));
                apt.setAppointmentTime(rs.getString("appointment_time"));
                apt.setStatus(rs.getString("status"));
                apt.setDoctorName(rs.getString("doctor_name"));
                apt.setSpecialization(rs.getString("specialization"));
                apt.setPatientName(rs.getString("full_name"));
                appointments.add(apt);
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
        
        return appointments;
    }
    
    /**
     * Update appointment status
     * @param appointmentId Appointment ID
     * @param status New status (Confirmed, Cancelled, etc.)
     * @return true if successful
     */
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, appointmentId);
            
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
     * Check if appointment slot is available
     * @param doctorId Doctor ID
     * @param date Appointment date
     * @param time Appointment time
     * @return true if available
     */
    public boolean isSlotAvailable(int doctorId, String date, String time) {
        boolean available = true;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) as count FROM appointments " +
                        "WHERE doctor_id = ? AND appointment_date = ? AND appointment_time = ? " +
                        "AND status != 'Cancelled'";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, doctorId);
            pstmt.setString(2, date);
            pstmt.setString(3, time);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("count");
                available = (count == 0);
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
        
        return available;
    }
}