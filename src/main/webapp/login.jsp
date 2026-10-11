
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <h1>BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
    </nav>
</header>

<main class="login-page">
    <div class="login-box">
        <div class="login-card">
            <div class="login-logo">🎓</div>
            <div class="login-title">
                <h2>Welcome Back</h2>
                <p>School Management Portal</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <label for="username">Username</label>
                <input id="username" type="text" name="username"
                       placeholder="Enter username"
                       autocomplete="username" required>

                <label for="password">Password</label>
                <input id="password" type="password" name="password"
                       placeholder="Enter password"
                       autocomplete="current-password" required>

                <button type="submit" class="btn" style="width:100%">
                    Login
                </button>
            </form>

            <p class="muted" style="text-align:center;margin-top:20px">
                Admin and Staff accounts are provided by the school.
            </p>
        </div>
    </div>
</main>
</body>
</html>
