<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <title>Sunrise College</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<header>

    <h1>Sunrise College</h1>

    <nav>

        <a href="#about">About</a>

        <a href="#staff">Staff</a>

        <a href="#achievements">Achievements</a>

        <a href="#contact">Contact</a>

        <a href="${pageContext.request.contextPath}/login.jsp">
            Staff / Admin Login
        </a>

    </nav>

</header>


<div class="container">


    <!-- ============================= -->
    <!-- SEARCH CHILD -->
    <!-- ============================= -->

    <div class="card">

        <h2>View Student Information</h2>

        <p>
            Parents can view their child's academic information
            using the Registration Number.
        </p>


        <form action="${pageContext.request.contextPath}/searchStudent"
              method="get">

            <label>
                Student Registration Number
            </label>

            <input
                type="text"
                name="regNo"
                placeholder="Enter Registration Number"
                required
            >

            <button type="submit" class="btn">
                Search Student
            </button>

        </form>

    </div>


    <!-- ============================= -->
    <!-- STUDENT RESULT -->
    <!-- ============================= -->

    <%
        Student student =
                (Student) request.getAttribute("student");

        List<WeeklyTest> tests =
                (List<WeeklyTest>) request.getAttribute("tests");

        String searchedRegNo =
                request.getParameter("regNo");
    %>


    <%
        if (searchedRegNo != null &&
            !searchedRegNo.trim().isEmpty()) {
    %>

        <div class="card">

            <h2>Student Information</h2>


            <%
                if (student == null) {
            %>

                <p class="error">
                    No student found with Registration Number:
                    <strong><%= searchedRegNo %></strong>
                </p>

            <%
                } else {
            %>


                <table>

                    <tr>
                        <th>Registration No.</th>
                        <td>
                            <%= student.getRegNo() %>
                        </td>
                    </tr>

                    <tr>
                        <th>Name</th>
                        <td>
                            <%= student.getName() %>
                        </td>
                    </tr>

                    <tr>
                        <th>Class</th>
                        <td>
                            <%= student.getClassNo() %>
                        </td>
                    </tr>

                    <tr>
                        <th>Course</th>
                        <td>
                            <%= student.getCourseName() %>
                        </td>
                    </tr>

                    <tr>
                        <th>Gender</th>
                        <td>
                            <%= student.getGender() %>
                        </td>
                    </tr>

                    <tr>
                        <th>Village</th>
                        <td>
                            <%= student.getVillege() %>
                        </td>
                    </tr>

                    <tr>
                        <th>State</th>
                        <td>
                            <%= student.getState() %>
                        </td>
                    </tr>

                </table>


            <%
                }
            %>

        </div>


        <!-- ============================= -->
        <!-- WEEKLY TEST RESULTS -->
        <!-- ============================= -->

        <%
            if (student != null) {
        %>

        <div class="card">

            <h2>Weekly Test Results</h2>


            <%
                if (tests == null || tests.isEmpty()) {
            %>

                <p>
                    No weekly test records available.
                </p>

            <%
                } else {
            %>


                <table>

                    <tr>

                        <th>Test ID</th>

                        <th>Marks</th>

                    </tr>


                    <%
                        for (WeeklyTest test : tests) {
                    %>

                    <tr>

                        <td>
                            <%= test.getTestId() %>
                        </td>

                        <td>
                            <%= test.getMarks() %>
                        </td>

                    </tr>

                    <%
                        }
                    %>

                </table>


            <%
                }
            %>

        </div>

        <%
            }
        %>


    <%
        }
    %>


    <!-- ============================= -->
    <!-- ABOUT -->
    <!-- ============================= -->

    <div class="card" id="about">

        <h2>About Us</h2>

        <p>
            Sunrise College is committed to providing
            quality education across multiple courses.
        </p>

        <p>
            Parents can view their child's academic
            progress using the student's Registration Number.
        </p>

    </div>


    <!-- ============================= -->
    <!-- STAFF -->
    <!-- ============================= -->

    <div class="card" id="staff">

        <h2>Our Staff</h2>

        <div class="grid-3">

            <div>
                <strong>Dr. R. Kumar</strong>
                <br>
                Principal
            </div>

            <div>
                <strong>Mrs. S. Sharma</strong>
                <br>
                Vice Principal
            </div>

            <div>
                <strong>Mr. A. Verma</strong>
                <br>
                Head of Computer Science
            </div>

        </div>

    </div>


    <!-- ============================= -->
    <!-- ACHIEVEMENTS -->
    <!-- ============================= -->

    <div class="card" id="achievements">

        <h2>Achievements</h2>

        <ul>

            <li>
                Ranked among top 50 colleges in the state
            </li>

            <li>
                Strong placement record
            </li>

            <li>
                State-level Inter-College Science Fair winner
            </li>

        </ul>

    </div>


    <!-- ============================= -->
    <!-- CONTACT -->
    <!-- ============================= -->

    <div class="card" id="contact">

        <h2>Contact</h2>

        <p>
            Address: 123 College Road, Bengaluru, Karnataka
        </p>

        <p>
            Phone: +91-80-1234-5678
        </p>

        <p>
            Email: info@sunrisecollege.edu
        </p>

    </div>


</div>

</body>

</html>