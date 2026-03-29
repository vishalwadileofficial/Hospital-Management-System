<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.DepartmentDAO" %>
<%@ page import="com.hospital.model.Department" %>
<%@ page import="java.util.List" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
    
    DepartmentDAO deptDAO = new DepartmentDAO();
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    
    // If not set by servlet, fetch them
    if (departments == null) {
        departments = deptDAO.getAllDepartments();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Departments - Admin Panel</title>
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
            <h1><i class="fas fa-hospital"></i> Manage Departments</h1>
            <p>Add and view hospital departments</p>
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

            <!-- Add New Department Form -->
            <div class="card">
                <h3 class="card-header">
                    <i class="fas fa-plus-circle"></i> Add New Department
                </h3>
                
                <form action="admin/departments" method="post">
                    <div class="grid grid-3">
                        <div class="form-group">
                            <label for="deptName">Department Name *</label>
                            <input type="text" id="deptName" name="deptName" 
                                   class="form-control" placeholder="e.g., Cardiology" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="description">Description</label>
                            <input type="text" id="description" name="description" 
                                   class="form-control" placeholder="Brief description">
                        </div>
                        
                        <div class="form-group">
                            <label for="icon">Font Awesome Icon Class</label>
                            <input type="text" id="icon" name="icon" 
                                   class="form-control" placeholder="e.g., fa-heartbeat">
                            <small style="color: #666;">
                                Visit <a href="https://fontawesome.com/icons" target="_blank">FontAwesome</a> for icons
                            </small>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Department
                    </button>
                </form>
            </div>

            <!-- Departments List -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-list"></i> All Departments 
                    <span style="color: var(--secondary-color);">
                        (<%= departments != null ? departments.size() : 0 %>)
                    </span>
                </h3>
                
                <% if (departments != null && !departments.isEmpty()) { %>
                    <div class="grid grid-3">
                        <% for (Department dept : departments) { %>
                            <div class="dept-card">
                                <div class="dept-icon">
                                    <i class="fas <%= dept.getIcon() %>"></i>
                                </div>
                                <h3><%= dept.getDeptName() %></h3>
                                <p><%= dept.getDescription() %></p>
                                <p style="font-size: 0.9rem; color: #666;">
                                    Department ID: #<%= dept.getDeptId() %>
                                </p>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <p class="text-center" style="padding: 2rem;">No departments found.</p>
                <% } %>
            </div>

            <!-- Common Icons Reference -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-info-circle"></i> Common Department Icons
                </h3>
                <div class="grid grid-4">
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-heartbeat" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-heartbeat</p>
                        <small>Cardiology</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-brain" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-brain</p>
                        <small>Neurology</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-bone" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-bone</p>
                        <small>Orthopedics</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-child" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-child</p>
                        <small>Pediatrics</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-stethoscope" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-stethoscope</p>
                        <small>General Medicine</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-hand-holding-medical" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-hand-holding-medical</p>
                        <small>Dermatology</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-eye" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-eye</p>
                        <small>Ophthalmology</small>
                    </div>
                    <div class="text-center" style="padding: 1rem;">
                        <i class="fas fa-tooth" style="font-size: 2rem; color: var(--primary-color);"></i>
                        <p>fa-tooth</p>
                        <small>Dentistry</small>
                    </div>
                </div>
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