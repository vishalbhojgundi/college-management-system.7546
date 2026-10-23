
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.TreeSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Weekly Tests | BTVP HIGH SCHOOL</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-ui.css">

    <style>
        :root {
            --weekly-navy: #17365d;
            --weekly-blue: #2868d7;
            --weekly-blue-hover: #1d54b5;
            --weekly-page: #f2f5fb;
            --weekly-border: #dfe7f2;
            --weekly-muted: #70829b;
        }

        body {
            background: var(--weekly-page);
        }

        .weekly-page {
            width: min(1500px, calc(100% - 60px));
            margin: 28px auto 45px;
        }

        .weekly-page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
        }

        .weekly-page-header h2 {
            margin: 0 0 5px;
            color: var(--weekly-navy);
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -.45px;
        }

        .weekly-page-header p {
            margin: 0;
            color: var(--weekly-muted);
            font-size: 14px;
        }

        .grading-info {
            padding: 9px 13px;
            border: 1px solid #d6e5ff;
            border-radius: 9px;
            background: #edf4ff;
            color: #28559a;
            font-size: 12px;
            font-weight: 750;
        }

        .weekly-card {
            margin-bottom: 24px;
            padding: 29px 32px;
            border: 1px solid var(--weekly-border);
            border-radius: 17px;
            background: #fff;
            box-shadow: 0 7px 24px rgba(23, 54, 93, .045);
        }

        .weekly-card-title {
            margin: 0 0 9px;
            color: var(--weekly-navy);
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -.3px;
        }

        .weekly-card-description {
            margin: 0 0 23px;
            color: var(--weekly-muted);
            font-size: 14px;
            line-height: 1.65;
        }

        /* Class-wise marks entry */

        .entry-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr)
                                   minmax(210px, 1fr)
                                   195px;
            align-items: end;
            gap: 21px;
        }

        .field label,
        .filter-field label {
            display: block;
            margin-bottom: 10px;
            color: #263c59;
            font-size: 13px;
            font-weight: 750;
        }

        .field input,
        .field select,
        .filter-field select {
            box-sizing: border-box;
            display: block;
            width: 100%;
            min-height: 57px;
            padding: 13px 15px;
            border: 1px solid #d1ddeb;
            border-radius: 10px;
            outline: none;
            background: #fff;
            color: #24354d;
            font-family: inherit;
            font-size: 15px;
            transition: border-color .2s ease, box-shadow .2s ease;
        }

        .field input::placeholder {
            color: #8998ac;
        }

        .field input:focus,
        .field select:focus,
        .filter-field select:focus {
            border-color: var(--weekly-blue);
            box-shadow: 0 0 0 4px rgba(40, 104, 215, .10);
        }

        .weekly-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
            min-height: 48px;
            padding: 12px 21px;
            border: 1px solid transparent;
            border-radius: 9px;
            background: var(--weekly-blue);
            color: #fff;
            font-family: inherit;
            font-size: 14px;
            font-weight: 750;
            text-decoration: none;
            cursor: pointer;
            transition: background .2s ease, transform .2s ease;
        }

        .weekly-btn:hover {
            background: var(--weekly-blue-hover);
            color: #fff;
        }

        .entry-grid .weekly-btn {
            width: 100%;
            min-height: 57px;
        }

        /* Status messages */

        .status-message {
            margin-bottom: 20px;
            padding: 14px 17px;
            border: 1px solid #d7e4f5;
            border-radius: 10px;
            background: #f1f6ff;
            color: #244a7b;
            font-size: 14px;
        }

        .status-success {
            border-color: #b8e4c8;
            background: #effaf3;
            color: #177341;
        }

        .status-error {
            border-color: #f0c6c6;
            background: #fff2f2;
            color: #ae2929;
        }

        /* Saved-record filters */

        .weekly-filter {
            display: grid;
            grid-template-columns: minmax(200px, .75fr)
                                   minmax(260px, 1.25fr)
                                   154px;
            align-items: end;
            gap: 19px;
            margin: 0 0 27px;
            padding: 25px;
            border: 1px solid #e0e9f6;
            border-radius: 12px;
            background: #f7f9fe;
        }

        .filter-field {
            min-width: 0;
        }

        .filter-field select {
            min-height: 62px;
            font-size: 15px;
        }

        .weekly-filter .weekly-btn {
            width: 100%;
            min-height: 59px;
            padding: 12px 15px;
        }

        .record-count {
            margin: 0 0 19px;
            color: var(--weekly-muted);
            font-size: 14px;
        }

        .record-count strong {
            color: var(--weekly-navy);
            font-weight: 800;
        }

        /* Tables */

        .table-scroll {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #e1e8f2;
            border-radius: 11px;
        }

        .weekly-table {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
            background: #fff;
        }

        .weekly-table thead {
            background: #edf2f9;
        }

        .weekly-table th {
            padding: 18px 16px;
            color: #183759;
            text-align: left;
            font-size: 14px;
            font-weight: 800;
            white-space: nowrap;
        }

        .weekly-table td {
            padding: 16px;
            border-top: 1px solid #e9eef6;
            color: #34445b;
            font-size: 14px;
            vertical-align: middle;
        }

        .weekly-table tbody tr:nth-child(even) {
            background: #f8faff;
        }

        .weekly-table tbody tr:hover {
            background: #f0f5ff;
        }

        .test-name {
            min-width: 200px;
            color: #17365d !important;
            font-weight: 750;
        }

        .student-name {
            min-width: 145px;
        }

        .class-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 13px;
            border-radius: 30px;
            background: #e8f0ff;
            color: #24529b;
            font-size: 12px;
            font-weight: 800;
            white-space: nowrap;
        }

        .result-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 58px;
            padding: 7px 11px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 850;
        }

        .result-pass {
            background: #e6f7ed;
            color: #148044;
        }

        .result-fail {
            background: #fff0f0;
            color: #c62828;
        }

        .delete-form {
            display: inline;
            margin: 0;
        }

        .delete-btn {
            min-height: 40px;
            padding: 9px 15px;
            border: 0;
            border-radius: 9px;
            background: #d83232;
            color: #fff;
            font-family: inherit;
            font-size: 13px;
            font-weight: 750;
            cursor: pointer;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .empty-records {
            padding: 45px 20px !important;
            text-align: center;
            color: var(--weekly-muted) !important;
        }

        .empty-records strong {
            display: block;
            margin-bottom: 6px;
            color: var(--weekly-navy);
            font-size: 16px;
        }

        /* Bulk marks entry */

        .bulk-table {
            min-width: 740px;
        }

        .bulk-table input[type="number"] {
            box-sizing: border-box;
            width: 110px;
            min-height: 40px;
            padding: 8px 11px;
            border: 1px solid #cbd7e6;
            border-radius: 8px;
            outline: none;
            font: inherit;
        }

        .bulk-table input[type="number"]:focus {
            border-color: var(--weekly-blue);
            box-shadow: 0 0 0 3px rgba(40, 104, 215, .1);
        }

        .bulk-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 22px;
        }

        .bulk-actions p {
            margin: 0;
            color: var(--weekly-muted);
            font-size: 13px;
        }

        .save-btn {
            background: #16834b;
        }

        .save-btn:hover {
            background: #116b3d;
        }

        .admin-only {
            color: var(--weekly-muted);
            font-size: 12px;
        }

        @media (max-width: 1000px) {
            .entry-grid {
                grid-template-columns: 1fr 1fr;
            }

            .entry-grid > div:last-child {
                grid-column: 1 / -1;
            }

            .weekly-filter {
                grid-template-columns: 1fr 1fr;
            }

            .weekly-filter > div:last-child {
                grid-column: 1 / -1;
            }
        }

        @media (max-width: 650px) {
            .weekly-page {
                width: calc(100% - 24px);
                margin-top: 18px;
            }

            .weekly-card {
                padding: 20px;
                border-radius: 12px;
            }

            .weekly-card-title {
                font-size: 20px;
            }

            .weekly-page-header h2 {
                font-size: 23px;
            }

            .entry-grid,
            .weekly-filter {
                grid-template-columns: minmax(0, 1fr);
                gap: 17px;
            }

            .entry-grid > div:last-child,
            .weekly-filter > div:last-child {
                grid-column: auto;
            }

            .entry-grid .weekly-btn,
            .weekly-filter .weekly-btn {
                width: 100%;
            }

            .bulk-actions {
                align-items: stretch;
                flex-direction: column;
            }

            .bulk-actions .weekly-btn {
                width: 100%;
            }
        }

        @media print {
            header,
            .weekly-page-header,
            .entry-card,
            .weekly-filter,
            .delete-form,
            .bulk-actions {
                display: none !important;
            }

            body {
                background: #fff;
            }

            .weekly-card {
                border: 0;
                box-shadow: none;
            }
        }
    </style>
