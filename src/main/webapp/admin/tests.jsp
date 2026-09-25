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

    <title>Weekly Tests | BTVP High School</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<%
    User user =
            (session != null)
            ? (User) session.getAttribute("user")
            : null;

    if (user == null ||
        !("ADMIN".equals(user.getRole()) ||
          "STAFF".equals(user.getRole()))) {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp"
        );

        return;
    }

    List<WeeklyTest> tests =
            (List<WeeklyTest>) request.getAttribute("tests");

    List<Student> students =
            (List<Student>) request.getAttribute("students");


    /*
     * Create a list of available classes
     * from the student table.
     *
     * Example:
     * 7
     * 8
     * 9
     * 10
     */

    Set<Integer> classNumbers =
            new TreeSet<>();

    if (students != null) {

        for (Student s : students) {

            classNumbers.add(
                    s.getClassNo()
            );
        }
    }
%>


<!-- HEADER -->

<header>

    <h1>🎓 BTVP High School</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/<%= "ADMIN".equals(user.getRole()) ? "admin" : "staff" %>/dashboard.jsp">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </nav>

</header>


<!-- MAIN CONTENT -->

<div class="container">


    <!-- PAGE TITLE -->

    <div class="page-header">

        <h2>📝 Weekly Test Management</h2>

        <p>
            Record and manage student test marks.
        </p>

    </div>


    <!-- ADD TEST -->

    <div class="card">

        <h2>➕ Add Weekly Test Mark</h2>


        <form
                action="${pageContext.request.contextPath}/weeklytest"
                method="post"
                id="testForm"
        >

            <input
                    type="hidden"
                    name="action"
                    value="add"
            >


            <!-- TEST ID -->

            <label for="testId">
                Test ID
            </label>

            <input
                    type="text"
                    id="testId"
                    name="testId"
                    placeholder="Example: TEST001"
                    required
            >


            <!-- CLASS -->

            <label for="classNo">
                Class
            </label>

            <select
                    id="classNo"
                    name="classNo"
                    required
            >

                <option value="">
                    Select Class
                </option>

                <%
                    for (Integer classNo : classNumbers) {
                %>

                    <option value="<%= classNo %>">
                        Class <%= classNo %>
                    </option>

                <%
                    }
                %>

            </select>


            <!-- STUDENT -->

            <label for="regNo">
                Student
            </label>

            <select
                    id="regNo"
                    name="regNo"
                    required
                    disabled
            >

                <option value="">
                    First Select Class
                </option>

            </select>


            <!-- MARKS -->

            <label for="marks">
                Marks
            </label>

            <input
                    type="number"
                    id="marks"
                    name="marks"
                    min="0"
                    max="100"
                    placeholder="0 - 100"
                    required
            >


            <!-- BUTTON -->

            <button
                    type="submit"
                    class="btn"
            >
                ➕ Add Test Mark
            </button>

        </form>

    </div>


    <!-- ALL TEST RECORDS -->

    <div class="card">

        <h2>📋 All Weekly-Test Records</h2>


        <div style="overflow-x:auto;">

            <table>

                <thead>

                <tr>

                    <th>Test ID</th>

                    <th>Class</th>

                    <th>Student</th>

                    <th>Reg No</th>

                    <th>Marks</th>

                    <th>Action</th>

                </tr>

                </thead>


                <tbody>

                <%
                    if (tests != null &&
                        !tests.isEmpty()) {

                        for (WeeklyTest t : tests) {
                %>

                    <tr>

                        <td>
                            <%= t.getTestId() %>
                        </td>


                        <td>
                            Class <%= t.getClassNo() %>
                        </td>


                        <td>
                            <%= t.getStudentName() %>
                        </td>


                        <td>
                            <%= t.getRegNo() %>
                        </td>


                        <td>
                            <strong>
                                <%= t.getMarks() %>
                            </strong>
                            / 100
                        </td>


                        <td>

                            <a
                                    class="btn btn-danger"
                                    href="${pageContext.request.contextPath}/weeklytest?action=delete&id=<%= t.getId() %>"
                                    onclick="return confirm('Delete this test record?');"
                            >
                                Delete
                            </a>

                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="6"
                            style="text-align:center;">

                            No weekly test records found.

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

</div>


<!-- CLASS → STUDENT FILTER -->

<script>

    /*
     * Create student data from the students
     * already loaded by WeeklyTestServlet.
     */

    const students = [

        <%
            if (students != null) {

                for (Student s : students) {
        %>

        {
            regNo: "<%= s.getRegNo() %>",
            name: "<%= s.getName() %>",
            classNo: <%= s.getClassNo() %>
        },

        <%
                }
            }
        %>

    ];


    const classSelect =
            document.getElementById("classNo");

    const studentSelect =
            document.getElementById("regNo");


    /*
     * When user selects a class,
     * show only students belonging
     * to that class.
     */

    classSelect.addEventListener(
        "change",
        function () {

            const selectedClass =
                    this.value;


            // Clear old students

            studentSelect.innerHTML =
                    '<option value="">Select Student</option>';


            // No class selected

            if (selectedClass === "") {

                studentSelect.disabled = true;

                return;
            }


            // Find students of selected class

            const filteredStudents =
                    students.filter(
                        function(student) {

                            return String(
                                student.classNo
                            ) === String(
                                selectedClass
                            );

                        }
                    );


            // Add students

            filteredStudents.forEach(
                function(student) {

                    const option =
                            document.createElement("option");

                    option.value =
                            student.regNo;

                    option.textContent =
                            student.regNo +
                            " - " +
                            student.name;

                    studentSelect.appendChild(
                            option
                    );
                }
            );


            // Enable student dropdown

            studentSelect.disabled = false;


            // If no students

            if (filteredStudents.length === 0) {

                studentSelect.innerHTML =
                    '<option value="">No students in this class</option>';

            }

        }
    );

</script>


</body>

</html>