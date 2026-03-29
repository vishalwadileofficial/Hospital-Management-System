<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - CarePlus Hospital</title>
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
            <h1>Contact Us</h1>
            <p>We're Here to Help You</p>
        </div>
    </section>

    <!-- Contact Information -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <div class="grid grid-3">
                <!-- Pune -->
                <div class="card">
                    <h3 class="text-primary"><i class="fas fa-hospital"></i> Pune Branch</h3>
                    <p><strong>Address:</strong><br>
                    CarePlus Hospital, Koregaon Park<br>
                    Lane No. 5, Pune - 411001<br>
                    Maharashtra, India</p>
                    
                    <p><strong>Phone:</strong><br>
                    <i class="fas fa-phone"></i> +91 20 2612 3456<br>
                    <i class="fas fa-phone"></i> +91 20 2612 3457</p>
                    
                    <p><strong>Email:</strong><br>
                    <i class="fas fa-envelope"></i> pune@careplushosp.com</p>
                    
                    <p><strong>Emergency:</strong><br>
                    <i class="fas fa-ambulance"></i> +91 98765 43210</p>
                </div>

                <!-- Mumbai -->
                <div class="card">
                    <h3 class="text-primary"><i class="fas fa-hospital"></i> Mumbai Branch</h3>
                    <p><strong>Address:</strong><br>
                    CarePlus Hospital, Andheri West<br>
                    S.V. Road, Mumbai - 400053<br>
                    Maharashtra, India</p>
                    
                    <p><strong>Phone:</strong><br>
                    <i class="fas fa-phone"></i> +91 22 2674 5678<br>
                    <i class="fas fa-phone"></i> +91 22 2674 5679</p>
                    
                    <p><strong>Email:</strong><br>
                    <i class="fas fa-envelope"></i> mumbai@careplushosp.com</p>
                    
                    <p><strong>Emergency:</strong><br>
                    <i class="fas fa-ambulance"></i> +91 98765 43211</p>
                </div>

                <!-- Nashik -->
                <div class="card">
                    <h3 class="text-primary"><i class="fas fa-hospital"></i> Nashik Branch</h3>
                    <p><strong>Address:</strong><br>
                    CarePlus Hospital, Gangapur Road<br>
                    Near CBS, Nashik - 422005<br>
                    Maharashtra, India</p>
                    
                    <p><strong>Phone:</strong><br>
                    <i class="fas fa-phone"></i> +91 253 235 6789<br>
                    <i class="fas fa-phone"></i> +91 253 235 6790</p>
                    
                    <p><strong>Email:</strong><br>
                    <i class="fas fa-envelope"></i> nashik@careplushosp.com</p>
                    
                    <p><strong>Emergency:</strong><br>
                    <i class="fas fa-ambulance"></i> +91 98765 43212</p>
                </div>
            </div>

            <!-- General Contact -->
            <div class="card mt-3">
                <h3 class="text-primary"><i class="fas fa-info-circle"></i> General Inquiries</h3>
                <div class="grid grid-2">
                    <div>
                        <p><strong>Toll-Free Number:</strong><br>
                        <i class="fas fa-phone-volume"></i> 1800 123 4567 (Available 24/7)</p>
                        
                        <p><strong>Email Support:</strong><br>
                        <i class="fas fa-envelope"></i> info@careplushosp.com</p>
                    </div>
                    <div>
                        <p><strong>Appointment Booking:</strong><br>
                        <i class="fas fa-calendar-check"></i> appointments@careplushosp.com</p>
                        
                        <p><strong>Feedback & Complaints:</strong><br>
                        <i class="fas fa-comment-alt"></i> feedback@careplushosp.com</p>
                    </div>
                </div>
            </div>

            <!-- Working Hours -->
            <div class="card mt-3">
                <h3 class="text-primary"><i class="fas fa-clock"></i> Working Hours</h3>
                <div class="grid grid-2">
                    <div>
                        <p><strong>OPD Timings:</strong></p>
                        <p>Monday - Saturday: 8:00 AM - 8:00 PM<br>
                        Sunday: 9:00 AM - 2:00 PM</p>
                    </div>
                    <div>
                        <p><strong>Emergency Services:</strong></p>
                        <p>Available 24/7<br>
                        All Days Including Holidays</p>
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