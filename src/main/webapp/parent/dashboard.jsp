<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !"PARENT".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<header>
    <h1>Sunrise College - Parent Portal</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="card">
        <h2>Welcome, <%= user.getUsername() %></h2>
        <p>Search for your child's records and weekly-test results below.
           You can view information only; editing is not available for parent accounts.</p>
        <a class="btn" href="${pageContext.request.contextPath}/search-student.jsp">Search Student</a>
    </div>
</div>
</body>
</html>
