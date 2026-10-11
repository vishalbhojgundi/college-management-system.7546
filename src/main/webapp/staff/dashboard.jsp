
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="dashboard-body">
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"STAFF".equals(user.getRole())) {
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
            <p>Manage student academic records and assessments.</p>
        </div>
        <span class="badge badge-success">STAFF</span>
    </div>

    <div class="grid-3">
        <div class="action-card">
            <div class="icon">👨‍🎓</div>
            <h3>Students</h3>
            <p>Add and manage student records.</p>
            <a class="btn" href="${pageContext.request.contextPath}/student">Manage Students</a>
        </div>

        <div class="action-card">
            <div class="icon">📝</div>
            <h3>Weekly Tests</h3>
            <p>Record marks and review student assessments.</p>
            <a class="btn" href="${pageContext.request.contextPath}/weeklytest">Manage Tests</a>
        </div>

        <div class="action-card">
            <div class="icon">📚</div>
            <h3>Courses</h3>
            <p>View and manage available courses.</p>
            <a class="btn" href="${pageContext.request.contextPath}/course">Manage Courses</a>
        </div>
    </div>
</main>
</body>
</html>
