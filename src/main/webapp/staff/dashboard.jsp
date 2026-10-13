
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Staff Dashboard | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-ui.css">
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"STAFF".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<header>
    <h1>🎓 BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/student">Students</a>
        <a href="${pageContext.request.contextPath}/course">Courses</a>
        <a href="${pageContext.request.contextPath}/weeklytest">Weekly Tests</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="dashboard-container">
    <section class="dashboard-heading">
        <div>
            <h2>Welcome, <%= user.getUsername() %>!</h2>
            <p>Manage student information and academic assessments.</p>
        </div>
        <span class="badge badge-success">STAFF</span>
    </section>

    <section class="grid-3">
        <article class="action-card">
            <div class="icon">👨‍🎓</div>
            <h3>Student Management</h3>
            <p>Add and update student details, and filter student records by class.</p>
            <a class="btn" href="${pageContext.request.contextPath}/student">Manage Students</a>
        </article>

        <article class="action-card">
            <div class="icon">📝</div>
            <h3>Weekly Tests</h3>
            <p>Enter marks for a class and review student assessment results.</p>
            <a class="btn" href="${pageContext.request.contextPath}/weeklytest">Manage Tests</a>
        </article>

        <article class="action-card">
            <div class="icon">📚</div>
            <h3>Courses</h3>
            <p>Open the course management module to view the available courses.</p>
            <a class="btn" href="${pageContext.request.contextPath}/course">View Courses</a>
        </article>
    </section>

    <section class="card" style="margin-top:22px;">
        <h2>Assessment Reminder</h2>
        <p>Enter marks between 0 and 100. Marks below 40 are displayed as FAIL; marks of 40 or above are displayed as PASS.</p>
    </section>
</main>
</body>
</html>
