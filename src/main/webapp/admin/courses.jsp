<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.Course, com.college.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Courses</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Course> courses = (List<Course>) request.getAttribute("courses");
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
        <h2>Add Course</h2>
        <form action="${pageContext.request.contextPath}/course" method="post">
            <input type="hidden" name="action" value="add">
            <label>Course ID</label>
            <input type="text" name="courseId" required>
            <label>Course Name</label>
            <input type="text" name="courseName" required>
            <button type="submit" class="btn">Add</button>
        </form>
    </div>

    <div class="card">
        <h2>All Courses</h2>
        <table>
            <tr><th>Course ID</th><th>Course Name</th><th></th></tr>
            <% for (Course c : courses) { %>
                <tr>
                    <td><%= c.getCourseId() %></td>
                    <td><%= c.getCourseName() %></td>
                    <td>
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/course?action=delete&courseId=<%= c.getCourseId() %>"
                           onclick="return confirm('Delete this course?');">Delete</a>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
