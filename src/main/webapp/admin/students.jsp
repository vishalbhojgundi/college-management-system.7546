
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.Course" %>
<%@ page import="com.college.model.User" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Student Management | BTVP HIGH SCHOOL</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin-ui.css">

    <script src="${pageContext.request.contextPath}/js/script.js" defer></script>

    <style>
        .students-page {
            max-width: 1320px;
        }

        .student-page-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }

        .student-page-heading h2 {
            margin: 0 0 6px;
            color: var(--navy);
            font-size: 28px;
            font-weight: 750;
        }

        .student-page-heading p {
            margin: 0;
            color: var(--muted);
        }

        .role-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 13px;
            border-radius: 30px;
            background: #eaf1ff;
            color: #214f9b;
            font-size: 12px;
            font-weight: 800;
        }

        .student-summary-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 24px;
        }

        .student-summary-card {
            display: flex;
            align-items: center;
            gap: 15px;
            min-width: 0;
            padding: 20px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        .summary-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #eaf1ff;
            font-size: 23px;
        }

        .summary-label {
            margin: 0 0 3px;
            color: var(--muted);
            font-size: 12px;
            font-weight: 600;
        }

        .summary-value {
            margin: 0;
            color: var(--navy);
            font-size: 25px;
            font-weight: 800;
            line-height: 1.3;
        }

        .student-panel {
            min-width: 0;
            margin-bottom: 24px;
            padding: 24px;
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            box-shadow: var(--shadow);
        }

        .student-panel-heading {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 20px;
        }

        .student-panel-heading h3 {
            margin: 0 0 5px;
            color: var(--navy);
            font-size: 19px;
        }

        .student-panel-heading p {
            margin: 0;
            color: var(--muted);
            font-size: 13px;
        }

        .student-form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px 22px;
            margin-bottom: 22px;
        }

        .student-form-grid > div {
            min-width: 0;
        }

        .student-form-grid label {
            display: block;
            margin-bottom: 7px;
            color: #34445a;
            font-size: 13px;
            font-weight: 700;
        }

        .student-form-grid input,
        .student-form-grid select {
            box-sizing: border-box;
            width: 100%;
            min-height: 43px;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            background: #fff;
            color: var(--text);
            font: inherit;
        }

        .student-form-grid input:focus,
        .student-form-grid select:focus {
            outline: none;
            border-color: var(--blue);
            box-shadow: 0 0 0 3px rgba(40, 104, 215, .12);
        }

        .student-form-grid input[readonly] {
            background: #f1f4f8;
            color: var(--muted);
            cursor: not-allowed;
        }

        .student-form-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 10px;
        }

        .records-panel {
            padding: 0;
            overflow: hidden;
        }

        .records-panel-heading {
            padding: 24px 24px 16px;
        }

        .records-panel-heading .student-panel-heading {
            margin-bottom: 0;
        }

        .records-count {
            display: inline-flex;
            align-items: center;
            padding: 7px 11px;
            border-radius: 7px;
            background: #edf2f9;
            color: var(--navy);
            font-size: 12px;
            font-weight: 750;
            white-space: nowrap;
        }

        .student-filter-panel {
            margin: 0 24px 20px;
            padding: 17px;
            border: 1px solid var(--border);
            border-radius: 9px;
            background: #f8faff;
        }

        .student-filter-form {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .student-filter-form label {
            margin: 0;
            color: var(--navy);
            font-weight: 750;
        }

        .student-filter-form select {
            box-sizing: border-box;
            width: min(280px, 100%);
            min-height: 40px;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            background: #fff;
            color: var(--text);
            font: inherit;
        }

        .filter-hint {
            margin-left: auto;
            color: var(--muted);
            font-size: 12px;
        }

        .student-table-wrapper {
            width: 100%;
            overflow-x: auto;
            border-top: 1px solid var(--border);
        }

        .student-table {
            width: 100%;
            min-width: 1050px;
            border-collapse: collapse;
            background: #fff;
            font-size: 13px;
        }

        .student-table thead {
            background: #edf2f9;
        }

        .student-table th {
            padding: 14px 13px;
            color: var(--navy);
            text-align: left;
            white-space: nowrap;
            font-weight: 750;
        }

        .student-table td {
            padding: 13px;
            border-top: 1px solid #eaf0f6;
            vertical-align: middle;
        }

        .student-table tbody tr:hover {
            background: #f8faff;
        }

        .student-regno {
            color: var(--navy);
            font-weight: 750;
            white-space: nowrap;
        }

        .student-name {
            color: #243247;
            font-weight: 650;
        }

        .class-badge {
            display: inline-block;
            padding: 5px 9px;
            border-radius: 20px;
            background: #eaf1ff;
            color: #214f9b;
            font-size: 11px;
            font-weight: 800;
            white-space: nowrap;
        }

        .student-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 6px;
        }

        .student-actions .btn {
            min-height: 32px;
            padding: 6px 10px;
            font-size: 12px;
            white-space: nowrap;
            cursor: pointer;
        }

        .student-actions form {
            display: inline;
            margin: 0;
        }

        .empty-students {
            padding: 42px 20px !important;
            text-align: center;
            color: var(--muted);
        }

        .empty-students strong {
            display: block;
            margin-bottom: 6px;
            color: var(--navy);
            font-size: 16px;
        }

        .records-footer {
            padding: 14px 24px;
            border-top: 1px solid var(--border);
            background: #fafcff;
            color: var(--muted);
            font-size: 12px;
        }

        @media (max-width: 850px) {
            .student-summary-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 600px) {
            .students-page {
                width: calc(100% - 24px);
                margin-top: 18px;
            }

            .student-page-heading h2 {
                font-size: 23px;
            }

            .student-summary-grid,
            .student-form-grid {
                grid-template-columns: 1fr;
            }

            .student-panel {
                padding: 17px;
            }

            .records-panel {
                padding: 0;
            }

            .records-panel-heading {
                padding: 18px 17px 14px;
            }

            .student-filter-panel {
                margin: 0 17px 16px;
                padding: 14px;
            }

            .student-filter-form {
                align-items: stretch;
                flex-direction: column;
            }

            .student-filter-form select {
                width: 100%;
            }

            .filter-hint {
                margin-left: 0;
            }

            .records-footer {
                padding: 13px 17px;
            }
        }

        @media print {
            header,
            .student-form-panel,
            .student-filter-panel,
            .student-actions,
            .no-print {
                display: none !important;
            }

            body {
                background: #fff;
            }

            .student-panel {
                box-shadow: none;
            }

            .records-panel {
                border: 0;
            }

            .student-table {
                min-width: 0;
                font-size: 10px;
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

    List<Student> students =
            (List<Student>) request.getAttribute("students");

    List<Course> courses =
            (List<Course>) request.getAttribute("courses");

    Student editStudent =
            (Student) request.getAttribute("editStudent");

    boolean isEdit = editStudent != null;

    String selectedClass = request.getParameter("classNo");

    if (selectedClass == null || selectedClass.trim().isEmpty()) {
        Object selected = request.getAttribute("selectedClass");
        selectedClass = selected == null ? "all" : selected.toString();
    }

    int studentCount = students == null ? 0 : students.size();
    int courseCount = courses == null ? 0 : courses.size();

    String roleLabel = "ADMIN".equals(user.getRole())
            ? "ADMIN"
            : "STAFF";

    String dashboardPath = "ADMIN".equals(user.getRole())
            ? "admin"
            : "staff";

    String csrfToken = (String) request.getAttribute("csrfToken");
    if (csrfToken == null) {
        csrfToken = "";
    }
%>

<header>
    <h1>🎓 BTVP HIGH SCHOOL</h1>

    <nav aria-label="Main navigation">
        <a href="${pageContext.request.contextPath}/<%= dashboardPath %>/dashboard.jsp">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/student">
            Students
        </a>

        <a href="${pageContext.request.contextPath}/weeklytest">
            Weekly Tests
        </a>

        <% if ("ADMIN".equals(user.getRole())) { %>
            <a href="${pageContext.request.contextPath}/staff-management">
                Staff
            </a>
        <% } %>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </nav>
</header>

<main class="container students-page">

    <!-- PAGE TITLE -->
    <section class="student-page-heading">
        <div>
            <h2>Student Management</h2>
            <p>
                Manage student profiles, academic details and class-wise records.
            </p>
        </div>

        <span class="role-badge">
            ● <%= roleLabel %> ACCESS
        </span>
    </section>

    <!-- SUMMARY CARDS -->
    <section class="student-summary-grid">

        <div class="student-summary-card">
            <div class="summary-icon">👨‍🎓</div>
            <div>
                <p class="summary-label">Students Displayed</p>
                <p class="summary-value"><%= studentCount %></p>
            </div>
        </div>

        <div class="student-summary-card">
            <div class="summary-icon">📚</div>
            <div>
                <p class="summary-label">Available Courses</p>
                <p class="summary-value"><%= courseCount %></p>
            </div>
        </div>

        <div class="student-summary-card">
            <div class="summary-icon">🏫</div>
            <div>
                <p class="summary-label">Classes Managed</p>
                <p class="summary-value">4</p>
            </div>
        </div>

    </section>

    <!-- ADD / EDIT STUDENT FORM -->
    <section class="student-panel student-form-panel">

        <div class="student-panel-heading">
            <div>
                <h3>
                    <%= isEdit ? "✏️ Edit Student Details" : "＋ Add New Student" %>
                </h3>

                <p>
                    <%= isEdit
                            ? "Update the selected student's information."
                            : "Enter the student's academic and personal information." %>
                </p>
            </div>

            <% if (isEdit) { %>
                <span class="class-badge">EDITING RECORD</span>
            <% } %>
        </div>

        <form action="${pageContext.request.contextPath}/student"
              method="post">

            <input type="hidden"
                   name="action"
                   value="<%= isEdit ? "update" : "add" %>">

            <div class="student-form-grid">

                <div>
                    <label for="regNo">Registration Number *</label>

                    <input id="regNo"
                           type="text"
                           name="regNo"
                           value="<%= isEdit ? editStudent.getRegNo() : "" %>"
                           <%= isEdit ? "readonly" : "" %>
                           placeholder="e.g. BTVP2026STD01"
                           maxlength="20"
                           required>
                </div>

                <div>
                    <label for="name">Student Name *</label>

                    <input id="name"
                           type="text"
                           name="name"
                           value="<%= isEdit ? editStudent.getName() : "" %>"
                           placeholder="Enter full name"
                           maxlength="20"
                           required>
                </div>

                <div>
                    <label for="studentClass">Class *</label>

                    <select id="studentClass"
                            name="classNo"
                            required>

                        <option value="">Select class</option>

                        <% for (int c = 7; c <= 10; c++) { %>
                            <option value="<%= c %>"
                                <%= isEdit
                                        && editStudent.getClassNo() == c
                                        ? "selected"
                                        : "" %>>
                                Class <%= c %>
                            </option>
                        <% } %>

                    </select>
                </div>

                <div>
                    <label for="courseId">Course *</label>

                    <select id="courseId"
                            name="courseId"
                            required>

                        <option value="">Select course</option>

                        <% if (courses != null) {
                            for (Course c : courses) { %>

                                <option value="<%= c.getCourseId() %>"
                                    <%= isEdit
                                            && c.getCourseId() != null
                                            && c.getCourseId().equals(editStudent.getCourseId())
                                            ? "selected"
                                            : "" %>>

                                    <%= c.getCourseName() %>
                                    (<%= c.getCourseId() %>)

                                </option>

                        <%  }
                        } %>

                    </select>
                </div>

                <div>
                    <label for="gender">Gender *</label>

                    <select id="gender"
                            name="gender"
                            required>

                        <option value="">Select gender</option>

                        <option value="Male"
                            <%= isEdit && "Male".equals(editStudent.getGender())
                                    ? "selected" : "" %>>
                            Male
                        </option>

                        <option value="Female"
                            <%= isEdit && "Female".equals(editStudent.getGender())
                                    ? "selected" : "" %>>
                            Female
                        </option>

                        <option value="Other"
                            <%= isEdit && "Other".equals(editStudent.getGender())
                                    ? "selected" : "" %>>
                            Other
                        </option>

                    </select>
                </div>

                <div>
                    <label for="villege">Village *</label>

                    <input id="villege"
                           type="text"
                           name="villege"
                           value="<%= isEdit ? editStudent.getVillege() : "" %>"
                           placeholder="Enter village"
                           maxlength="20"
                           required>
                </div>

                <div>
                    <label for="pincode">Pincode *</label>

                    <input id="pincode"
                           type="number"
                           name="pincode"
                           value="<%= isEdit ? editStudent.getPincode() : "" %>"
                           placeholder="6-digit pincode"
                           min="100000"
                           max="999999"
                           required>
                </div>

                <div>
                    <label for="state">State *</label>

                    <input id="state"
                           type="text"
                           name="state"
                           value="<%= isEdit ? editStudent.getState() : "Karnataka" %>"
                           placeholder="Enter state"
                           maxlength="20"
                           required>
                </div>

            </div>

            <div class="student-form-actions">

                <button type="submit" class="btn">
                    <%= isEdit ? "Save Student Changes" : "＋ Add Student" %>
                </button>

                <% if (isEdit) { %>

                    <a class="btn btn-secondary"
                       href="${pageContext.request.contextPath}/student">
                        Cancel
                    </a>

                <% } else { %>

                    <button type="reset" class="btn btn-secondary">
                        Clear Form
                    </button>

                <% } %>

            </div>

        </form>
    </section>

    <!-- STUDENT RECORDS -->
    <section class="student-panel records-panel">

        <div class="records-panel-heading">

            <div class="student-panel-heading">
                <div>
                    <h3>Student Records</h3>
                    <p>
                        View and manage student details by class.
                    </p>
                </div>

                <span class="records-count">
                    <%= studentCount %> record(s)
                </span>
            </div>

        </div>

        <!-- CLASS FILTER -->
        <div class="student-filter-panel">

            <form action="${pageContext.request.contextPath}/student"
                  method="get"
                  class="student-filter-form">

                <label for="classFilter">
                    Filter by class
                </label>

                <select name="classNo"
                        id="classFilter"
                        onchange="this.form.submit()">

                    <option value="all"
                        <%= "all".equals(selectedClass) ? "selected" : "" %>>
                        All Classes
                    </option>

                    <% for (int c = 7; c <= 10; c++) { %>

                        <option value="<%= c %>"
                            <%= String.valueOf(c).equals(selectedClass)
                                    ? "selected"
                                    : "" %>>
                            Class <%= c %>
                        </option>

                    <% } %>

                </select>

                <noscript>
                    <button type="submit" class="btn">
                        Apply Filter
                    </button>
                </noscript>

                <span class="filter-hint">
                    Classes 7–10 · Student directory
                </span>

            </form>
        </div>

        <!-- RESPONSIVE TABLE -->
        <div class="student-table-wrapper">

            <table class="student-table">

                <thead>
                    <tr>
                        <th>Registration No.</th>
                        <th>Student Name</th>
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

                <% if (students == null || students.isEmpty()) { %>

                    <tr>
                        <td colspan="9" class="empty-students">
                            <strong>No students found</strong>
                            Try selecting another class or add a student using the form above.
                        </td>
                    </tr>

                <% } else {
                    for (Student s : students) { %>

                        <tr>

                            <td class="student-regno">
                                <%= s.getRegNo() %>
                            </td>

                            <td class="student-name">
                                <%= s.getName() %>
                            </td>

                            <td>
                                <span class="class-badge">
                                    Class <%= s.getClassNo() %>
                                </span>
                            </td>

                            <td>
                                <%= s.getCourseName() == null
                                        ? s.getCourseId()
                                        : s.getCourseName() %>
                            </td>

                            <td><%= s.getGender() %></td>
                            <td><%= s.getVillege() %></td>
                            <td><%= s.getPincode() %></td>
                            <td><%= s.getState() %></td>

                            <td>
                                <div class="student-actions">

                                    <a class="btn btn-secondary"
                                       href="${pageContext.request.contextPath}/student?action=edit&amp;regNo=<%= java.net.URLEncoder.encode(s.getRegNo(), "UTF-8") %>">
                                        Edit
                                    </a>

                                    <!-- DELETE: POST request with CSRF token -->
                                    <form action="${pageContext.request.contextPath}/student"
                                          method="post"
                                          onsubmit="return confirm('Are you sure you want to delete this student? This action cannot be undone.');">

                                        <input type="hidden"
                                               name="action"
                                               value="delete">

                                        <input type="hidden"
                                               name="regNo"
                                               value="<%= s.getRegNo() == null ? "" : s.getRegNo().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>">

                                        <input type="hidden"
                                               name="csrfToken"
                                               value="<%= csrfToken %>">

                                        <button type="submit"
                                                class="btn btn-danger">
                                            Delete
                                        </button>
                                    </form>

                                </div>
                            </td>

                        </tr>

                    <% }
                } %>

                </tbody>

            </table>

        </div>

        <div class="records-footer">
            BTVP HIGH SCHOOL · Student Management
            <span style="float:right;">Role: <%= roleLabel %></span>
        </div>

    </section>

</main>

</body>
</html>
