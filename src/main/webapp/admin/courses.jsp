<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.Course" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Courses | BTVP SCHOOL</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <script src="${pageContext.request.contextPath}/js/script.js"
            defer></script>

</head>


<body>


<%
    User user =
        (session != null)
        ? (User) session.getAttribute("user")
        : null;

    if (user == null ||
        !("ADMIN".equals(user.getRole()) ||
          "STAFF".equals(user.getRole()))) {

        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );

        return;
    }

    List<Course> courses =
        (List<Course>) request.getAttribute("courses");
%>


<header>

    <h1>BTVP HIGH SCHOOL</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">
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

            <h2>📚 Course Management</h2>

            <p>
                Add and manage school courses.
            </p>

        </div>

    </div>


    <!-- ADD COURSE -->

    <div class="card">

        <h2>➕ Add Course</h2>

        <form action="${pageContext.request.contextPath}/course"
              method="post">

            <input type="hidden"
                   name="action"
                   value="add">


            <div class="form-grid">

                <div>

                    <label>
                        Course ID
                    </label>

                    <input
                        type="text"
                        name="courseId"
                        placeholder="Example: CS01"
                        required>

                </div>


                <div>

                    <label>
                        Course Name
                    </label>

                    <input
                        type="text"
                        name="courseName"
                        placeholder="Example: Computer Science"
                        required>

                </div>

            </div>


            <button type="submit"
                    class="btn">

                ➕ Add Course

            </button>

        </form>

    </div>


    <!-- COURSE LIST -->

    <div class="card">

        <h2>📋 All Courses</h2>

        <p>
            Available courses in the School.
        </p>


        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>Course ID</th>

                        <th>Course Name</th>

                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (courses == null ||
                        courses.isEmpty()) {
                %>

                    <tr>

                        <td colspan="3"
                            style="text-align:center;">

                            No courses found.

                        </td>

                    </tr>

                <%
                    } else {

                        for (Course c : courses) {
                %>

                    <tr>

                        <td>

                            <strong>
                                <%= c.getCourseId() %>
                            </strong>

                        </td>

                        <td>
                            <%= c.getCourseName() %>
                        </td>

                        <td>

                            <a
                                class="btn btn-danger delete-btn"
                                data-confirm="Delete this course?"
                                href="${pageContext.request.contextPath}/course?action=delete&courseId=<%= c.getCourseId() %>">

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