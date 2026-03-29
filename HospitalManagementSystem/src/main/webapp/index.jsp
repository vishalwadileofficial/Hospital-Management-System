<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CarePlus Hospital - Home</title>
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
                
                <% if (session.getAttribute("userId") != null) { %>
                    <li><a href="patient-dashboard.jsp">Dashboard</a></li>
                    <li><a href="logout" class="btn btn-danger">Logout</a></li>
                <% } else { %>
                    <li><a href="login.jsp" class="btn btn-primary">Login</a></li>
                    <li><a href="register.jsp" class="btn btn-secondary">Register</a></li>
                <% } %>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Welcome to CarePlus Hospital</h1>
            <p>Your Health, Our Priority - Quality Healthcare Across Maharashtra</p>
            <a href="book-appointment" class="btn btn-primary">Book Appointment</a>
            <a href="about.jsp" class="btn btn-secondary">Learn More</a>
        </div>
    </section>

    <!-- Features Section -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <h2 class="text-center mb-3">Why Choose CarePlus?</h2>
            <div class="grid grid-3">
                <div class="card text-center">
                    <i class="fas fa-user-md" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>Expert Doctors</h3>
                    <p>Highly qualified and experienced doctors across all specializations</p>
                </div>
                <div class="card text-center">
                    <i class="fas fa-hospital-alt" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>Modern Facilities</h3>
                    <p>State-of-the-art medical equipment and comfortable patient rooms</p>
                </div>
                <div class="card text-center">
                    <i class="fas fa-clock" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>24/7 Emergency</h3>
                    <p>Round-the-clock emergency services for critical care</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Locations Section -->
    <section style="padding: 4rem 0; background-color: var(--light-color);">
        <div class="container">
            <h2 class="text-center mb-3">Our Locations</h2>
            <div class="grid grid-3">
                <div class="card">
                    <h3><i class="fas fa-map-marker-alt text-primary"></i> Pune</h3>
                    <p>Koregaon Park, Pune - 411001</p>
                    <p><i class="fas fa-phone"></i> +91 20 2612 3456</p>
                </div>
                <div class="card">
                    <h3><i class="fas fa-map-marker-alt text-primary"></i> Mumbai</h3>
                    <p>Andheri West, Mumbai - 400053</p>
                    <p><i class="fas fa-phone"></i> +91 22 2674 5678</p>
                </div>
                <div class="card">
                    <h3><i class="fas fa-map-marker-alt text-primary"></i> Nashik</h3>
                    <p>Gangapur Road, Nashik - 422005</p>
                    <p><i class="fas fa-phone"></i> +91 253 235 6789</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section style="padding: 4rem 0;">
        <div class="container text-center">
            <h2 class="mb-2">Ready to Book Your Appointment?</h2>
            <p style="font-size: 1.2rem; margin-bottom: 2rem;">Join thousands of satisfied patients</p>
            <a href="register.jsp" class="btn btn-primary" style="font-size: 1.2rem; padding: 1rem 2rem;">
                Get Started Now
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div>
                    <h3>CarePlus Hospital</h3>
                    <p>Providing quality healthcare services across Maharashtra since 2010.</p>
                </div>
                <div>
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="about.jsp">About Us</a></li>
                        <li><a href="departments.jsp">Departments</a></li>
                        <li><a href="doctors.jsp">Our Doctors</a></li>
                        <li><a href="contact.jsp">Contact Us</a></li>
                    </ul>
                </div>
                <div>
                    <h3>Patient Services</h3>
                    <ul>
                        <li><a href="book-appointment">Book Appointment</a></li>
                        <li><a href="patient-dashboard.jsp">Patient Portal</a></li>
                        <li><a href="#">Emergency Services</a></li>
                    </ul>
                </div>
                <div>
                    <h3>Contact Info</h3>
                    <p><i class="fas fa-envelope"></i> info@careplushosp.com</p>
                    <p><i class="fas fa-phone"></i> +91 1800 123 4567</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 CarePlus Hospital. All Rights Reserved.</p>
            </div>
        </div>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>