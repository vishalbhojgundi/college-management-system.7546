
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.TreeSet" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weekly Tests | BTVP High School</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .bulk-marks-table input[type="number"] {
            width: 110px;
            min-width: 80px;
            margin: 0;
        }

        .bulk-marks-table td,
        .bulk-marks-table th {
            vertical-align: middle;
        }

        .marks-toolbar {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: end;
        }

        .marks-toolbar > div {
            flex: 1;
            min-width: 220px;
        }

        .marks-toolbar input,
        .marks-toolbar select {
            width: 100%;
        }

        .status-message {
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 18px;
            background: #e0f2fe;
            color: #075985;
        }

        .status-success {
            background: #dcfce7;
            color: #166534;
        }

        .status-error {
            background: #fee2e2;
            color: #991b1b;
        }

        .pass-mark {
            color: #15803d;
            font-weight: 600;
        }

        .fail-mark {
            color: #dc2626;
            font-weight: 600;
        }
    </style>
</head>

<body>

<%
    User user = (session != null)
            ? (User) session.getAttribute("user")
            : null;

    if (user == null ||
            !("ADMIN".equals(user.getRole())
                    || "STAFF".equals(user.getRole()))) {

        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<WeeklyTest> tests =
            (List<WeeklyTest>) request.getAttribute("tests");

    List<Student> students =
            (List<Student>) request.getAttribute("students");

    String selectedClass =
            (String) request.getAttribute("selectedClass");

    String testIdValue =
            (String) request.getAttribute("testId");

    if (testIdValue == null) {
        testIdValue = "";
    }

    Set<Integer> classNumbers = new TreeSet<>();

    if (students != null) {
        for (Student s : students) {
            int classNo = s.getClassNo();

            if (classNo >= 7 && classNo <= 10) {
                classNumbers.add(classNo);
            }
        }
    }

    String status = request.getParameter("status");
%>

<header>
    <h1>🎓 BTVP High School</h1>

    <nav>
        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<div class="container">

    <div class="page-header">
        <h2>📝 Weekly Test Management</h2>
        <p>Enter marks for an entire class in one table.</p>
    </div>

    <% if ("saved".equals(status)) { %>
        <div class="status-message status-success">
            Marks saved successfully. Existing marks for this test were updated.
            Blank marks were skipped.
        </div>
    <% } else if ("saveFailed".equals(status)) { %>
        <div class="status-message status-error">
            Marks could not be saved. Check the server console and database connection.
        </div>
    <% } else if ("invalidClass".equals(status)
            || "invalidInput".equals(status)
            || "invalidMarks".equals(status)) { %>
        <div class="status-message status-error">
            Invalid input. Choose a class from 7 to 10 and enter marks between 0 and 100.
        </div>
    <% } else if ("noStudents".equals(status)
            || "noMarks".equals(status)) { %>
        <div class="status-message">
            Select a class and enter at least one student's marks before saving.
        </div>
    <% } %>

    <!-- Select the test and class -->
    <div class="card">
        <h2>➕ Class-wise Marks Entry</h2>

        <form action="${pageContext.request.contextPath}/weeklytest"
              method="get"
              id="classSelectionForm">

            <div class="marks-toolbar">

                <div>
                    <label for="testId">Test Name / Test ID</label>
                    <input type="text"
                           id="testId"
                           name="testId"
                           maxlength="20"
                           placeholder="Example: Class7-First Week Test"
                           value="<%= testIdValue.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                           required>
                </div>

                <div>
                    <label for="classNo">Select Class</label>
                    <select id="classNo"
                            name="classNo"
                            required>

                        <option value="">Select Class</option>

                        <% for (Integer classNo : classNumbers) { %>
                            <option value="<%= classNo %>"
                                <%= String.valueOf(classNo).equals(selectedClass)
                                        ? "selected" : "" %>>
                                Class <%= classNo %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div>
                    <button type="submit" class="btn">
                        Load Students
                    </button>
                </div>

            </div>
        </form>
    </div>

    <!-- Bulk marks form -->
    <%
        boolean validSelectedClass = false;
        int selectedClassNo = 0;

        try {
            selectedClassNo = Integer.parseInt(selectedClass);
            validSelectedClass =
                    selectedClassNo >= 7 && selectedClassNo <= 10;
        } catch (Exception ignored) {
            validSelectedClass = false;
        }

        if (validSelectedClass
                && testIdValue != null
                && !testIdValue.trim().isEmpty()) {
    %>

    <div class="card">
        <h2>📋 Class <%= selectedClassNo %> — Enter Student Marks</h2>

        <p>
            Test: <strong><%= testIdValue.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %></strong>
        </p>

        <p>
            Enter marks for each student. Leave a field blank if marks
            are not available yet. Only filled fields will be saved.
        </p>

        <form action="${pageContext.request.contextPath}/weeklytest"
              method="post">

            <input type="hidden" name="action" value="bulkSave">

            <input type="hidden"
                   name="testId"
                   value="<%= testIdValue.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>">

            <input type="hidden"
                   name="classNo"
                   value="<%= selectedClassNo %>">

            <div style="overflow-x:auto;">
                <table class="bulk-marks-table">
                    <thead>
                    <tr>
                        <th>Sl. No.</th>
                        <th>Registration Number</th>
                        <th>Student Name</th>
                        <th>Marks (0–100)</th>
                        <th>Result</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        int serial = 0;

                        if (students != null) {
                            for (Student s : students) {

                                if (s.getClassNo() != selectedClassNo) {
                                    continue;
                                }

                                serial++;

                                String currentMarks = "";

                                if (tests != null) {
                                    for (WeeklyTest existing : tests) {
                                        if (testIdValue.equals(existing.getTestId())
                                                && s.getRegNo().equals(existing.getRegNo())) {
                                            currentMarks =
                                                    String.valueOf(existing.getMarks());
                                            break;
                                        }
                                    }
                                }
                    %>

                    <tr>
                        <td><%= serial %></td>
                        <td>
                            <strong><%= s.getRegNo() %></strong>
                            <input type="hidden"
                                   name="regNos"
                                   value="<%= s.getRegNo() %>">
                        </td>
                        <td><%= s.getName() %></td>
                        <td>
                            <input type="number"
                                   name="marks_<%= s.getRegNo() %>"
                                   class="student-mark"
                                   min="0"
                                   max="100"
                                   step="1"
                                   value="<%= currentMarks %>"
                                   placeholder="Enter marks"
                                   aria-label="Marks for <%= s.getRegNo() %>">
                        </td>
                        <td class="result-cell">
                            <% if (!currentMarks.isEmpty()) {
                                   int current = Integer.parseInt(currentMarks);
                            %>
                                <span class="<%= current < 40 ? "fail-mark" : "pass-mark" %>">
                                    <%= current < 40 ? "FAIL" : "PASS" %>
                                </span>
                            <% } else { %>
                                —
                            <% } %>
                        </td>
                    </tr>

                    <%
                            }
                        }
                    %>

                    <% if (serial == 0) { %>
                        <tr>
                            <td colspan="5" style="text-align:center;">
                                No students found in this class.
                            </td>
                        </tr>
                    <% } %>

                    </tbody>
                </table>
            </div>

            <% if (serial > 0) { %>
                <p><strong>Total students:</strong> <%= serial %></p>

                <button type="submit"
                        class="btn"
                        onclick="return confirm('Save marks for this class?');">
                    💾 Save All Marks
                </button>
            <% } %>
        </form>
    </div>

    <% } %>

    <!-- Existing test records -->
    <div class="card">
        <h2>📚 All Weekly-Test Records</h2>

        <div style="overflow-x:auto;">
            <table>
                <thead>
                <tr>
                    <th>Test ID</th>
                    <th>Class</th>
                    <th>Student</th>
                    <th>Reg No</th>
                    <th>Marks</th>
                    <th>Result</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>
                <%
                    if (tests != null && !tests.isEmpty()) {
                        for (WeeklyTest t : tests) {
                %>
                    <tr>
                        <td><%= t.getTestId() %></td>
                        <td>Class <%= t.getClassNo() %></td>
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
                               onclick="return confirm('Delete this test record?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" style="text-align:center;">
                            No weekly test records found.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
    // Show PASS/FAIL immediately when marks are entered.
    document.querySelectorAll(".student-mark").forEach(function (input) {
        input.addEventListener("input", function () {
            const row = this.closest("tr");
            const resultCell = row.querySelector(".result-cell");

            if (this.value === "") {
                resultCell.textContent = "—";
                return;
            }

            const marks = Number(this.value);

            if (marks < 0 || marks > 100) {
                resultCell.textContent = "Enter 0–100";
                resultCell.className = "result-cell fail-mark";
                return;
            }

            resultCell.className = "result-cell";
            const span = document.createElement("span");
            span.className = marks < 40 ? "fail-mark" : "pass-mark";
            span.textContent = marks < 40 ? "FAIL" : "PASS";

            resultCell.replaceChildren(span);
        });
    });
</script>

</body>
</html>
