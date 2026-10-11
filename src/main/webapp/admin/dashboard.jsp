
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-body">
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<header>
    <h1>BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="dashboard-container">
    <div class="dashboard-heading">
        <div>
            <h2>Welcome, <%= user.getUsername() %>!</h2>
            <p>Manage students, courses, weekly tests and staff accounts.</p>
        </div>
        <span class="badge badge-primary">ADMIN</span>
    </div>

    <div class="grid-2">
        <div class="action-card">
            <div class="icon">👨‍🎓</div>
            <h3>Student Management</h3>
            <p>Add, update, view and manage student records.</p>
            <a class="btn" href="${pageContext.request.contextPath}/student">Manage Students</a>
        </div>

        <div class="action-card">
            <div class="icon">📚</div>
            <h3>Course Management</h3>
            <p>Manage available school courses.</p>
            <a class="btn" href="${pageContext.request.contextPath}/course">Manage Courses</a>
        </div>

        <div class="action-card">
            <div class="icon">📝</div>
            <h3>Weekly Tests</h3>
            <p>Record and manage student test marks.</p>
            <a class="btn" href="${pageContext.request.contextPath}/weeklytest">Manage Tests</a>
        </div>

        <div class="action-card">
            <div class="icon">👨‍🏫</div>
            <h3>Staff Management</h3>
            <p>Create and manage staff login accounts.</p>
            <a class="btn" href="${pageContext.request.contextPath}/staff-management">Manage Staff</a>
        </div>
    </div>
</main>
</body>
</html>
