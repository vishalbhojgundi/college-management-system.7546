<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.User" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | Sunrise College</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>


<body class="dashboard-body">


<%
    User user =
        (session != null)
        ? (User) session.getAttribute("user")
        : null;

    if (user == null ||
        !"ADMIN".equals(user.getRole())) {

        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );

        return;
    }
%>


<header>

    <h1>Sunrise College</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/index.jsp">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            🚪 Logout
        </a>

    </nav>

</header>


<main class="dashboard-container">


    <div class="dashboard-heading">

        <div>

            <h2>
                Welcome, <%= user.getUsername() %> 👋
            </h2>

            <p>
                Manage the college system from your dashboard.
            </p>

        </div>

        <span class="badge badge-primary">
            ADMIN
        </span>

    </div>


    <!-- STAT CARDS -->

    <div class="grid-4">

        <div class="stat-card">

            <div class="stat-icon">
                👨‍🎓
            </div>

            <div class="stat-content">

                <span>
                    Students
                </span>

                <strong>
                    —
                </strong>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                📚
            </div>

            <div class="stat-content">

                <span>
                    Courses
                </span>

                <strong>
                    —
                </strong>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                📝
            </div>

            <div class="stat-content">

                <span>
                    Weekly Tests
                </span>

                <strong>
                    —
                </strong>

            </div>

        </div>


        <div class="stat-card">

            <div class="stat-icon">
                👨‍🏫
            </div>

            <div class="stat-content">

                <span>
                    Staff
                </span>

                <strong>
                    —
                </strong>

            </div>

        </div>

    </div>


    <br>


    <div class="section-title"
         style="text-align:left;">

        <h2>
            Quick Management
        </h2>

        <p>
            Choose an option to manage college records.
        </p>

    </div>


    <!-- ACTION CARDS -->

    <div class="grid-2">


        <div class="action-card">

            <div class="icon">
                👨‍🎓
            </div>

            <h3>
                Student Management
            </h3>

            <p>
                Add, update and delete student records.
            </p>

            <a class="btn"
               href="${pageContext.request.contextPath}/student">

                Manage Students →

            </a>

        </div>


        <div class="action-card">

            <div class="icon">
                📚
            </div>

            <h3>
                Course Management
            </h3>

            <p>
                Add and manage college courses.
            </p>

            <a class="btn"
               href="${pageContext.request.contextPath}/course">

                Manage Courses →

            </a>

        </div>


        <div class="action-card">

            <div class="icon">
                📝
            </div>

            <h3>
                Weekly Tests
            </h3>

            <p>
                Record and manage student test marks.
            </p>

            <a class="btn"
               href="${pageContext.request.contextPath}/weeklytest">

                Manage Tests →

            </a>

        </div>


        <div class="action-card">

            <div class="icon">
                👨‍🏫
            </div>

            <h3>
                Staff Management
            </h3>

            <p>
                Create and manage staff login accounts.
            </p>

            <a class="btn"
               href="${pageContext.request.contextPath}/staff-management">

                Manage Staff →

            </a>

        </div>


    </div>


</main>


</body>

</html>