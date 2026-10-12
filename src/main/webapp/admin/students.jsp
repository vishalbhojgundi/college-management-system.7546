<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.Course" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Students | BTVP School</title>

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


    List<Student> students =
        (List<Student>) request.getAttribute("students");

    List<Course> courses =
        (List<Course>) request.getAttribute("courses");

    Student editStudent =
        (Student) request.getAttribute("editStudent");

    boolean isEdit =
        editStudent != null;
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

            <h2>
                👨‍🎓 Student Management
            </h2>

            <p>
                Add, update and manage student information.
            </p>

        </div>

    </div>


    <!-- ADD / UPDATE STUDENT -->

    <div class="card">

        <h2>
            <%= isEdit ? "✏️ Update Student" : "➕ Add Student" %>
        </h2>

        <p style="margin-bottom:20px;">
            Enter the student's academic and personal information.
        </p>


        <form action="${pageContext.request.contextPath}/student"
              method="post">

            <input type="hidden"
                   name="action"
                   value="<%= isEdit ? "update" : "add" %>">


            <div class="form-grid">


                <div>

                    <label>
                        Registration Number
                    </label>

                    <input
                        type="text"
                        name="regNo"
                        value="<%= isEdit ? editStudent.getRegNo() : "" %>"
                        <%= isEdit ? "readonly" : "" %>
                        placeholder="Example: STU001"
                        required>

                </div>


                <div>

                    <label>
                        Student Name
                    </label>

                    <input
                        type="text"
                        name="name"
                        value="<%= isEdit ? editStudent.getName() : "" %>"
                        placeholder="Enter student name"
                        required>

                </div>


                <div>

                    <label>
                        Class
                    </label>

                    <input
                        type="number"
                        name="classNo"
                        value="<%= isEdit ? editStudent.getClassNo() : "" %>"
                        placeholder="Enter class"
                        required>

                </div>


                <div>

                    <label>
                        Course
                    </label>

                    <select name="courseId" required>

                        <option value="">
                            Select Course
                        </option>

                        <%
                            if (courses != null) {

                                for (Course c : courses) {
                        %>

                            <option
                                value="<%= c.getCourseId() %>"
                                <%= (isEdit &&
                                     c.getCourseId().equals(
                                         editStudent.getCourseId()
                                     ))
                                     ? "selected"
                                     : "" %>>

                                <%= c.getCourseName() %>

                            </option>

                        <%
                                }
                            }
                        %>

                    </select>

                </div>


                <div>

                    <label>
                        Gender
                    </label>

                    <select name="gender">

                        <option
                            <%= isEdit &&
                                "Male".equals(editStudent.getGender())
                                ? "selected"
                                : "" %>>
                            Male
                        </option>

                        <option
                            <%= isEdit &&
                                "Female".equals(editStudent.getGender())
                                ? "selected"
                                : "" %>>
                            Female
                        </option>

                        <option
                            <%= isEdit &&
                                "Other".equals(editStudent.getGender())
                                ? "selected"
                                : "" %>>
                            Other
                        </option>

                    </select>

                </div>


                <div>

                    <label>
                        Village
                    </label>

                    <input
                        type="text"
                        name="villege"
                        value="<%= isEdit ? editStudent.getVillege() : "" %>"
                        placeholder="Enter village"
                        required>

                </div>


                <div>

                    <label>
                        Pincode
                    </label>

                    <input
                        type="number"
                        name="pincode"
                        value="<%= isEdit ? editStudent.getPincode() : "" %>"
                        placeholder="Enter pincode"
                        required>

                </div>


                <div>

                    <label>
                        State
                    </label>

                    <input
                        type="text"
                        name="state"
                        value="<%= isEdit ? editStudent.getState() : "Karnataka" %>"
                        placeholder="Enter state">

                </div>


            </div>


            <button type="submit" class="btn">

                <%= isEdit ? "✏️ Update Student" : "➕ Add Student" %>

            </button>


            <% if (isEdit) { %>

                <a
                    href="${pageContext.request.contextPath}/student"
                    class="btn btn-secondary">

                    Cancel

                </a>

            <% } %>


        </form>

    </div>


    <!-- STUDENT LIST -->

    <div class="card">

        <div class="dashboard-heading">

            <div>

<!-- Filter students by class -->
<div class="card class-filter-card">
    <h2>🔎 Filter Students by Class</h2>

    <form action="${pageContext.request.contextPath}/student"
          method="get"
          class="class-filter-form">

        <label for="classNo">Select Class</label>

        <select name="classNo" id="classNo"
                onchange="this.form.submit()">

            <option value="all"
                ${empty selectedClass || selectedClass == 'all' ? 'selected' : ''}>
                All Classes
            </option>

            <option value="7"
                ${selectedClass == '7' ? 'selected' : ''}>
                Class 7
            </option>

            <option value="8"
                ${selectedClass == '8' ? 'selected' : ''}>
                Class 8
            </option>

            <option value="9"
                ${selectedClass == '9' ? 'selected' : ''}>
                Class 9
            </option>

            <option value="10"
                ${selectedClass == '10' ? 'selected' : ''}>
                Class 10
            </option>

        </select>
    </form>
</div>


                <h2>
                    📋 All Students
                </h2>

                <p>
                    Registered students in the system.
                </p>

            </div>

        </div>


        <div class="table-wrapper">

            <table>

                <thead>

                    <tr>

                        <th>Reg No</th>
                        <th>Name</th>
                        <th>Class</th>
                        <th>Course</th>
                        <th>Gender</th>
                        <th>Village</th>
                        <th>Pincode</th>
                        <th>State</th>
                        <th>Actions</th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (students == null ||
                        students.isEmpty()) {
                %>

                    <tr>

                        <td colspan="9"
                            style="text-align:center;">

                            No students found.

                        </td>

                    </tr>

                <%
                    } else {

                        for (Student s : students) {
                %>

                    <tr>

                        <td>
                            <strong>
                                <%= s.getRegNo() %>
                            </strong>
                        </td>

                        <td>
                            <%= s.getName() %>
                        </td>

                        <td>
                            <%= s.getClassNo() %>
                        </td>

                        <td>
                            <%= s.getCourseName() %>
                        </td>

                        <td>
                            <span class="badge badge-primary">
                                <%= s.getGender() %>
                            </span>
                        </td>

                        <td>
                            <%= s.getVillege() %>
                        </td>

                        <td>
                            <%= s.getPincode() %>
                        </td>

                        <td>
                            <%= s.getState() %>
                        </td>

                        <td>

                            <a
                                class="btn"
                                href="${pageContext.request.contextPath}/student?action=edit&regNo=<%= s.getRegNo() %>">

                                Edit

                            </a>


                            <a
                                class="btn btn-danger delete-btn"
                                data-confirm="Delete this student?"
                                href="${pageContext.request.contextPath}/student?action=delete&regNo=<%= s.getRegNo() %>">

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