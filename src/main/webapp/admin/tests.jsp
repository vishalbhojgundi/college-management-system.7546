<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Weekly Tests | Sunrise College</title>

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


    List<WeeklyTest> tests =
        (List<WeeklyTest>) request.getAttribute("tests");

    List<Student> students =
        (List<Student>) request.getAttribute("students");
%>


<header>

    <h1>Sunrise College</h1>

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

            <h2>📝 Weekly Test Management</h2>

            <p>
                Record and manage student test marks.
            </p>

        </div>

    </div>


    <!-- ADD TEST -->

    <div class="card">

        <h2>➕ Add Weekly Test Mark</h2>

        <form action="${pageContext.request.contextPath}/weeklytest"
              method="post">

            <input type="hidden"
                   name="action"
                   value="add">


            <div class="form-grid">


                <div>

                    <label>
                        Test ID
                    </label>

                    <input
                        type="text"
                        name="testId"
                        placeholder="Example: TEST001"
                        required>

                </div>


                <div>

                    <label>
                        Student
                    </label>

                    <select name="regNo"
                            required>

                        <option value="">
                            Select Student
                        </option>

                        <%
                            if (students != null) {

                                for (Student s : students) {
                        %>

                            <option value="<%= s.getRegNo() %>">

                                <%= s.getRegNo() %>
                                -
                                <%= s.getName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <div>

                    <label>
                        Marks
                    </label>

                    <input
                        type="number"
                        name="marks"
                        min="0"
                        max="100"
                        placeholder="0 - 100"
                        required>

                </div>


            </div>


            <button type="submit"
                    class="btn">

                ➕ Add Test Mark

            </button>

        </form>

    </div>


    <!-- TEST LIST -->

    <div class="card">

        <h2>📊 Weekly Test Records</h2>

        <p>
            Student test performance records.
        </p>


        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>Test ID</th>

                        <th>Student</th>

                        <th>Reg No</th>

                        <th>Marks</th>

                        <th>Action</th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (tests == null ||
                        tests.isEmpty()) {
                %>

                    <tr>

                        <td colspan="5"
                            style="text-align:center;">

                            No weekly test records found.

                        </td>

                    </tr>

                <%
                    } else {

                        for (WeeklyTest t : tests) {
                %>

                    <tr>

                        <td>

                            <strong>
                                <%= t.getTestId() %>
                            </strong>

                        </td>

                        <td>
                            <%= t.getStudentName() %>
                        </td>

                        <td>
                            <%= t.getRegNo() %>
                        </td>

                        <td>

                            <span class="badge badge-success">

                                <%= t.getMarks() %> / 100

                            </span>

                        </td>

                        <td>

                            <a
                                class="btn btn-danger delete-btn"
                                data-confirm="Delete this test record?"
                                href="${pageContext.request.contextPath}/weeklytest?action=delete&testId=<%= t.getTestId() %>">

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