<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.AppointmentDAO, com.hospital.dao.UserDAO" %>
<%@ page import="com.hospital.model.Appointment, com.hospital.model.User" %>
<%@ page import="com.hospital.util.SessionValidator" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    if (!SessionValidator.isUserLoggedIn(session)) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int userId = SessionValidator.getLoggedInUserId(session);
    String userName = SessionValidator.getLoggedInUserName(session);
    
    // Get user details
    UserDAO userDAO = new UserDAO();
    User user = userDAO.getUserById(userId);
    
    // Get appointments
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    List<Appointment> appointments = appointmentDAO.getAppointmentsByUser(userId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - CarePlus Hospital</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="container">
            <a href="index.jsp" class="navbar-brand">
                <i class="fas fa-hospital"></i> CarePlus Hospital
            </a>
            <ul class="navbar-menu">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="patient-dashboard.jsp">Dashboard</a></li>
                <li><a href="book-appointment">Book Appointment</a></li>
                <li><a href="logout" class="btn btn-danger">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Dashboard Header -->
    <section class="hero">
        <div class="container">
            <h1><i class="fas fa-user-circle"></i> Welcome, <%= userName %>!</h1>
            <p>Manage your appointments and health records</p>
        </div>
    </section>

    <!-- Dashboard Content -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <!-- Stats Cards -->
            <div class="dashboard-stats">
                <div class="stat-card">
                    <h3><%= appointments != null ? appointments.size() : 0 %></h3>
                    <p><i class="fas fa-calendar-alt"></i> Total Appointments</p>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, var(--secondary-color), #008f5d);">
                    <h3>
                        <%
                            long pending = 0;
                            if (appointments != null) {
                                pending = appointments.stream()
                                    .filter(a -> "Pending".equals(a.getStatus()))
                                    .count();
                            }
                        %>
                        <%= pending %>
                    </h3>
                    <p><i class="fas fa-hourglass-half"></i> Pending</p>
                </div>
                
                <div class="stat-card" style="background: linear-gradient(135deg, #28a745, #218838);">
                    <h3>
                        <%
                            long confirmed = 0;
                            if (appointments != null) {
                                confirmed = appointments.stream()
                                    .filter(a -> "Confirmed".equals(a.getStatus()))
                                    .count();
                            }
                        %>
                        <%= confirmed %>
                    </h3>
                    <p><i class="fas fa-check-circle"></i> Confirmed</p>
                </div>
            </div>

            <!-- Profile Section -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-user"></i> My Profile
                </h3>
                <div class="grid grid-2">
                    <div>
                        <p><strong>Full Name:</strong> <%= user.getFullName() %></p>
                        <p><strong>Email:</strong> <%= user.getEmail() %></p>
                        <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                    </div>
                    <div>
                        <p><strong>Address:</strong> <%= user.getAddress() != null ? user.getAddress() : "N/A" %></p>
                        <p><strong>City:</strong> <%= user.getCity() != null ? user.getCity() : "N/A" %></p>
                    </div>
                </div>
            </div>

            <!-- Appointments Section -->
            <div class="card mt-3">
                <h3 class="card-header">
                    <i class="fas fa-calendar-check"></i> My Appointments
                </h3>
                
                <% if (appointments != null && !appointments.isEmpty()) { %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Doctor</th>
                                <th>Specialization</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment apt : appointments) { %>
                                <tr>
                                    <td>#<%= apt.getAppointmentId() %></td>
                                    <td><i class="fas fa-user-md"></i> <%= apt.getDoctorName() %></td>
                                    <td><%= apt.getSpecialization() %></td>
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
                    <div class="text-center" style="padding: 2rem;">
                        <i class="fas fa-calendar-times" style="font-size: 3rem; color: #ccc; margin-bottom: 1rem;"></i>
                        <p style="font-size: 1.1rem; color: #666;">No appointments found.</p>
                        <a href="book-appointment" class="btn btn-primary mt-2">
                            <i class="fas fa-calendar-plus"></i> Book Your First Appointment
                        </a>
                    </div>
                <% } %>
            </div>

            <!-- Quick Actions -->
            <div class="grid grid-3 mt-3">
                <a href="book-appointment" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-calendar-plus" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>Book Appointment</h4>
                    <p>Schedule a new consultation</p>
                </a>
                
                <a href="departments.jsp" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-hospital" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>View Departments</h4>
                    <p>Explore our specializations</p>
                </a>
                
                <a href="contact.jsp" class="card text-center" style="text-decoration: none; color: inherit;">
                    <i class="fas fa-phone-alt" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h4>Contact Us</h4>
                    <p>Get in touch with us</p>
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