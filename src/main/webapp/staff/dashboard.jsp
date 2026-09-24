<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"STAFF".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<header>
    <h1>Sunrise College - Staff Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="card">
        <h2>Welcome, <%= user.getUsername() %></h2>
        <p>Manage student records and weekly-test marks below.</p>
    </div>

    <div class="grid-3">
        <div class="card">
            <h2>Students</h2>
            <p>Add, update or remove student records.</p>
            <a class="btn" href="${pageContext.request.contextPath}/student">Manage Students</a>
        </div>
        <div class="card">
            <h2>Weekly Tests</h2>
            <p>Record and update weekly-test marks.</p>
            <a class="btn" href="${pageContext.request.contextPath}/weeklytest">Manage Tests</a>
        </div>
        <div class="card">
            <h2>Courses</h2>
            <p>View available courses.</p>
            <a class="btn" href="${pageContext.request.contextPath}/course">Manage Courses</a>
        </div>
    </div>
</div>
</body>
</html>
