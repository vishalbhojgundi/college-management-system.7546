
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | BTVP HIGH SCHOOL</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin-ui.css">

    <style>
        /* Login page only */
        body.login-screen {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background:
                radial-gradient(circle at 15% 20%, #e2ecff 0, transparent 35%),
                linear-gradient(135deg, #f4f7fb, #eaf0fa);
        }

        body.login-screen > header {
            flex-shrink: 0;
        }

        .login-page {
            flex: 1;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 44px 20px;
        }

        .login-box {
            width: 100%;
            max-width: 440px;
            margin: 0 auto;
        }

        .login-card {
            width: 100%;
            padding: 36px;
            border: 1px solid #e0e7f0;
            border-radius: 18px;
            background: #ffffff;
            box-shadow: 0 18px 55px rgba(21, 52, 91, 0.12);
        }

        .login-logo {
            width: 64px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            border-radius: 18px;
            background: #eaf1ff;
            font-size: 32px;
        }

        .login-title {
            margin-bottom: 25px;
            text-align: center;
        }

        .login-title h2 {
            margin: 0 0 8px;
            color: #15345b;
            font-size: 28px;
            line-height: 1.3;
        }

        .login-title p {
            margin: 0;
            color: #69788d;
            font-size: 14px;
        }

        .login-card form {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .login-card form label {
            margin: 7px 0 0;
            color: #34445a;
            font-size: 13px;
            font-weight: 700;
        }

        .login-card form input {
            width: 100%;
            min-height: 48px;
            padding: 12px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 9px;
            background: #fff;
            color: #243247;
            font-size: 14px;
        }

        .login-card form input:focus {
            border-color: #2868d7;
            outline: none;
            box-shadow: 0 0 0 3px rgba(40, 104, 215, 0.12);
        }

        .login-card form .btn {
            width: 100%;
            min-height: 48px;
            margin-top: 12px;
            border: 1px solid #2868d7;
            border-radius: 9px;
            background: #2868d7;
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .login-card form .btn:hover {
            background: #1e54b5;
            border-color: #1e54b5;
        }

        .login-note {
            margin: 23px 0 0;
            color: #69788d;
            font-size: 13px;
            line-height: 1.6;
            text-align: center;
        }

        .login-card .error {
            margin-bottom: 18px;
            padding: 11px 13px;
            border: 1px solid #f2c3c3;
            border-radius: 8px;
            background: #fff0f0;
            color: #a61f1f;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .login-page {
                padding: 28px 16px;
            }

            .login-card {
                padding: 27px 22px;
                border-radius: 14px;
            }

            .login-title h2 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body class="login-screen">

<header>
    <h1>🎓 BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
    </nav>
</header>

<main class="login-page">
    <div class="login-box">
        <div class="login-card">

            <div class="login-logo" aria-hidden="true">🎓</div>

            <div class="login-title">
                <h2>Welcome Back</h2>
                <p>School Management Portal</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login"
                  method="post">

                <label for="username">Username</label>
                <input id="username"
                       type="text"
                       name="username"
                       placeholder="Enter username"
                       autocomplete="username"
                       required>

                <label for="password">Password</label>
                <input id="password"
                       type="password"
                       name="password"
                       placeholder="Enter password"
                       autocomplete="current-password"
                       required>

                <button type="submit" class="btn">Login</button>
            </form>

            <p class="login-note">
                Admin and Staff accounts are provided by the school.
            </p>

        </div>
    </div>
</main>

</body>
</html>
