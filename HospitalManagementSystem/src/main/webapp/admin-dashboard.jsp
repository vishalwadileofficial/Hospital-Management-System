<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.*" %>
<%@ page import="com.hospital.model.*" %>
<%@ page import="java.util.List" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("adminId") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }
    
    // Get statistics
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    DoctorDAO doctorDAO = new DoctorDAO();
    DepartmentDAO deptDAO = new DepartmentDAO();
    
    List<Appointment> allAppointments = appointmentDAO.getAllAppointments();
    List<Doctor> allDoctors = doctorDAO.getAllDoctors();
    List<Department> allDepts = deptDAO.getAllDepartments();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CarePlus Hospital</title>
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

    <!-- Dashboard Header -->
    <section class="hero">
        <div class="container">
            <h1><i class="fas fa-tachometer-alt"></i> Admin Dashboard</h1>
            <p>Manage hospital operations and data</p>
        </div>
    </section>

    <!-- Dashboard Content -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <!-- Stats Cards -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3><%= allAppointments != null ? allAppointments.size() : 0 %></h3>
                    <p><i class="fas fa-calendar-alt"></i> Total Appointments</p>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #28a745, #218838);">
                    <h3><%= allDoctors != null ? allDoctors.size() : 0 %></h3>
                    <p><i class="fas fa-user-md"></i> Total Doctors</p>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #17a2b8, #117a8b);">
                    <h3><%= allDepts != null ? allDepts.size() : 0 %></h3>
                    <p><i class="fas fa-hospital"></i> Departments</p>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #ffc107, #e0a800);">
                    <h3>
                        <%
                            long pending = 0;
                            if (allAppointments != null) {
                                pending = allAppointments.stream()
                                    .filter(a -> "Pending".equals(a.getStatus()))
                                    .count();
                            }
                        %>
                        <%= pending %>
                    </h3>
                    <p><i class="fas fa-hourglass-half"></i> Pending Appointments</p>
                </div>
            </div>

            <!-- Recent Appointments -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-calendar-check"></i> Recent Appointments
                </h3>
                
                <% if (allAppointments != null && !allAppointments.isEmpty()) { %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Doctor</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                int limit = Math.min(10, allAppointments.size());
                                for (int i = 0; i < limit; i++) {
                                    Appointment apt = allAppointments.get(i);
                            %>
                                <tr>
                                    <td>#<%= apt.getAppointmentId() %></td>
                                    <td><i class="fas fa-user"></i> <%= apt.getPatientName() %></td>
                                    <td><i class="fas fa-user-md"></i> <%= apt.getDoctorName() %></td>
                                    <td><i class="fas fa-calendar"></i> <%= apt.getAppointmentDate() %></td>
                                    <td><i class="fas fa-clock"></i> <%= apt.getAppointmentTime() %></td>
                                    <td>
                                        <% 
                                            String status = apt.getStatus();
                                            String badgeClass = "badge-pending";
                                            if ("Confirmed".equals(status)) {
                                                badgeClass = "badge-confirmed";
                                            } else if ("Cancelled".equals(status)) {
                                                badgeClass = "badge-cancelled";
                                            }
                                        %>
                                        <span class="badge <%= badgeClass %>"><%= status %></span>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p class="text-center" style="padding: 2rem;">No appointments found.</p>
                <% } %>
            </div>

            <!-- Quick Actions -->
            <div class="grid grid-3 mt-3">
                <a href="admin/doctors" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-user-md" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>Manage Doctors</h4>
                    <p>Add, edit, or remove doctors</p>
                </a>
                
                <a href="admin/departments" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-hospital" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>Manage Departments</h4>
                    <p>Add or edit departments</p>
                </a>
                
                <a href="admin-dashboard.jsp" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-chart-line" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>View Reports</h4>
                    <p>Analytics and statistics</p>
                </a>
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