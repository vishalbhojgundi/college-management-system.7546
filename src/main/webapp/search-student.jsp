
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.Student,com.college.model.WeeklyTest,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Student | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <h1>BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/parent/dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="container">
    <div class="card">
        <h2>Search Student</h2>
        <form action="${pageContext.request.contextPath}/searchStudent" method="get">
            <label for="keyword">Search by Registration Number or Name</label>
            <input id="keyword" type="text" name="keyword"
                   placeholder="Enter registration number or name">
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
        <div class="table-wrapper">
            <table>
                <thead>
                <tr><th>Registration No.</th><th>Name</th><th>Course</th><th>Class</th><th>Action</th></tr>
                </thead>
                <tbody>
                <% for (Student s : results) { %>
                <tr>
                    <td><%= s.getRegNo() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getCourseName() %></td>
                    <td><%= s.getClassNo() %></td>
                    <td>
                        <a class="btn"
                           href="${pageContext.request.contextPath}/searchStudent?regNo=<%= java.net.URLEncoder.encode(s.getRegNo(), "UTF-8") %>">View</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
    <% } %>

    <% if (student != null) { %>
    <div class="card">
        <h2>Student Details</h2>
        <p><strong>Registration No.:</strong> <%= student.getRegNo() %></p>
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
        <div class="table-wrapper">
            <table>
                <thead><tr><th>Test ID</th><th>Marks</th><th>Result</th></tr></thead>
                <tbody>
                <% for (WeeklyTest t : tests) { %>
                <tr>
                    <td><%= t.getTestId() %></td>
                    <td><%= t.getMarks() %> / 100</td>
                    <td>
                        <% if (t.getMarks() < 40) { %>
                            <span class="result-fail">FAIL</span>
                        <% } else { %>
                            <span class="result-pass">PASS</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
    <% } else if (request.getParameter("regNo") != null) { %>
        <div class="card"><p>Student not found.</p></div>
    <% } %>
</main>
</body>
</html>
