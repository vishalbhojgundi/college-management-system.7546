<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <title>Manage Staff</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

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
                request.getContextPath() +
                "/login.jsp"
        );

        return;
    }


    List<User> staffList =
            (List<User>) request.getAttribute("staffList");

    if (staffList == null) {
        staffList = new java.util.ArrayList<>();
    }
%>


<!-- HEADER -->

<header>

    <h1>Sunrise College - Staff Management</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </nav>

</header>


<div class="container">


    <!-- ADD STAFF -->

    <div class="card">

        <h2>Add Staff</h2>

        <p>
            Create a login account for a new staff member.
        </p>


        <% if (request.getAttribute("error") != null) { %>

            <p class="error">
                <%= request.getAttribute("error") %>
            </p>

        <% } %>


        <form action="${pageContext.request.contextPath}/staff-management"
              method="post">


            <label>
                Staff Username
            </label>

            <input
                type="text"
                name="username"
                placeholder="Enter staff username"
                required
            >


            <label>
                Password
            </label>

            <input
                type="password"
                name="password"
                placeholder="Enter password"
                required
            >


            <button type="submit" class="btn">
                Add Staff
            </button>

        </form>

    </div>


    <!-- STAFF LIST -->

    <div class="card">

        <h2>All Staff</h2>


        <table>

            <tr>

                <th>ID</th>

                <th>Username</th>

                <th>Role</th>

                <th>Action</th>

            </tr>


            <%
                if (staffList.isEmpty()) {
            %>

                <tr>

                    <td colspan="4">
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
                        <%= staff.getUsername() %>
                    </td>

                    <td>
                        <%= staff.getRole() %>
                    </td>

                    <td>

                        <a
                            class="btn btn-danger"
                            href="${pageContext.request.contextPath}/staff-management?action=delete&userId=<%= staff.getUserId() %>"
                            onclick="return confirm('Are you sure you want to delete this staff account?');"
                        >
                            Delete
                        </a>

                    </td>

                </tr>


            <%
                    }
                }
            %>

        </table>

    </div>


</div>

</body>

</html>