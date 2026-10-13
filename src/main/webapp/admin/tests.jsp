
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.TreeSet" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Weekly Tests | BTVP HIGH SCHOOL</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-ui.css">
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

    String selectedClass = (String) request.getAttribute("selectedClass");
    String testIdValue = (String) request.getAttribute("testId");
    String filterClass = (String) request.getAttribute("filterClass");
    String status = request.getParameter("status");

    if (testIdValue == null) testIdValue = "";
    if (filterClass == null || filterClass.trim().isEmpty()) filterClass = "all";

    Set<Integer> classNumbers = new TreeSet<>();
    if (students != null) {
        for (Student s : students) {
            if (s.getClassNo() >= 7 && s.getClassNo() <= 10) {
                classNumbers.add(s.getClassNo());
            }
        }
    }

    int selectedClassNo = 0;
    boolean validSelectedClass = false;
    try {
        selectedClassNo = Integer.parseInt(selectedClass);
        validSelectedClass = selectedClassNo >= 7 && selectedClassNo <= 10;
    } catch (Exception ignored) {
        validSelectedClass = false;
    }

    String safeTestId = testIdValue.replace("&", "&amp;")
            .replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;");
%>

<header>
    <h1>🎓 BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/student">Students</a>
        <a href="${pageContext.request.contextPath}/course">Courses</a>
        <% if ("ADMIN".equals(user.getRole())) { %>
            <a href="${pageContext.request.contextPath}/staff-management">Staff</a>
        <% } %>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="container">
    <section class="dashboard-heading">
        <div>
            <h2>Weekly Test Management</h2>
            <p>Enter marks class-wise and review all saved test records.</p>
        </div>
        <span class="badge badge-primary">PASS: 40–100 · FAIL: 0–39</span>
    </section>

    <% if ("saved".equals(status)) { %>
        <div class="status-message status-success">Marks saved successfully. Existing marks for this test were updated; blank marks were skipped.</div>
    <% } else if ("saveFailed".equals(status)) { %>
        <div class="status-message status-error">Marks could not be saved. Check the server console and database connection.</div>
    <% } else if ("invalidClass".equals(status) || "invalidInput".equals(status) || "invalidMarks".equals(status)) { %>
        <div class="status-message status-error">Invalid input. Choose a class from 7 to 10 and enter marks between 0 and 100.</div>
    <% } else if ("noStudents".equals(status) || "noMarks".equals(status)) { %>
        <div class="status-message">Select a class and enter at least one student's marks before saving.</div>
    <% } else if ("invalidMarks".equals(status)) { %>
        <div class="status-message status-error">Marks must be between 0 and 100.</div>
    <% } %>

    <section class="card">
        <h2>① Class-wise Marks Entry</h2>
        <p>Choose a test name and class to load students for marks entry.</p>

        <form action="${pageContext.request.contextPath}/weeklytest" method="get" id="classSelectionForm">
            <div class="marks-toolbar">
                <div>
                    <label for="testId">Test Name / Test ID</label>
                    <input type="text" id="testId" name="testId" maxlength="20"
                           value="<%= safeTestId %>"
                           placeholder="Example: Class7-First week Test" required>
                </div>
                <div>
                    <label for="classNo">Select Class</label>
                    <select id="classNo" name="classNo" required>
                        <option value="">Select class</option>
                        <% for (int c = 7; c <= 10; c++) { %>
                            <option value="<%= c %>" <%= String.valueOf(c).equals(selectedClass) ? "selected" : "" %>>
                                Class <%= c %>
                            </option>
                        <% } %>
                    </select>
                </div>
                <div>
                    <button type="submit" class="btn">Load Students</button>
                </div>
            </div>
        </form>
    </section>

    <% if (validSelectedClass && !testIdValue.trim().isEmpty()) { %>
    <section class="card">
        <h2>② Enter Marks — Class <%= selectedClassNo %></h2>
        <p>Test: <strong><%= safeTestId %></strong>. Leave a mark blank if it is not available yet.</p>

        <form action="${pageContext.request.contextPath}/weeklytest" method="post">
            <input type="hidden" name="action" value="bulkSave">
            <input type="hidden" name="testId" value="<%= safeTestId %>">
            <input type="hidden" name="classNo" value="<%= selectedClassNo %>">

            <div class="table-wrapper">
                <table class="bulk-marks-table">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>Registration Number</th>
                        <th>Student Name</th>
                        <th>Marks / 100</th>
                        <th>Result</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int serial = 0;
                        if (students != null) {
                            for (Student s : students) {
                                if (s.getClassNo() != selectedClassNo) continue;
                                serial++;
                                String currentMarks = "";

                                if (tests != null) {
                                    for (WeeklyTest existing : tests) {
                                        if (testIdValue.equals(existing.getTestId())
                                                && s.getRegNo().equals(existing.getRegNo())) {
                                            currentMarks = String.valueOf(existing.getMarks());
                                            break;
                                        }
                                    }
                                }
                    %>
                    <tr>
                        <td><%= serial %></td>
                        <td>
                            <strong><%= s.getRegNo() %></strong>
                            <input type="hidden" name="regNos" value="<%= s.getRegNo() %>">
                        </td>
                        <td><%= s.getName() %></td>
                        <td>
                            <input type="number"
                                   name="marks_<%= s.getRegNo() %>"
                                   class="student-mark"
                                   min="0" max="100" step="1"
                                   value="<%= currentMarks %>"
                                   placeholder="0–100"
                                   aria-label="Marks for <%= s.getRegNo() %>">
                        </td>
                        <td class="result-cell">
                            <% if (!currentMarks.isEmpty()) {
                                int mark = Integer.parseInt(currentMarks); %>
                                <span class="<%= mark < 40 ? "fail-mark" : "pass-mark" %>">
                                    <%= mark < 40 ? "FAIL" : "PASS" %>
                                </span>
                            <% } else { %>
                                —
                            <% } %>
                        </td>
                    </tr>
                    <%      }
                        }
                        if (serial == 0) { %>
                    <tr><td colspan="5" style="text-align:center;padding:25px;">No students found in this class.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <% if (serial > 0) { %>
                <p><strong>Total students:</strong> <%= serial %></p>
                <button type="submit" class="btn btn-success"
                        onclick="return confirm('Save marks for Class <%= selectedClassNo %>?');">
                    Save All Marks
                </button>
            <% } %>
        </form>
    </section>
    <% } %>

    <section class="card">
        <h2>③ Saved Weekly-Test Records</h2>
        <p>Use the class filter to view the records for a particular class.</p>

        <form action="${pageContext.request.contextPath}/weeklytest" method="get"
              class="class-filter-form" style="margin:16px 0 20px;">
            <label for="filterClass">Filter by class</label>
            <select name="filterClass" id="filterClass" onchange="this.form.submit()">
                <option value="all" <%= "all".equals(filterClass) ? "selected" : "" %>>All Classes</option>
                <% for (int c = 7; c <= 10; c++) { %>
                    <option value="<%= c %>" <%= String.valueOf(c).equals(filterClass) ? "selected" : "" %>>
                        Class <%= c %>
                    </option>
                <% } %>
            </select>
            <noscript><button type="submit" class="btn">Apply Filter</button></noscript>
        </form>

        <div class="table-wrapper">
            <table>
                <thead>
                <tr>
                    <th>Test Name</th>
                    <th>Class</th>
                    <th>Student</th>
                    <th>Registration No.</th>
                    <th>Marks</th>
                    <th>Result</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <% if (tests != null && !tests.isEmpty()) {
                    for (WeeklyTest t : tests) { %>
                    <tr>
                        <td><strong><%= t.getTestId() %></strong></td>
                        <td><span class="badge">Class <%= t.getClassNo() %></span></td>
                        <td><%= t.getStudentName() %></td>
                        <td><%= t.getRegNo() %></td>
                        <td><strong><%= t.getMarks() %></strong> / 100</td>
                        <td>
                            <span class="<%= t.getMarks() < 40 ? "fail-mark" : "pass-mark" %>">
                                <%= t.getMarks() < 40 ? "FAIL" : "PASS" %>
                            </span>
                        </td>
                        <td>
                            <a class="btn btn-danger"
                               href="${pageContext.request.contextPath}/weeklytest?action=delete&id=<%= t.getId() %>"
                               onclick="return confirm('Delete this test record?');">Delete</a>
                        </td>
                    </tr>
                <%  }
                } else { %>
                    <tr><td colspan="7" style="text-align:center;padding:25px;">No weekly-test records found for this filter.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script>
document.querySelectorAll(".student-mark").forEach(function (input) {
    input.addEventListener("input", function () {
        const row = this.closest("tr");
        const cell = row.querySelector(".result-cell");
        const value = this.value;

        if (value === "") {
            cell.textContent = "—";
            return;
        }

        const marks = Number(value);
        if (marks < 0 || marks > 100) {
            cell.textContent = "Enter 0–100";
            cell.className = "result-cell fail-mark";
            return;
        }

        cell.className = "result-cell";
        const badge = document.createElement("span");
        badge.className = marks < 40 ? "fail-mark" : "pass-mark";
        badge.textContent = marks < 40 ? "FAIL" : "PASS";
        cell.replaceChildren(badge);
    });
});
</script>
</body>
</html>
