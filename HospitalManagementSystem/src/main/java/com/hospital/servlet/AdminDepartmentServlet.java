package com.hospital.servlet;

import com.hospital.dao.DepartmentDAO;
import com.hospital.model.Department;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * AdminDepartmentServlet - Handles admin operations for departments
 */
@WebServlet("/admin/departments")
public class AdminDepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DepartmentDAO departmentDAO;
    
    @Override
    public void init() throws ServletException {
        departmentDAO = new DepartmentDAO();
    }
    
    /**
     * Handle GET request - Show departments list
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        // Get all departments
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        
        request.getRequestDispatcher("../admin-departments.jsp").forward(request, response);
    }
    
    /**
     * Handle POST request - Add new department
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        // Get form data
        String deptName = request.getParameter("deptName");
        String description = request.getParameter("description");
        String icon = request.getParameter("icon");
        
        // Create department object
        Department dept = new Department();
        dept.setDeptName(deptName);
        dept.setDescription(description);
        dept.setIcon(icon);
        
        // Add department
        boolean success = departmentDAO.addDepartment(dept);
        
        if (success) {
            request.setAttribute("successMessage", "Department added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add department!");
        }
        
        doGet(request, response);
    }
}