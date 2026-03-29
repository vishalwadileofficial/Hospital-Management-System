<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - CarePlus Hospital</title>
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
            <h1>About CarePlus Hospital</h1>
            <p>Committed to Excellence in Healthcare</p>
        </div>
    </section>

    <!-- About Content -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="card">
                <h2 class="card-header">Our Story</h2>
                <p style="line-height: 1.8; font-size: 1.1rem;">
                    CarePlus Hospital was established in 2010 with a vision to provide world-class healthcare 
                    services to the people of Maharashtra. Over the years, we have grown to become one of the 
                    most trusted healthcare providers in the region, with state-of-the-art facilities in Pune, 
                    Mumbai, and Nashik.
                </p>
                <p style="line-height: 1.8; font-size: 1.1rem;">
                    Our team of highly qualified doctors, nurses, and support staff work tirelessly to ensure 
                    that every patient receives the best possible care. We believe in treating not just the 
                    disease, but the person as a whole.
                </p>
            </div>

            <div class="grid grid-3 mt-3">
                <div class="card text-center">
                    <i class="fas fa-award" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>15+ Years</h3>
                    <p>Of Healthcare Excellence</p>
                </div>
                <div class="card text-center">
                    <i class="fas fa-users" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>50,000+</h3>
                    <p>Happy Patients</p>
                </div>
                <div class="card text-center">
                    <i class="fas fa-user-md" style="font-size: 3rem; color: var(--primary-color); margin-bottom: 1rem;"></i>
                    <h3>100+</h3>
                    <p>Expert Doctors</p>
                </div>
            </div>

            <div class="card mt-3">
                <h2 class="card-header">Our Mission</h2>
                <p style="line-height: 1.8; font-size: 1.1rem;">
                    To provide affordable, accessible, and high-quality healthcare services to all sections 
                    of society, using the latest medical technology and evidence-based practices.
                </p>
            </div>

            <div class="card mt-3">
                <h2 class="card-header">Our Vision</h2>
                <p style="line-height: 1.8; font-size: 1.1rem;">
                    To be the leading healthcare provider in India, recognized for clinical excellence, 
                    patient satisfaction, and innovation in medical care.
                </p>
            </div>
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
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 CarePlus Hospital. All Rights Reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>