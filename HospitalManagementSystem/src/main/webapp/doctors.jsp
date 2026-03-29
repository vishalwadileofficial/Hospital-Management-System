<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.DoctorDAO" %>
<%@ page import="com.hospital.model.Doctor" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Doctors - CarePlus Hospital</title>
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
                <li><a href="about.jsp">About</a></li>
                <li><a href="departments.jsp">Departments</a></li>
                <li><a href="doctors.jsp">Doctors</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="login.jsp" class="btn btn-primary">Login</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="hero">
        <div class="container">
            <h1>Our Expert Doctors</h1>
            <p>Experienced Healthcare Professionals at Your Service</p>
        </div>
    </section>

    <!-- Doctors List -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <%
                DoctorDAO doctorDAO = new DoctorDAO();
                List<Doctor> doctors = doctorDAO.getAllDoctors();
                
                if (doctors != null && !doctors.isEmpty()) {
            %>
                <div class="grid grid-3">
                    <% for (Doctor doctor : doctors) { %>
                        <div class="doctor-card">
                            <div class="doctor-name">
                                <i class="fas fa-user-md text-primary"></i> 
                                <%= doctor.getDoctorName() %>
                            </div>
                            <div class="doctor-specialization">
                                <%= doctor.getSpecialization() %>
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-building"></i> <%= doctor.getDeptName() %>
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-map-marker-alt"></i> <%= doctor.getCity() %>
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-graduation-cap"></i> <%= doctor.getQualification() %>
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-briefcase"></i> <%= doctor.getExperience() %> years experience
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-calendar-alt"></i> <%= doctor.getAvailableDays() %>
                            </div>
                            <div class="doctor-info">
                                <i class="fas fa-clock"></i> <%= doctor.getAvailableTime() %>
                            </div>
                            <div class="doctor-info" style="font-weight: bold; color: var(--secondary-color);">
                                <i class="fas fa-rupee-sign"></i> ₹<%= doctor.getConsultationFee() %>
                            </div>
                            <a href="book-appointment?doctorId=<%= doctor.getDoctorId() %>" 
                               class="btn btn-primary" style="width: 100%; margin-top: 1rem;">
                                Book Appointment
                            </a>
                        </div>
                    <% } %>
                </div>
            <%
                } else {
            %>
                <div class="card text-center">
                    <p>No doctors available at the moment.</p>
                </div>
            <%
                }
            %>
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