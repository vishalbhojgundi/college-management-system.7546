<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.WeeklyTest, com.college.model.Student, com.college.model.User, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Weekly Tests</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%
    User user = (session != null) ? (User) session.getAttribute("user") : null;
    if (user == null || !("ADMIN".equals(user.getRole()) || "STAFF".equals(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<WeeklyTest> tests = (List<WeeklyTest>) request.getAttribute("tests");
    List<Student> students = (List<Student>) request.getAttribute("students");
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
        <h2>Add Weekly-Test Mark</h2>
        <form action="${pageContext.request.contextPath}/weeklytest" method="post">
            <input type="hidden" name="action" value="add">

            <label>Test ID</label>
            <input type="text" name="testId" required>

            <label>Student</label>
            <select name="regNo" required>
                <% for (Student s : students) { %>
                    <option value="<%= s.getRegNo() %>"><%= s.getRegNo() %> - <%= s.getName() %></option>
                <% } %>
            </select>

            <label>Marks</label>
            <input type="number" name="marks" min="0" max="100" required>

            <button type="submit" class="btn">Add</button>
        </form>
    </div>

    <div class="card">
        <h2>All Weekly-Test Records</h2>
        <table>
            <tr><th>Test ID</th><th>Student</th><th>Reg No</th><th>Marks</th><th></th></tr>
            <% for (WeeklyTest t : tests) { %>
                <tr>
                    <td><%= t.getTestId() %></td>
                    <td><%= t.getStudentName() %></td>
                    <td><%= t.getRegNo() %></td>
                    <td><%= t.getMarks() %></td>
                    <td>
                        <a class="btn btn-danger" href="${pageContext.request.contextPath}/weeklytest?action=delete&testId=<%= t.getTestId() %>"
                           onclick="return confirm('Delete this record?');">Delete</a>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
