<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.DoctorDAO, com.hospital.dao.DepartmentDAO" %>
<%@ page import="com.hospital.model.Doctor, com.hospital.model.Department" %>
<%@ page import="java.util.List" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
    
    DoctorDAO doctorDAO = new DoctorDAO();
    DepartmentDAO deptDAO = new DepartmentDAO();
    
    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    
    // If not set by servlet, fetch them
    if (doctors == null) {
        doctors = doctorDAO.getAllDoctors();
    }
    if (departments == null) {
        departments = deptDAO.getAllDepartments();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Doctors - Admin Panel</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="container">
            <a href="admin-dashboard.jsp" class="navbar-brand">
                <i class="fas fa-user-shield"></i> Admin Panel
            </a>
            <ul class="navbar-menu">
                <li><a href="admin-dashboard.jsp">Dashboard</a></li>
                <li><a href="admin/doctors">Manage Doctors</a></li>
                <li><a href="admin/departments">Manage Departments</a></li>
                <li><a href="logout" class="btn btn-danger">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="hero">
        <div class="container">
            <h1><i class="fas fa-user-md"></i> Manage Doctors</h1>
            <p>Add, view, and manage doctor information</p>
        </div>
    </section>

    <!-- Content -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <!-- Success/Error Messages -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <!-- Add New Doctor Form -->
            <div class="card">
                <h3 class="card-header">
                    <i class="fas fa-plus-circle"></i> Add New Doctor
                </h3>
                
                <form action="admin/doctors" method="post">
                    <div class="grid grid-3">
                        <div class="form-group">
                            <label for="doctorName">Doctor Name *</label>
                            <input type="text" id="doctorName" name="doctorName" 
                                   class="form-control" placeholder="Dr. Full Name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="specialization">Specialization *</label>
                            <input type="text" id="specialization" name="specialization" 
                                   class="form-control" placeholder="e.g., Cardiologist" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="deptId">Department *</label>
                            <select id="deptId" name="deptId" class="form-control" required>
                                <option value="">Select Department</option>
                                <% for (Department dept : departments) { %>
                                    <option value="<%= dept.getDeptId() %>">
                                        <%= dept.getDeptName() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="city">City *</label>
                            <select id="city" name="city" class="form-control" required>
                                <option value="">Select City</option>
                                <option value="Pune">Pune</option>
                                <option value="Mumbai">Mumbai</option>
                                <option value="Nashik">Nashik</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Phone Number *</label>
                            <input type="tel" id="phone" name="phone" 
                                   class="form-control" placeholder="10-digit number" 
                                   pattern="[0-9]{10}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" 
                                   class="form-control" placeholder="doctor@hospital.com">
                        </div>
                        
                        <div class="form-group">
                            <label for="qualification">Qualification *</label>
                            <input type="text" id="qualification" name="qualification" 
                                   class="form-control" placeholder="MBBS, MD" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="experience">Experience (years) *</label>
                            <input type="number" id="experience" name="experience" 
                                   class="form-control" placeholder="Years" min="0" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="consultationFee">Consultation Fee (₹) *</label>
                            <input type="number" id="consultationFee" name="consultationFee" 
                                   class="form-control" placeholder="Amount" min="0" step="0.01" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="availableDays">Available Days *</label>
                            <input type="text" id="availableDays" name="availableDays" 
                                   class="form-control" placeholder="Mon,Tue,Wed" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="availableTime">Available Time *</label>
                            <input type="text" id="availableTime" name="availableTime" 
                                   class="form-control" placeholder="9:00 AM - 5:00 PM" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Doctor
                    </button>
                </form>
            </div>

            <!-- Doctors List -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-list"></i> All Doctors 
                    <span style="color: var(--secondary-color);">
                        (<%= doctors != null ? doctors.size() : 0 %>)
                    </span>
                </h3>
                
                <% if (doctors != null && !doctors.isEmpty()) { %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Specialization</th>
                                <th>Department</th>
                                <th>City</th>
                                <th>Phone</th>
                                <th>Experience</th>
                                <th>Fee</th>
                                <th>Available Days</th>
                                <th>Available Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Doctor doctor : doctors) { %>
                                <tr>
                                    <td>#<%= doctor.getDoctorId() %></td>
                                    <td><strong><%= doctor.getDoctorName() %></strong></td>
                                    <td><%= doctor.getSpecialization() %></td>
                                    <td><%= doctor.getDeptName() %></td>
                                    <td><%= doctor.getCity() %></td>
                                    <td><%= doctor.getPhone() %></td>
                                    <td><%= doctor.getExperience() %> years</td>
                                    <td>₹<%= doctor.getConsultationFee() %></td>
                                    <td><%= doctor.getAvailableDays() %></td>
                                    <td><%= doctor.getAvailableTime() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p class="text-center" style="padding: 2rem;">No doctors found.</p>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-bottom">
                <p>&copy; 2026 CarePlus Hospital. All Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>