</head>

<body>

<%
    User user = (session != null)
            ? (User) session.getAttribute("user")
            : null;

    if (user == null ||
            !("ADMIN".equals(user.getRole()) ||
              "STAFF".equals(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<WeeklyTest> tests =
            (List<WeeklyTest>) request.getAttribute("tests");

    List<WeeklyTest> allTests =
            (List<WeeklyTest>) request.getAttribute("allTests");

    List<Student> students =
            (List<Student>) request.getAttribute("students");

    Set<String> availableTests =
            (Set<String>) request.getAttribute("availableTests");

    String selectedClass =
            (String) request.getAttribute("selectedClass");

    String testIdValue =
            (String) request.getAttribute("testId");

    String filterClass =
            (String) request.getAttribute("filterClass");

    String filterTestId =
            (String) request.getAttribute("filterTestId");

    String status = request.getParameter("status");

    if (selectedClass == null) selectedClass = "";
    if (testIdValue == null) testIdValue = "";
    if (filterClass == null || filterClass.trim().isEmpty()) {
        filterClass = "all";
    }
    if (filterTestId == null || filterTestId.trim().isEmpty()) {
        filterTestId = "all";
    }

    if (availableTests == null) {
        availableTests = new TreeSet<>();
        if (allTests != null) {
            for (WeeklyTest t : allTests) {
                if ("all".equals(filterClass)
                        || String.valueOf(t.getClassNo()).equals(filterClass)) {
                    if (t.getTestId() != null) {
                        availableTests.add(t.getTestId());
                    }
                }
            }
        }
    }

    int selectedClassNo = 0;
    boolean validSelectedClass = false;

    try {
        selectedClassNo = Integer.parseInt(selectedClass);
        validSelectedClass =
                selectedClassNo >= 7 && selectedClassNo <= 10;
    } catch (Exception ignored) {
        validSelectedClass = false;
    }

    String safeTestId = testIdValue
            .replace("&", "&amp;")
            .replace("\"", "&quot;")
            .replace("<", "&lt;")
            .replace(">", "&gt;");

    int recordCount = tests == null ? 0 : tests.size();
%>

<header>
    <h1>🎓 BTVP HIGH SCHOOL</h1>

    <nav>
        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/student">Students</a>
        <a href="${pageContext.request.contextPath}/course">Courses</a>

        <% if ("ADMIN".equals(user.getRole())) { %>
            <a href="${pageContext.request.contextPath}/staff-management">Staff</a>
        <% } %>

        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </nav>
</header>

<main class="weekly-page">

    <!-- PAGE HEADING -->
    <section class="weekly-page-header">
        <div>
            <h2>Weekly Test Management</h2>
            <p>Manage class-wise marks and review saved test records.</p>
        </div>

        <span class="grading-info">
            PASS: 40–100 &nbsp;·&nbsp; FAIL: 0–39
        </span>
    </section>

    <!-- STATUS MESSAGES -->
    <% if ("saved".equals(status)) { %>
        <div class="status-message status-success">
            Marks saved successfully. Existing marks were updated and blank marks were skipped.
        </div>
    <% } else if ("saveFailed".equals(status)) { %>
        <div class="status-message status-error">
            Marks could not be saved. Please check the server console and database connection.
        </div>
    <% } else if ("invalidClass".equals(status)
            || "invalidInput".equals(status)
            || "invalidMarks".equals(status)) { %>
        <div class="status-message status-error">
            Invalid input. Select a class from 7 to 10 and enter marks between 0 and 100.
        </div>
    <% } else if ("noStudents".equals(status) || "noMarks".equals(status)) { %>
        <div class="status-message">
            Select a class and enter at least one student's marks before saving.
        </div>
    <% } %>

    <!-- SECTION 1: CLASS-WISE MARKS ENTRY -->
    <section class="weekly-card entry-card">

        <h2 class="weekly-card-title">① Class-wise Marks Entry</h2>

        <p class="weekly-card-description">
            Enter a test name and select a class to load students for marks entry.
        </p>

        <form action="${pageContext.request.contextPath}/weeklytest"
              method="get">

            <div class="entry-grid">

                <div class="field">
                    <label for="testId">Test Name / Test ID</label>
                    <input type="text"
                           id="testId"
                           name="testId"
                           maxlength="20"
                           value="<%= safeTestId %>"
                           placeholder="Example: Class7-First week Test"
                           required>
                </div>

                <div class="field">
                    <label for="classNo">Select Class</label>
                    <select id="classNo" name="classNo" required>
                        <option value="">Select class</option>

                        <% for (int c = 7; c <= 10; c++) { %>
                            <option value="<%= c %>"
                                <%= String.valueOf(c).equals(selectedClass)
                                        ? "selected" : "" %>>
                                Class <%= c %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div>
                    <button type="submit" class="weekly-btn">
                        Load Students
                    </button>
                </div>

            </div>
        </form>
    </section>

    <!-- SECTION 2: BULK MARKS ENTRY -->
    <% if (validSelectedClass && !testIdValue.trim().isEmpty()) { %>

        <section class="weekly-card">

            <h2 class="weekly-card-title">
                ② Enter Marks — Class <%= selectedClassNo %>
            </h2>

            <p class="weekly-card-description">
                Test: <strong><%= safeTestId %></strong>.
                Leave a mark blank if it is not available yet.
            </p>

            <form action="${pageContext.request.contextPath}/weeklytest"
                  method="post">

                <input type="hidden" name="action" value="bulkSave">
                <input type="hidden" name="testId" value="<%= safeTestId %>">
                <input type="hidden" name="classNo" value="<%= selectedClassNo %>">

                <div class="table-scroll">
                    <table class="weekly-table bulk-table">
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
                                    if (s.getClassNo() != selectedClassNo) {
                                        continue;
                                    }

                                    serial++;
                                    String currentMarks = "";

                                    if (allTests != null) {
                                        for (WeeklyTest existing : allTests) {
                                            if (testIdValue.equals(existing.getTestId())
                                                    && s.getRegNo().equals(existing.getRegNo())
                                                    && existing.getClassNo() == selectedClassNo) {
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
                                           placeholder="0–100"
                                           aria-label="Marks for <%= s.getRegNo() %>">
                                </td>

                                <td class="result-cell">
                                    <% if (!currentMarks.isEmpty()) {
                                        int mark = Integer.parseInt(currentMarks); %>
                                        <span class="result-pill <%= mark < 40
                                                ? "result-fail" : "result-pass" %>">
                                            <%= mark < 40 ? "FAIL" : "PASS" %>
                                        </span>
                                    <% } else { %>
                                        —
                                    <% } %>
                                </td>
                            </tr>
                        <%
                                }
                            }

                            if (serial == 0) {
                        %>
                            <tr>
                                <td colspan="5" class="empty-records">
                                    <strong>No students found</strong>
                                    There are no students in this class.
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <% if (serial > 0) { %>
                    <div class="bulk-actions">
                        <p><strong>Total students:</strong> <%= serial %></p>

                        <button type="submit"
                                class="weekly-btn save-btn"
                                onclick="return confirm('Save marks for Class <%= selectedClassNo %>?');">
                            Save All Marks
                        </button>
                    </div>
                <% } %>

            </form>
        </section>
    <% } %>

    <!-- SECTION 3: SAVED WEEKLY-TEST RECORDS -->
    <section class="weekly-card">

        <h2 class="weekly-card-title">③ Saved Weekly-Test Records</h2>

        <p class="weekly-card-description">
            Select a class first, then choose a test to display only matching student records.
        </p>

        <!-- CLASS AND TEST FILTERS -->
        <form action="${pageContext.request.contextPath}/weeklytest"
              method="get"
              class="weekly-filter"
              id="savedRecordsFilter">

            <div class="filter-field">
                <label for="filterClass">Filter by class</label>

                <select name="filterClass" id="filterClass">
                    <option value="all"
                        <%= "all".equals(filterClass) ? "selected" : "" %>>
                        All Classes
                    </option>

                    <% for (int c = 7; c <= 10; c++) { %>
                        <option value="<%= c %>"
                            <%= String.valueOf(c).equals(filterClass)
                                    ? "selected" : "" %>>
                            Class <%= c %>
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="filter-field">
                <label for="filterTestId">Filter by test</label>

                <select name="filterTestId" id="filterTestId">
                    <option value="all"
                        <%= "all".equals(filterTestId) ? "selected" : "" %>>
                        All Tests
                    </option>

                    <% if (availableTests != null) {
                        for (String availableTest : availableTests) {
                            String safeAvailableTest = availableTest
                                    .replace("&", "&amp;")
                                    .replace("\"", "&quot;")
                                    .replace("<", "&lt;")
                                    .replace(">", "&gt;");
                    %>
                        <option value="<%= safeAvailableTest %>"
                            <%= availableTest.equals(filterTestId)
                                    ? "selected" : "" %>>
                            <%= safeAvailableTest %>
                        </option>
                    <%  }
                    } %>
                </select>
            </div>

            <div>
                <button type="submit" class="weekly-btn">
                    Apply Filters
                </button>
            </div>
        </form>

        <p class="record-count">
            Displaying <strong><%= recordCount %></strong> matching record(s).
        </p>

        <!-- SAVED RECORDS TABLE -->
        <div class="table-scroll">
            <table class="weekly-table">
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
                        <td class="test-name">
                            <%= t.getTestId() %>
                        </td>

                        <td>
                            <span class="class-pill">
                                Class <%= t.getClassNo() %>
                            </span>
                        </td>

                        <td class="student-name">
                            <%= t.getStudentName() %>
                        </td>

                        <td><%= t.getRegNo() %></td>

                        <td>
                            <strong><%= t.getMarks() %></strong> / 100
                        </td>

                        <td>
                            <span class="result-pill <%= t.getMarks() < 40
                                    ? "result-fail" : "result-pass" %>">
                                <%= t.getMarks() < 40 ? "FAIL" : "PASS" %>
                            </span>
                        </td>

                        <td>
                            <% if ("ADMIN".equals(user.getRole())) { %>
                                <form action="${pageContext.request.contextPath}/weeklytest"
                                      method="post"
                                      class="delete-form"
                                      onsubmit="return confirm('Are you sure you want to delete this test record?');">

                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= t.getId() %>">
                                    <input type="hidden" name="filterClass" value="<%= filterClass %>">
                                    <input type="hidden" name="filterTestId" value="<%= filterTestId %>">

                                    <button type="submit" class="delete-btn">
                                        Delete
                                    </button>
                                </form>
                            <% } else { %>
                                <span class="admin-only">Admin only</span>
                            <% } %>
                        </td>
                    </tr>
                <%  }
                } else { %>
                    <tr>
                        <td colspan="7" class="empty-records">
                            <strong>No weekly-test records found</strong>
                            Try selecting another class or test.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

    </section>
</main>

<script>
(function () {
    const filterForm = document.getElementById("savedRecordsFilter");
    const classFilter = document.getElementById("filterClass");
    const testFilter = document.getElementById("filterTestId");

    if (filterForm && classFilter && testFilter) {
        classFilter.addEventListener("change", function () {
            // Reset the selected test when the class changes.
            testFilter.value = "all";
            filterForm.submit();
        });

        testFilter.addEventListener("change", function () {
            filterForm.submit();
        });
    }

    // Update the PASS/FAIL preview while entering marks.
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
                return;
            }

            const badge = document.createElement("span");
            badge.className = "result-pill " +
                    (marks < 40 ? "result-fail" : "result-pass");
            badge.textContent = marks < 40 ? "FAIL" : "PASS";

            cell.replaceChildren(badge);
        });
    });
})();
</script>

</body>
</html>
