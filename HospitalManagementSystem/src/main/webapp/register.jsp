<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CarePlus Hospital</title>
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
                <li><a href="login.jsp" class="btn btn-primary">Login</a></li>
            </ul>
        </div>
    </nav>

    <!-- Registration Form -->
    <section style="padding: 4rem 0; min-height: 80vh;">
        <div class="container">
            <div style="max-width: 600px; margin: 0 auto;">
                <div class="card">
                    <h2 class="card-header text-center">
                        <i class="fas fa-user-plus"></i> Patient Registration
                    </h2>
                    
                    <!-- Success Message -->
                    <% if (request.getAttribute("successMessage") != null) { %>
                        <div class="alert alert-success">
                            <%= request.getAttribute("successMessage") %>
                        </div>
                    <% } %>
                    
                    <!-- Error Message -->
                    <% if (request.getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-error">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                    <% } %>
                    
                    <form action="register" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="fullName">Full Name *</label>
                            <input type="text" id="fullName" name="fullName" class="form-control" 
                                   placeholder="Enter your full name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address *</label>
                            <input type="email" id="email" name="email" class="form-control" 
                                   placeholder="example@email.com" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password *</label>
                            <input type="password" id="password" name="password" class="form-control" 
                                   placeholder="Minimum 6 characters" minlength="6" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password *</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   class="form-control" placeholder="Re-enter password" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Phone Number *</label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   placeholder="10-digit mobile number" pattern="[0-9]{10}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="address">Address</label>
                            <textarea id="address" name="address" class="form-control" 
                                      rows="3" placeholder="Enter your address"></textarea>
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
                        
                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem;">
                            <i class="fas fa-user-plus"></i> Register
                        </button>
                    </form>
                    
                    <p class="text-center mt-2">
                        Already have an account? <a href="login.jsp">Login here</a>
                    </p>
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

    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>