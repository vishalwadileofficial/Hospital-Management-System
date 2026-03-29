<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.DoctorDAO, com.hospital.dao.DepartmentDAO" %>
<%@ page import="com.hospital.model.Doctor, com.hospital.model.Department" %>
<%@ page import="com.hospital.util.SessionValidator" %>
<%@ page import="java.util.List" %>
<%
    // Check if user is logged in
    if (!SessionValidator.isUserLoggedIn(session)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - CarePlus Hospital</title>
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
                <li><a href="logout" class="btn btn-danger">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="hero">
        <div class="container">
            <h1><i class="fas fa-calendar-plus"></i> Book Appointment</h1>
            <p>Schedule your consultation with our expert doctors</p>
        </div>
    </section>

    <!-- Booking Section -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <%
                DepartmentDAO deptDAO = new DepartmentDAO();
                DoctorDAO doctorDAO = new DoctorDAO();
                
                List<Department> departments = deptDAO.getAllDepartments();
                List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
                
                String selectedCity = (String) request.getAttribute("selectedCity");
                String selectedDeptId = (String) request.getAttribute("selectedDeptId");
            %>
            
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

            <!-- Filter Section -->
            <div class="card">
                <h3 class="card-header">
                    <i class="fas fa-filter"></i> Find Your Doctor
                </h3>
                
                <form action="book-appointment" method="get">
                    <div class="grid grid-3">
                        <div class="form-group">
                            <label for="city">Select City</label>
                            <select id="city" name="city" class="form-control" onchange="this.form.submit()">
                                <option value="">All Cities</option>
                                <option value="Pune" <%= "Pune".equals(selectedCity) ? "selected" : "" %>>Pune</option>
                                <option value="Mumbai" <%= "Mumbai".equals(selectedCity) ? "selected" : "" %>>Mumbai</option>
                                <option value="Nashik" <%= "Nashik".equals(selectedCity) ? "selected" : "" %>>Nashik</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="deptId">Select Department</label>
                            <select id="deptId" name="deptId" class="form-control" onchange="this.form.submit()">
                                <option value="">All Departments</option>
                                <% for (Department dept : departments) { %>
                                    <option value="<%= dept.getDeptId() %>" 
                                            <%= String.valueOf(dept.getDeptId()).equals(selectedDeptId) ? "selected" : "" %>>
                                        <%= dept.getDeptName() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label>&nbsp;</label>
                            <button type="submit" class="btn btn-primary" style="width: 100%;">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Doctors List -->
            <div class="mt-3">
                <h3 class="mb-2">
                    <i class="fas fa-user-md"></i> Available Doctors
                    <% if (doctors != null) { %>
                        <span style="color: var(--secondary-color);">(<%= doctors.size() %> found)</span>
                    <% } %>
                </h3>
                
                <% if (doctors != null && !doctors.isEmpty()) { %>
                    <div class="grid grid-2">
                        <% for (Doctor doctor : doctors) { %>
                            <div class="card">
                                <div class="doctor-name" style="font-size: 1.3rem; margin-bottom: 0.5rem;">
                                    <i class="fas fa-user-md text-primary"></i> 
                                    <%= doctor.getDoctorName() %>
                                </div>
                                
                                <div class="doctor-specialization" style="font-size: 1.1rem; margin-bottom: 1rem;">
                                    <%= doctor.getSpecialization() %>
                                </div>
                                
                                <div class="grid grid-2" style="gap: 0.5rem; margin-bottom: 1rem;">
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
                                        <i class="fas fa-briefcase"></i> <%= doctor.getExperience() %> years
                                    </div>
                                    <div class="doctor-info">
                                        <i class="fas fa-calendar-alt"></i> <%= doctor.getAvailableDays() %>
                                    </div>
                                    <div class="doctor-info">
                                        <i class="fas fa-clock"></i> <%= doctor.getAvailableTime() %>
                                    </div>
                                </div>
                                
                                <div style="border-top: 1px solid var(--border-color); padding-top: 1rem; margin-top: 1rem;">
                                    <div style="font-size: 1.2rem; font-weight: bold; color: var(--secondary-color); margin-bottom: 1rem;">
                                        <i class="fas fa-rupee-sign"></i> Consultation Fee: ₹<%= doctor.getConsultationFee() %>
                                    </div>
                                    
                                    <!-- Book Button -->
                                    <button onclick="openBookingModal(<%= doctor.getDoctorId() %>, '<%= doctor.getDoctorName() %>', '<%= doctor.getSpecialization() %>')" 
                                            class="btn btn-primary" style="width: 100%;">
                                        <i class="fas fa-calendar-check"></i> Book Appointment
                                    </button>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="card text-center">
                        <i class="fas fa-info-circle" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                        <p style="font-size: 1.2rem;">No doctors found matching your criteria.</p>
                        <p>Please try different filters or <a href="book-appointment">view all doctors</a>.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Booking Modal (Hidden by default) -->
    <div id="bookingModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
         background-color: rgba(0,0,0,0.5); z-index: 2000; justify-content: center; align-items: center;">
        <div class="card" style="max-width: 500px; margin: 2rem;">
            <h3 class="card-header">
                <i class="fas fa-calendar-plus"></i> Confirm Appointment
            </h3>
            
            <form action="book-appointment" method="post">
                <input type="hidden" id="modalDoctorId" name="doctorId">
                
                <div class="form-group">
                    <label>Doctor</label>
                    <input type="text" id="modalDoctorName" class="form-control" readonly>
                </div>
                
                <div class="form-group">
                    <label>Specialization</label>
                    <input type="text" id="modalDoctorSpec" class="form-control" readonly>
                </div>
                
                <div class="form-group">
                    <label for="appointmentDate">Appointment Date *</label>
                    <input type="date" id="appointmentDate" name="appointmentDate" 
                           class="form-control" required min="<%= java.time.LocalDate.now() %>">
                </div>
                
                <div class="form-group">
                    <label for="appointmentTime">Appointment Time *</label>
                    <select id="appointmentTime" name="appointmentTime" class="form-control" required>
                        <option value="">Select Time</option>
                        <option value="9:00 AM">9:00 AM</option>
                        <option value="10:00 AM">10:00 AM</option>
                        <option value="11:00 AM">11:00 AM</option>
                        <option value="12:00 PM">12:00 PM</option>
                        <option value="2:00 PM">2:00 PM</option>
                        <option value="3:00 PM">3:00 PM</option>
                        <option value="4:00 PM">4:00 PM</option>
                        <option value="5:00 PM">5:00 PM</option>
                    </select>
                </div>
                
                <div class="grid grid-2" style="gap: 1rem;">
                    <button type="button" onclick="closeBookingModal()" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Confirm Booking
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-bottom">
                <p>&copy; 2026 CarePlus Hospital. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        function openBookingModal(doctorId, doctorName, specialization) {
            document.getElementById('modalDoctorId').value = doctorId;
            document.getElementById('modalDoctorName').value = doctorName;
            document.getElementById('modalDoctorSpec').value = specialization;
            document.getElementById('bookingModal').style.display = 'flex';
        }
        
        function closeBookingModal() {
            document.getElementById('bookingModal').style.display = 'none';
        }
        
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('appointmentDate').setAttribute('min', today);
        });
    </script>
</body>
</html>