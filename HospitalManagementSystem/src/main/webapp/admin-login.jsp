<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - CarePlus Hospital</title>
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
                <li><a href="login.jsp">Patient Login</a></li>
            </ul>
        </div>
    </nav>

    <!-- Admin Login Form -->
    <section style="padding: 4rem 0; min-height: 80vh;">
        <div class="container">
            <div style="max-width: 500px; margin: 0 auto;">
                <div class="card">
                    <h2 class="card-header text-center">
                        <i class="fas fa-user-shield"></i> Admin Login
                    </h2>
                    
                    <!-- Error Message -->
                    <% if (request.getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-error">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                    <% } %>
                    
                    <form action="admin-login" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" class="form-control" 
                                   placeholder="Enter admin username" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" class="form-control" 
                                   placeholder="Enter admin password" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem;">
                            <i class="fas fa-sign-in-alt"></i> Login as Admin
                        </button>
                    </form>
                    
                    <div class="alert alert-info mt-2">
                        <strong>Default Credentials:</strong><br>
                        Username: admin<br>
                        Password: admin123
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