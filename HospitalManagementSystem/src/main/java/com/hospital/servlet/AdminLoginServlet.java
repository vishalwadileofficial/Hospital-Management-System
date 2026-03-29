package com.hospital.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.hospital.dao.DatabaseConnection;

/**
 * AdminLoginServlet - Handles admin login
 */
@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Handle GET request - Show admin login form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("admin-login.jsp").forward(request, response);
    }
    
    /**
     * Handle POST request - Process admin login
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Username and password are required!");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate admin
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM admin_users WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password); // In real project, hash passwords!
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Login successful - Create admin session
                HttpSession session = request.getSession();
                session.setAttribute("adminId", rs.getInt("admin_id"));
                session.setAttribute("adminUsername", rs.getString("username"));
                
                // Redirect to admin dashboard
                response.sendRedirect("admin-dashboard.jsp");
            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid username or password!");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed! Please try again.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}