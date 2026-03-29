package com.hospital.servlet;

import com.hospital.dao.AppointmentDAO;
import com.hospital.dao.DoctorDAO;
import com.hospital.dao.DepartmentDAO;
import com.hospital.model.Appointment;
import com.hospital.model.Doctor;
import com.hospital.model.Department;
import com.hospital.util.SessionValidator;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * BookAppointmentServlet - Handles appointment booking
 */
@WebServlet("/book-appointment")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AppointmentDAO appointmentDAO;
    private DoctorDAO doctorDAO;
    private DepartmentDAO departmentDAO;
    
    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        doctorDAO = new DoctorDAO();
        departmentDAO = new DepartmentDAO();
    }
    
    /**
     * Handle GET request - Show booking form with filters
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (!SessionValidator.isUserLoggedIn(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get filter parameters
        String city = request.getParameter("city");
        String deptIdStr = request.getParameter("deptId");
        
        // Get all departments for dropdown
        List<Department> departments = departmentDAO.getAllDepartments();
        request.setAttribute("departments", departments);
        
        // Get doctors based on filters
        List<Doctor> doctors = null;
        
        if (city != null && !city.isEmpty() && deptIdStr != null && !deptIdStr.isEmpty()) {
            // Filter by city and department
            int deptId = Integer.parseInt(deptIdStr);
            doctors = doctorDAO.getDoctorsByCityAndDept(city, deptId);
        } else if (city != null && !city.isEmpty()) {
            // Filter by city only
            doctors = doctorDAO.getDoctorsByCity(city);
        } else if (deptIdStr != null && !deptIdStr.isEmpty()) {
            // Filter by department only
            int deptId = Integer.parseInt(deptIdStr);
            doctors = doctorDAO.getDoctorsByDepartment(deptId);
        } else {
            // Get all doctors
            doctors = doctorDAO.getAllDoctors();
        }
        
        request.setAttribute("doctors", doctors);
        request.setAttribute("selectedCity", city);
        request.setAttribute("selectedDeptId", deptIdStr);
        
        request.getRequestDispatcher("book-appointment.jsp").forward(request, response);
    }
    
    /**
     * Handle POST request - Process appointment booking
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (!SessionValidator.isUserLoggedIn(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get form data
        String doctorIdStr = request.getParameter("doctorId");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        
        // Validate input
        if (doctorIdStr == null || appointmentDate == null || appointmentTime == null) {
            request.setAttribute("errorMessage", "All fields are required!");
            doGet(request, response);
            return;
        }
        
        int userId = SessionValidator.getLoggedInUserId(session);
        int doctorId = Integer.parseInt(doctorIdStr);
        
        // Check if slot is available
        if (!appointmentDAO.isSlotAvailable(doctorId, appointmentDate, appointmentTime)) {
            request.setAttribute("errorMessage", "This slot is already booked! Please choose another time.");
            doGet(request, response);
            return;
        }
        
        // Create appointment object
        Appointment appointment = new Appointment();
        appointment.setUserId(userId);
        appointment.setDoctorId(doctorId);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setAppointmentTime(appointmentTime);
        appointment.setStatus("Pending");
        
        // Book appointment
        boolean success = appointmentDAO.bookAppointment(appointment);
        
        if (success) {
            request.setAttribute("successMessage", "Appointment booked successfully!");
            response.sendRedirect("patient-dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Booking failed! Please try again.");
            doGet(request, response);
        }
    }
}