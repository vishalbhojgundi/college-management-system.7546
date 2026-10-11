<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Staff Management | BTVP High School</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <script src="${pageContext.request.contextPath}/js/script.js"
            defer></script>

</head>


<body>


<%
    User admin =
        (session != null)
        ? (User) session.getAttribute("user")
        : null;

    if (admin == null ||
        !"ADMIN".equals(admin.getRole())) {

        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );

        return;
    }


    List<User> staffList =
        (List<User>) request.getAttribute("staffList");

    if (staffList == null) {

        staffList =
            new java.util.ArrayList<>();

    }
%>


<header>

    <h1>BTVP HIGH SCHOOL</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            🚪 Logout
        </a>

    </nav>

</header>


<main class="container">


    <div class="dashboard-heading">

        <div>

            <h2>👨‍🏫 Staff Management</h2>

            <p>
                Create and manage staff login accounts.
            </p>

        </div>

        <span class="badge badge-primary">
            ADMIN ONLY
        </span>

    </div>


    <!-- ADD STAFF -->

    <div class="card">

        <h2>➕ Add Staff Account</h2>

        <p style="margin-bottom:20px;">
            Create a username and password for a staff member.
        </p>


        <% if (request.getAttribute("error") != null) { %>

            <div class="error">

                <%= request.getAttribute("error") %>

            </div>

        <% } %>


        <form action="${pageContext.request.contextPath}/staff-management"
              method="post">


            <div class="form-grid">

                <div>

                    <label>
                        Staff Username
                    </label>

                    <input
                        type="text"
                        name="username"
                        placeholder="Enter username"
                        required>

                </div>


                <div>

                    <label>
                        Password
                    </label>

                    <input
                        type="password"
                        name="password"
                        placeholder="Enter password"
                        required>

                </div>

            </div>


            <button type="submit"
                    class="btn">

                👨‍🏫 Create Staff Account

            </button>

        </form>

    </div>


    <!-- STAFF LIST -->

    <div class="card">

        <h2>📋 Staff Accounts</h2>

        <p>
            Staff members currently registered in the system.
        </p>


        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>ID</th>

                        <th>Username</th>

                        <th>Role</th>

                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (staffList.isEmpty()) {
                %>

                    <tr>

                        <td colspan="4"
                            style="text-align:center;">

                            No staff accounts found.

                        </td>

                    </tr>

                <%
                    } else {

                        for (User staff : staffList) {
                %>

                    <tr>

                        <td>
                            <%= staff.getUserId() %>
                        </td>

                        <td>

                            <strong>
                                <%= staff.getUsername() %>
                            </strong>

                        </td>

                        <td>

                            <span class="badge badge-success">
                                <%= staff.getRole() %>
                            </span>

                        </td>

                        <td>

                            <a
                                class="btn btn-danger delete-btn"
                                data-confirm="Are you sure you want to delete this staff account?"
                                href="${pageContext.request.contextPath}/staff-management?action=delete&userId=<%= staff.getUserId() %>">

                                Delete

                            </a>

                        </td>

                    </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>


</main>


</body>

</html>