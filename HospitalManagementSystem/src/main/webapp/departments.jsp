<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hospital.dao.DepartmentDAO" %>
<%@ page import="com.hospital.model.Department" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - CarePlus Hospital</title>
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
            <h1>Our Departments</h1>
            <p>Comprehensive Medical Services Under One Roof</p>
        </div>
    </section>

    <!-- Departments List -->
    <section style="padding: 4rem 0;">
        <div class="container">
            <%
                DepartmentDAO deptDAO = new DepartmentDAO();
                List<Department> departments = deptDAO.getAllDepartments();
                
                if (departments != null && !departments.isEmpty()) {
            %>
                <div class="grid grid-3">
                    <% for (Department dept : departments) { %>
                        <div class="dept-card">
                            <div class="dept-icon">
                                <i class="fas <%= dept.getIcon() %>"></i>
                            </div>
                            <h3><%= dept.getDeptName() %></h3>
                            <p><%= dept.getDescription() %></p>
                            <a href="book-appointment?deptId=<%= dept.getDeptId() %>" class="btn btn-primary">
                                Book Appointment
                            </a>
                        </div>
                    <% } %>
                </div>
            <%
                } else {
            %>
                <div class="card text-center">
                    <p>No departments available at the moment.</p>
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