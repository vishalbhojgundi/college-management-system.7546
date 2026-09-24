<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Sunrise College</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>


<header>

    <h1>Sunrise College</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/index.jsp">
            ← Home
        </a>

    </nav>

</header>


<main class="login-page">

    <div class="login-box">

        <div class="login-card">

            <div class="login-logo">
                🎓
            </div>

            <div class="login-title">

                <h2>Welcome Back</h2>

                <p>
                    College Management Portal
                </p>

            </div>


            <% if (request.getAttribute("error") != null) { %>

                <div class="error">

                    <%= request.getAttribute("error") %>

                </div>

            <% } %>


            <form action="${pageContext.request.contextPath}/login"
                  method="post">

                <label>
                    Username
                </label>

                <input
                    type="text"
                    name="username"
                    placeholder="Enter username"
                    autocomplete="username"
                    required>


                <label>
                    Password
                </label>

                <input
                    type="password"
                    name="password"
                    placeholder="Enter password"
                    autocomplete="current-password"
                    required>


                <button
                    type="submit"
                    class="btn"
                    style="width:100%; margin-top:5px;">

                    🔐 Login

                </button>

            </form>


            <p style="
                text-align:center;
                margin-top:20px;
                font-size:12px;
                color:#64748b;
            ">

                Admin / Staff accounts are provisioned
                by the college.

            </p>

        </div>

    </div>

</main>


</body>

</html>