package com.hospital.servlet;

import com.hospital.dao.DoctorDAO;
import com.hospital.dao.DepartmentDAO;
import com.hospital.model.Doctor;
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
 * AdminDoctorServlet - Handles admin operations for doctors
 */
@WebServlet("/admin/doctors")
public class AdminDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DoctorDAO doctorDAO;
    private DepartmentDAO departmentDAO;
    
    @Override
    public void init() throws ServletException {
        doctorDAO = new DoctorDAO();
        departmentDAO = new DepartmentDAO();
    }
    
    /**
     * Handle GET request - Show doctors list
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if admin is logged in (simple check)
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        // Get all doctors
        List<Doctor> doctors = doctorDAO.getAllDoctors();
        request.setAttribute("doctors", doctors);
        
        // Get departments for add form
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        
        request.getRequestDispatcher("../admin-doctors.jsp").forward(request, response);
    }
    
    /**
     * Handle POST request - Add new doctor
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
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String deptIdStr = request.getParameter("deptId");
        String city = request.getParameter("city");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String qualification = request.getParameter("qualification");
        String experienceStr = request.getParameter("experience");
        String feeStr = request.getParameter("consultationFee");
        String availableDays = request.getParameter("availableDays");
        String availableTime = request.getParameter("availableTime");
        
        // Create doctor object
        Doctor doctor = new Doctor();
        doctor.setDoctorName(doctorName);
        doctor.setSpecialization(specialization);
        doctor.setDeptId(Integer.parseInt(deptIdStr));
        doctor.setCity(city);
        doctor.setPhone(phone);
        doctor.setEmail(email);
        doctor.setQualification(qualification);
        doctor.setExperience(Integer.parseInt(experienceStr));
        doctor.setConsultationFee(Double.parseDouble(feeStr));
        doctor.setAvailableDays(availableDays);
        doctor.setAvailableTime(availableTime);
        
        // Add doctor
        boolean success = doctorDAO.addDoctor(doctor);
        
        if (success) {
            request.setAttribute("successMessage", "Doctor added successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to add doctor!");
        }
        
        doGet(request, response);
    }
}