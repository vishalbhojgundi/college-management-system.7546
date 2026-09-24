<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - College Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <h1>Sunrise College</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
    </nav>
</header>

<div class="container login-box">
    <div class="card">
        <h2>Login</h2>

        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <label>Username</label>
            <input type="text" name="username" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit" class="btn">Login</button>
        </form>

        <p style="margin-top:14px;font-size:13px;color:#666;">
            Admin / Staff / Parent accounts are provisioned by the college.
        </p>
    </div>
</div>
</body>
</html>
