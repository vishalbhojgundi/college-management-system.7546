<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.Student, com.college.model.WeeklyTest, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Student</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <h1>Sunrise College</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/parent/dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">
    <div class="card">
        <h2>Search Student</h2>
        <form action="${pageContext.request.contextPath}/searchStudent" method="get">
            <label>Search by Registration No. or Name</label>
            <input type="text" name="keyword" placeholder="e.g. REG001 or Rahul">
            <button type="submit" class="btn">Search</button>
        </form>
    </div>

    <%
        List<Student> results = (List<Student>) request.getAttribute("results");
        Student student = (Student) request.getAttribute("student");
        List<WeeklyTest> tests = (List<WeeklyTest>) request.getAttribute("tests");
    %>

    <% if (results != null) { %>
        <div class="card">
            <h2>Search Results</h2>
            <% if (results.isEmpty()) { %>
                <p>No students found.</p>
            <% } else { %>
                <table>
                    <tr><th>Reg No</th><th>Name</th><th>Course</th><th>Class</th><th></th></tr>
                    <% for (Student s : results) { %>
                        <tr>
                            <td><%= s.getRegNo() %></td>
                            <td><%= s.getName() %></td>
                            <td><%= s.getCourseName() %></td>
                            <td><%= s.getClassNo() %></td>
                            <td>
                                <a class="btn" href="${pageContext.request.contextPath}/searchStudent?regNo=<%= s.getRegNo() %>">View</a>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } %>
        </div>
    <% } %>

    <% if (student != null) { %>
        <div class="card">
            <h2>Student Details</h2>
            <p><strong>Reg No:</strong> <%= student.getRegNo() %></p>
            <p><strong>Name:</strong> <%= student.getName() %></p>
            <p><strong>Course:</strong> <%= student.getCourseName() %></p>
            <p><strong>Class:</strong> <%= student.getClassNo() %></p>
            <p><strong>Gender:</strong> <%= student.getGender() %></p>
            <p><strong>Village:</strong> <%= student.getVillege() %></p>
            <p><strong>Pincode:</strong> <%= student.getPincode() %></p>
            <p><strong>State:</strong> <%= student.getState() %></p>
        </div>

        <div class="card">
            <h2>Weekly Test Results</h2>
            <% if (tests == null || tests.isEmpty()) { %>
                <p>No test records yet.</p>
            <% } else { %>
                <table>
                    <tr><th>Test ID</th><th>Marks</th></tr>
                    <% for (WeeklyTest t : tests) { %>
                        <tr>
                            <td><%= t.getTestId() %></td>
                            <td><%= t.getMarks() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } %>
        </div>
    <% } else if (request.getParameter("regNo") != null) { %>
        <div class="card"><p>Student not found.</p></div>
    <% } %>
</div>
</body>
</html>
