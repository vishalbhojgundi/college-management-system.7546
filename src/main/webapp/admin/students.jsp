<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.Student, com.college.model.Course, com.college.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Students</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Student> students = (List<Student>) request.getAttribute("students");
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    Student editStudent = (Student) request.getAttribute("editStudent");
    boolean isEdit = editStudent != null;
%>
<header>
    <h1>Sunrise College</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="card">
        <h2><%= isEdit ? "Update Student" : "Add Student" %></h2>
        <form action="${pageContext.request.contextPath}/student" method="post">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "add" %>">

            <label>Registration No.</label>
            <input type="text" name="regNo" value="<%= isEdit ? editStudent.getRegNo() : "" %>"
                   <%= isEdit ? "readonly" : "" %> required>

            <label>Name</label>
            <input type="text" name="name" value="<%= isEdit ? editStudent.getName() : "" %>" required>

            <label>Class</label>
            <input type="number" name="classNo" value="<%= isEdit ? editStudent.getClassNo() : "" %>" required>

            <label>Course</label>
            <select name="courseId" required>
                <% for (Course c : courses) { %>
                    <option value="<%= c.getCourseId() %>"
                        <%= (isEdit && c.getCourseId().equals(editStudent.getCourseId())) ? "selected" : "" %>>
                        <%= c.getCourseName() %>
                    </option>
                <% } %>
            </select>

            <label>Gender</label>
            <select name="gender">
                <option <%= isEdit && "Male".equals(editStudent.getGender()) ? "selected" : "" %>>Male</option>
                <option <%= isEdit && "Female".equals(editStudent.getGender()) ? "selected" : "" %>>Female</option>
                <option <%= isEdit && "Other".equals(editStudent.getGender()) ? "selected" : "" %>>Other</option>
            </select>

            <label>Village</label>
            <input type="text" name="villege" value="<%= isEdit ? editStudent.getVillege() : "" %>" required>

            <label>Pincode</label>
            <input type="number" name="pincode" value="<%= isEdit ? editStudent.getPincode() : "" %>" required>

            <label>State</label>
            <input type="text" name="state" value="<%= isEdit ? editStudent.getState() : "Karnataka" %>">

            <button type="submit" class="btn"><%= isEdit ? "Update" : "Add" %></button>
        </form>
    </div>

    <div class="card">
        <h2>All Students</h2>
        <table>
            <tr>
                <th>Reg No</th><th>Name</th><th>Class</th><th>Course</th>
                <th>Gender</th><th>Village</th><th>Pincode</th><th>State</th><th></th>
            </tr>
            <% for (Student s : students) { %>
                <tr>
                    <td><%= s.getRegNo() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getClassNo() %></td>
                    <td><%= s.getCourseName() %></td>
                    <td><%= s.getGender() %></td>
                    <td><%= s.getVillege() %></td>
                    <td><%= s.getPincode() %></td>
                    <td><%= s.getState() %></td>
                    <td>
                        <a class="btn" href="${pageContext.request.contextPath}/student?action=edit&regNo=<%= s.getRegNo() %>">Edit</a>
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/student?action=delete&regNo=<%= s.getRegNo() %>"
                           onclick="return confirm('Delete this student?');">Delete</a>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
