package com.hospital.dao;

import com.hospital.model.User;
import java.sql.*;

public class UserDAO {

    // ---------- REGISTER ----------
    public boolean registerUser(User user) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();

            if (conn == null) {
                System.out.println("DB connection failed in registerUser()");
                return false;
            }

            String sql = "INSERT INTO users (full_name, email, password, phone, address, city) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getCity());

            success = pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("REGISTER ERROR:");
            e.printStackTrace();
        } finally {
            close(conn, pstmt, null);
        }

        return success;
    }

    // ---------- LOGIN ----------
    public User loginUser(String email, String password) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            if (conn == null) {
                System.out.println("DB connection failed in loginUser()");
                return null;
            }

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setCity(rs.getString("city"));
            }

        } catch (SQLException e) {
            System.out.println("LOGIN ERROR:");
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }

        return user;
    }

    // ---------- EMAIL CHECK ----------
    public boolean emailExists(String email) {
        boolean exists = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            if (conn == null) {
                System.out.println("DB connection failed in emailExists()");
                return false;
            }

            String sql = "SELECT email FROM users WHERE email=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();
            exists = rs.next();

        } catch (SQLException e) {
            System.out.println("EMAIL CHECK ERROR:");
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }

        return exists;
    }

    // ---------- GET USER ----------
    public User getUserById(int userId) {
        User user = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            if (conn == null) {
                System.out.println("DB connection failed in getUserById()");
                return null;
            }

            String sql = "SELECT * FROM users WHERE user_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setCity(rs.getString("city"));
            }

        } catch (SQLException e) {
            System.out.println("GET USER ERROR:");
            e.printStackTrace();
        } finally {
            close(conn, pstmt, rs);
        }

        return user;
    }

    // ---------- COMMON CLOSE ----------
    private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
