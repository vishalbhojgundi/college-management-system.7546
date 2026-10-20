
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

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin-ui.css">

    <style>
        .weekly-page {
            max-width: 1450px;
        }

        .weekly-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }

        .weekly-heading h2 {
            margin: 0 0 7px;
            color: var(--navy);
            font-size: 28px;
            font-weight: 800;
        }

        .weekly-heading p {
            margin: 0;
            color: var(--muted);
        }

        .weekly-section {
            margin-bottom: 25px;
            padding: 26px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 14px;
            box-shadow: var(--shadow);
        }

        .weekly-section h2 {
            margin-top: 0;
            margin-bottom: 10px;
            color: var(--navy);
            font-size: 22px;
        }

        .section-description {
            margin: 0 0 22px;
            color: var(--muted);
            line-height: 1.6;
        }

        .marks-toolbar {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr)
                                   minmax(180px, 1fr)
                                   auto;
            align-items: end;
            gap: 18px;
        }

        .marks-toolbar > div {
            min-width: 0;
        }

        .marks-toolbar label,
        .filter-label {
            display: block;
            margin-bottom: 9px;
            color: #263b55;
            font-size: 13px;
            font-weight: 750;
        }

        .marks-toolbar input,
        .marks-toolbar select,
        .weekly-filter select {
            box-sizing: border-box;
            width: 100%;
            min-height: 48px;
            padding: 12px 14px;
            border: 1px solid #d5deea;
            border-radius: 9px;
            background: #fff;
            color: #1e293b;
            font: inherit;
            outline: none;
            transition: border-color .2s ease,
                        box-shadow .2s ease;
        }

        .marks-toolbar input:focus,
        .marks-toolbar select:focus,
        .weekly-filter select:focus {
            border-color: #2868d7;
            box-shadow: 0 0 0 4px rgba(40, 104, 215, .11);
        }

        .marks-toolbar .btn {
            min-height: 48px;
            padding: 12px 22px;
            white-space: nowrap;
        }

        .weekly-section .btn {
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
        }

        .status-message {
            margin-bottom: 18px;
            padding: 14px 17px;
            border: 1px solid #d8e4f4;
            border-radius: 9px;
            background: #f4f8ff;
            color: #24466f;
        }

        .status-success {
            border-color: #b9e7cb;
            background: #effbf3;
            color: #16713a;
        }

        .status-error {
            border-color: #f1c4c4;
            background: #fff2f2;
            color: #a82121;
        }

        .weekly-filter {
            display: grid;
            grid-template-columns: minmax(170px, 0.7fr)
                                   minmax(220px, 1.2fr)
                                   auto;
            align-items: end;
            gap: 15px;
            margin: 18px 0 22px;
            padding: 19px;
            border: 1px solid #e0e8f3;
            border-radius: 10px;
            background: #f8faff;
        }

        .weekly-filter > div {
            min-width: 0;
        }

        .weekly-filter label {
            display: block;
            margin-bottom: 8px;
            color: #263b55;
            font-size: 13px;
            font-weight: 750;
        }

        .weekly-filter .btn {
            min-height: 45px;
            padding: 11px 20px;
            white-space: nowrap;
        }

        .filter-count {
            margin-bottom: 15px;
            color: var(--muted);
            font-size: 13px;
        }

        .filter-count strong {
            color: var(--navy);
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
        }

        .table-wrapper table {
            width: 100%;
            min-width: 850px;
            border-collapse: collapse;
            background: #fff;
        }

        .table-wrapper thead {
            background: #edf2f9;
        }

        .table-wrapper th {
            padding: 15px 16px;
            color: var(--navy);
            text-align: left;
            font-size: 13px;
            font-weight: 800;
            white-space: nowrap;
        }

        .table-wrapper td {
            padding: 14px 16px;
            border-top: 1px solid #e8edf5;
            color: #334155;
            font-size: 13px;
            vertical-align: middle;
        }

        .table-wrapper tbody tr:nth-child(even) {
            background: #f8faff;
        }

        .table-wrapper tbody tr:hover {
            background: #f0f5ff;
        }

        .bulk-marks-table {
            min-width: 700px !important;
        }

        .bulk-marks-table input[type="number"] {
            box-sizing: border-box;
            width: 105px;
            min-height: 39px;
            padding: 8px 10px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font: inherit;
        }

        .bulk-marks-table input[type="number"]:focus {
            border-color: #2868d7;
            outline: none;
            box-shadow: 0 0 0 3px rgba(40, 104, 215, .1);
        }

        .pass-mark,
        .fail-mark {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 11px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 850;
            white-space: nowrap;
        }

        .pass-mark {
            background: #e6f7ed;
            color: #168046;
        }

        .fail-mark {
            background: #fff0f0;
            color: #c62828;
        }

        .class-badge {
            display: inline-block;
            padding: 6px 11px;
            border-radius: 30px;
            background: #eaf1ff;
            color: #214f9b;
            font-size: 12px;
            font-weight: 800;
            white-space: nowrap;
        }

        .test-name-cell {
            min-width: 180px;
            color: var(--navy) !important;
            font-weight: 750;
        }

        .student-name-cell {
            min-width: 130px;
        }

        .empty-records {
            padding: 35px 20px !important;
            color: var(--muted) !important;
            text-align: center;
        }

        .empty-records strong {
            display: block;
            margin-bottom: 5px;
            color: var(--navy);
            font-size: 15px;
        }

        .bulk-actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 20px;
        }

        .bulk-actions p {
            margin: 0;
            color: var(--muted);
            font-size: 13px;
        }

        .bulk-actions .btn {
            min-height: 44px;
            padding: 11px 21px;
        }

        .delete-form {
            display: inline;
            margin: 0;
        }

        .delete-form .btn {
            min-height: 35px;
            padding: 8px 13px;
            border: 0;
            border-radius: 8px;
            background: #d83232;
            color: #fff;
            font-size: 12px;
        }

        .delete-form .btn:hover {
            background: #b91c1c;
        }

        .admin-only-label {
            color: var(--muted);
            font-size: 12px;
        }

        @media (max-width: 850px) {
            .marks-toolbar {
                grid-template-columns: 1fr 1fr;
            }

            .marks-toolbar > div:last-child {
                grid-column: 1 / -1;
            }

            .weekly-filter {
                grid-template-columns: 1fr 1fr;
            }

            .weekly-filter > div:last-child {
                grid-column: 1 / -1;
            }
        }

        @media (max-width: 600px) {
            .weekly-page {
                width: calc(100% - 24px);
            }

            .weekly-section {
                padding: 18px;
            }

            .weekly-heading h2 {
                font-size: 23px;
            }

            .marks-toolbar,
            .weekly-filter {
                grid-template-columns: 1fr;
            }

            .marks-toolbar > div:last-child,
            .weekly-filter > div:last-child {
                grid-column: auto;
            }

            .marks-toolbar .btn,
            .weekly-filter .btn {
                width: 100%;
            }

            .bulk-actions {
                align-items: stretch;
                flex-direction: column;
            }

            .bulk-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<%
    User user = (session != null)
            ? (User) session.getAttribute("user")
            : null;

    if (user == null
            || !("ADMIN".equals(user.getRole())
            || "STAFF".equals(user.getRole()))) {
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

    if (testIdValue == null) testIdValue = "";
    if (selectedClass == null) selectedClass = "";
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

    String safeTestId = testIdValue.replace("&", "&amp;")
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

<main class="container weekly-page">

    <section class="weekly-heading">
        <div>
            <h2>Weekly Test Management</h2>
            <p>Enter marks class-wise and review saved test records.</p>
        </div>

        <span class="badge badge-primary">
            PASS: 40–100 · FAIL: 0–39
        </span>
    </section>

    <!-- STATUS MESSAGES -->
    <% if ("saved".equals(status)) { %>
        <div class="status-message status-success">
            Marks saved successfully. Existing marks were updated; blank marks were skipped.
        </div>
    <% } else if ("saveFailed".equals(status)) { %>
        <div class="status-message status-error">
            Marks could not be saved. Check the server console and database connection.
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
    <section class="weekly-section">

        <h2>① Class-wise Marks Entry</h2>
        <p class="section-description">
            Enter a test name and select a class to load students for marks entry.
        </p>

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
                           value="<%= safeTestId %>"
                           placeholder="Example: Class7-First week Test"
                           required>
                </div>

                <div>
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
                    <button type="submit" class="btn">
                        Load Students
                    </button>
                </div>

            </div>
        </form>
    </section>

    <!-- SECTION 2: ENTER MARKS -->
    <% if (validSelectedClass && !testIdValue.trim().isEmpty()) { %>

        <section class="weekly-section">

            <h2>② Enter Marks — Class <%= selectedClassNo %></h2>

            <p class="section-description">
                Test: <strong><%= safeTestId %></strong>.
                Leave a mark blank if it is not available yet.
            </p>

            <form action="${pageContext.request.contextPath}/weeklytest"
                  method="post">

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

                                    if (s.getClassNo() != selectedClassNo) {
                                        continue;
                                    }

                                    serial++;
                                    String currentMarks = "";

                                    // Use ALL records to populate existing marks,
                                    // regardless of the saved-records filter.
                                    if (allTests != null) {
                                        for (WeeklyTest existing : allTests) {
                                            if (testIdValue.equals(existing.getTestId())
                                                    && s.getRegNo().equals(existing.getRegNo())
                                                    && existing.getClassNo() == selectedClassNo) {
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
                                           placeholder="0–100"
                                           aria-label="Marks for <%= s.getRegNo() %>">
                                </td>

                                <td class="result-cell">
                                    <% if (!currentMarks.isEmpty()) {
                                        int mark = Integer.parseInt(currentMarks); %>

                                        <span class="<%= mark < 40
                                                ? "fail-mark" : "pass-mark" %>">
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
                                    No students found in this class.
                                </td>
                            </tr>
                        <% } %>

                        </tbody>
                    </table>
                </div>

                <% if (serial > 0) { %>
                    <div class="bulk-actions">
                        <p>
                            <strong>Total students:</strong> <%= serial %>
                        </p>

                        <button type="submit"
                                class="btn btn-success"
                                onclick="return confirm('Save marks for Class <%= selectedClassNo %>?');">
                            Save All Marks
                        </button>
                    </div>
                <% } %>

            </form>
        </section>

    <% } %>

    <!-- SECTION 3: SAVED WEEKLY-TEST RECORDS -->
    <section class="weekly-section">

        <h2>③ Saved Weekly-Test Records</h2>

        <p class="section-description">
            Select a class first, then choose a test to display only matching student records.
        </p>

        <!-- CLASS AND TEST FILTERS -->
        <form action="${pageContext.request.contextPath}/weeklytest"
              method="get"
              class="weekly-filter"
              id="savedRecordsFilter">

            <div>
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

            <div>
                <label for="filterTestId">Filter by test</label>

                <select name="filterTestId" id="filterTestId">
                    <option value="all"
                        <%= "all".equals(filterTestId) ? "selected" : "" %>>
                        All Tests
                    </option>

                    <% if (availableTests != null) {
                        for (String availableTest : availableTests) {

                            String safeAvailableTest =
                                    availableTest.replace("&", "&amp;")
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
                <button type="submit" class="btn">
                    Apply Filters
                </button>
            </div>

        </form>

        <p class="filter-count">
            Displaying <strong><%= recordCount %></strong>
            matching record(s).
        </p>

        <!-- FILTERED RECORDS TABLE -->
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
                        <td class="test-name-cell">
                            <%= t.getTestId() %>
                        </td>

                        <td>
                            <span class="class-badge">
                                Class <%= t.getClassNo() %>
                            </span>
                        </td>

                        <td class="student-name-cell">
                            <%= t.getStudentName() %>
                        </td>

                        <td><%= t.getRegNo() %></td>

                        <td>
                            <strong><%= t.getMarks() %></strong> / 100
                        </td>

                        <td>
                            <span class="<%= t.getMarks() < 40
                                    ? "fail-mark" : "pass-mark" %>">
                                <%= t.getMarks() < 40 ? "FAIL" : "PASS" %>
                            </span>
                        </td>

                        <td>
                            <% if ("ADMIN".equals(user.getRole())) { %>

                                <form action="${pageContext.request.contextPath}/weeklytest"
                                      method="post"
                                      class="delete-form"
                                      onsubmit="return confirm('Are you sure you want to delete this test record?');">

                                    <input type="hidden"
                                           name="action"
                                           value="delete">

                                    <input type="hidden"
                                           name="id"
                                           value="<%= t.getId() %>">

                                    <input type="hidden"
                                           name="filterClass"
                                           value="<%= filterClass %>">

                                    <input type="hidden"
                                           name="filterTestId"
                                           value="<%= filterTestId %>">

                                    <button type="submit" class="btn btn-danger">
                                        Delete
                                    </button>
                                </form>

                            <% } else { %>
                                <span class="admin-only-label">Admin only</span>
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
    // Automatically apply saved-record filters when a selection changes.
    const filterForm = document.getElementById("savedRecordsFilter");
    const classFilter = document.getElementById("filterClass");
    const testFilter = document.getElementById("filterTestId");

    if (filterForm && classFilter && testFilter) {
        classFilter.addEventListener("change", function () {
            // Reset test selection when the class changes.
            testFilter.value = "all";
            filterForm.submit();
        });

        testFilter.addEventListener("change", function () {
            filterForm.submit();
        });
    }

    // Update PASS/FAIL preview when marks are typed.
    document.querySelectorAll(".student-mark").forEach(function (input) {
        input.addEventListener("input", function () {
            const row = this.closest("tr");
            const cell = row.querySelector(".result-cell");
            const value = this.value;

            if (value === "") {
                cell.textContent = "—";
                cell.className = "result-cell";
                return;
            }

            const marks = Number(value);

            if (marks < 0 || marks > 100) {
                cell.textContent = "Enter 0–100";
                cell.className = "result-cell fail-mark";
                return;
            }

            const badge = document.createElement("span");
            badge.className = marks < 40 ? "fail-mark" : "pass-mark";
            badge.textContent = marks < 40 ? "FAIL" : "PASS";

            cell.className = "result-cell";
            cell.replaceChildren(badge);
        });
    });
})();
</script>

</body>
</html>
