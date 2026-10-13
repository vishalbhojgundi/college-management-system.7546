
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-ui.css">
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
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
        <a href="${pageContext.request.contextPath}/staff-management">Staff</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="dashboard-container">
    <section class="dashboard-heading">
        <div>
            <h2>Welcome, <%= user.getUsername() %>!</h2>
            <p>Manage school records, academic activities and staff accounts.</p>
        </div>
        <span class="badge badge-primary">ADMINISTRATOR</span>
    </section>

    <section class="grid-2">
        <article class="action-card">
            <div class="icon">👨‍🎓</div>
            <h3>Student Management</h3>
            <p>Add students, update details, filter by class and manage student records.</p>
            <a class="btn" href="${pageContext.request.contextPath}/student">Manage Students</a>
        </article>

        <article class="action-card">
            <div class="icon">📚</div>
            <h3>Course Management</h3>
            <p>View and manage the courses configured in the school database.</p>
            <a class="btn" href="${pageContext.request.contextPath}/course">Manage Courses</a>
        </article>

        <article class="action-card">
            <div class="icon">📝</div>
            <h3>Weekly Test Management</h3>
            <p>Enter class-wise marks, review test records and check PASS/FAIL results.</p>
            <a class="btn" href="${pageContext.request.contextPath}/weeklytest">Manage Weekly Tests</a>
        </article>

        <article class="action-card">
            <div class="icon">👨‍🏫</div>
            <h3>Staff Management</h3>
            <p>Create and manage staff login accounts and access.</p>
            <a class="btn" href="${pageContext.request.contextPath}/staff-management">Manage Staff</a>
        </article>
    </section>

    <section class="card" style="margin-top:22px;">
        <h2>School Management Overview</h2>
        <p>Use the modules above to manage student information, courses, assessments and staff accounts.</p>
        <div class="grid-3">
            <div>
                <span class="badge">Classes 7–10</span>
                <p>Organize student records by class.</p>
            </div>
            <div>
                <span class="badge">Weekly Assessments</span>
                <p>Record marks and review academic performance.</p>
            </div>
            <div>
                <span class="badge">Admin Access</span>
                <p>Manage staff accounts and school records.</p>
            </div>
        </div>
    </section>
</main>
</body>
</html>
