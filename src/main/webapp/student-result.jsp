<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.college.model.Student" %>
<%@ page import="com.college.model.WeeklyTest" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Academic Report | Sunrise College</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* =========================================
           PRINT STYLES
           ========================================= */

        @media print {

            header,
            .no-print,
            footer {
                display: none !important;
            }

            body {
                background: white !important;
                color: black !important;
            }

            .container {
                width: 100% !important;
                margin: 0 !important;
            }

            .card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
                break-inside: avoid;
                page-break-inside: avoid;
            }

            .print-header {
                display: block !important;
            }

        }

        .print-header {
            display: none;
            text-align: center;
            margin-bottom: 25px;
        }

        .print-header h1 {
            margin-bottom: 5px;
        }

        .print-header p {
            margin: 0;
            color: #555;
        }

        .result-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin: 25px 0;
            flex-wrap: wrap;
        }

    </style>

</head>


<body>


<header class="no-print">

    <h1>Sunrise College</h1>

    <nav>

        <a href="${pageContext.request.contextPath}/index.jsp">
            🏠 Home
        </a>

        <a href="${pageContext.request.contextPath}/login.jsp">
            🔐 Login
        </a>

    </nav>

</header>


<main class="container">


<%

    Student student =
            (Student) request.getAttribute("student");

    List<WeeklyTest> tests =
            (List<WeeklyTest>) request.getAttribute("tests");

%>


<%

    if (student == null) {

%>


    <!-- =========================================
         STUDENT NOT FOUND
         ========================================= -->

    <div class="card"
         style="text-align:center; margin-top:60px;">

        <div style="font-size:60px;">
            🔍
        </div>

        <h2>
            Student Not Found
        </h2>

        <p style="margin:15px 0 25px;">

            No student record was found for the
            registration number you entered.

        </p>

        <a
            href="${pageContext.request.contextPath}/index.jsp"
            class="btn">

            ← Search Again

        </a>

    </div>


<%

    } else {

%>


    <!-- =========================================
         PRINT HEADER
         ========================================= -->

    <div class="print-header">

        <h1>
            SUNRISE COLLEGE
        </h1>

        <p>
            Student Academic Report
        </p>

        <p>
            Registration Number:
            <strong>
                <%= student.getRegNo() %>
            </strong>
        </p>

    </div>


    <!-- =========================================
         PAGE TITLE
         ========================================= -->

    <div class="dashboard-heading no-print">

        <div>

            <h2>
                🎓 Student Academic Report
            </h2>

            <p>
                Complete academic information and
                weekly test performance.
            </p>

        </div>

    </div>


    <!-- =========================================
         STUDENT PROFILE
         ========================================= -->

    <div class="card">

        <div class="profile-card">

            <div class="profile-avatar">
                👨‍🎓
            </div>

            <div>

                <h2>
                    <%= student.getName() %>
                </h2>

                <p>

                    Registration Number:

                    <strong>
                        <%= student.getRegNo() %>
                    </strong>

                </p>

            </div>

        </div>

    </div>


    <!-- =========================================
         STUDENT INFORMATION
         ========================================= -->

    <div class="card">

        <h2>
            📋 Student Information
        </h2>

        <div class="student-info">


            <div class="info-item">

                <span>
                    Registration Number
                </span>

                <strong>
                    <%= student.getRegNo() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Student Name
                </span>

                <strong>
                    <%= student.getName() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Class
                </span>

                <strong>
                    <%= student.getClassNo() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Course
                </span>

                <strong>
                    <%= student.getCourseName() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Gender
                </span>

                <strong>
                    <%= student.getGender() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Village
                </span>

                <strong>
                    <%= student.getVillege() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    Pincode
                </span>

                <strong>
                    <%= student.getPincode() %>
                </strong>

            </div>


            <div class="info-item">

                <span>
                    State
                </span>

                <strong>
                    <%= student.getState() %>
                </strong>

            </div>


        </div>

    </div>


    <!-- =========================================
         WEEKLY TEST RESULTS
         ========================================= -->

    <div class="card">

        <h2>
            📊 Weekly Test Results
        </h2>

        <p style="margin-bottom:15px;">
            Student academic test performance.
        </p>


        <%

            if (tests == null || tests.isEmpty()) {

        %>


            <div class="empty-state">

                <div class="empty-icon">
                    📝
                </div>

                <h3>
                    No Test Records
                </h3>

                <p>
                    No weekly test records are available
                    for this student.
                </p>

            </div>


        <%

            } else {

        %>


            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                Test ID
                            </th>

                            <th>
                                Marks
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <%

                        int totalMarks = 0;

                        for (WeeklyTest test : tests) {

                            totalMarks += test.getMarks();

                    %>


                        <tr>

                            <td>

                                <strong>
                                    <%= test.getTestId() %>
                                </strong>

                            </td>


                            <td>

                                <span class="badge badge-success">

                                    <%= test.getMarks() %> / 100

                                </span>

                            </td>

                        </tr>


                    <%

                        }

                    %>


                    </tbody>

                </table>

            </div>


        <%

            }

        %>


    </div>


    <!-- =========================================
         ACTION BUTTONS
         ========================================= -->

    <div class="result-actions no-print">


        <button
            type="button"
            class="btn"
            onclick="window.print();">

            🖨 Print / Save PDF

        </button>


        <a
            href="${pageContext.request.contextPath}/index.jsp"
            class="btn btn-secondary">

            ← Search Another Student

        </a>


    </div>


<%

    }

%>


</main>


<footer class="no-print">

    <p>
        © 2026 Sunrise College. All Rights Reserved.
    </p>

</footer>


</body>

</html>