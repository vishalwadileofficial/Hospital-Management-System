<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CarePlus Hospital</title>
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
                <li><a href="register.jsp" class="btn btn-secondary">Register</a></li>
            </ul>
        </div>
    </nav>

    <!-- Login Form -->
    <section style="padding: 4rem 0; min-height: 80vh;">
        <div class="container">
            <div style="max-width: 500px; margin: 0 auto;">
                <div class="card">
                    <h2 class="card-header text-center">
                        <i class="fas fa-sign-in-alt"></i> Patient Login
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
                    
                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" 
                                   placeholder="Enter your email" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" class="form-control" 
                                   placeholder="Enter your password" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem;">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </button>
                    </form>
                    
                    <p class="text-center mt-2">
                        Don't have an account? <a href="register.jsp">Register here</a>
                    </p>
                    
                    <hr style="margin: 2rem 0;">
                    
                    <p class="text-center">
                        <a href="admin-login.jsp">Admin Login</a>
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
</body>
</html>