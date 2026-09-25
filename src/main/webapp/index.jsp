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

    <title>BTVP High School | Home</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <script src="${pageContext.request.contextPath}/js/script.js"
            defer></script>

</head>

<body>

<header>

    <h1>BTVP High School</h1>

    <nav>

        <a href="#home">Home</a>

        <a href="#about">About</a>

        <a href="#academics">Academics</a>

        <a href="#achievements">Achievements</a>

        <a href="#contact">Contact</a>

        <a href="${pageContext.request.contextPath}/login.jsp">
            🔐 Login
        </a>

    </nav>

</header>


<main class="container" id="home">

    <!-- HERO -->

    <section class="hero">

        <div class="hero-content">

            <span class="hero-badge">
                🎓 Welcome to  BTVP High School
            </span>

            <h2>
                Building Knowledge.<br>
                Creating Futures.
            </h2>

            <p>
                A modern academic environment focused on
                quality education, student development and
                a brighter future.
            </p>

            <div class="hero-buttons">

                <a href="#student-search" class="btn">
                    🔍 Check Student Information
                </a>

                <a href="#about" class="btn btn-secondary">
                    Learn More
                </a>

            </div>

        </div>

    </section>


    <!-- STUDENT SEARCH -->

    <section class="section" id="student-search">

        <div class="section-title">

            <h2>🎓 Student Academic Portal</h2>

            <p>
                Parents can check their child's academic
                information using the Registration Number.
            </p>

        </div>


        <div class="card search-card">

           <form class="search-form"
                 action="${pageContext.request.contextPath}/searchStudent"
                 method="get">

               <input
                   type="text"
                   name="regNo"
                   placeholder="Enter Student Registration Number"
                   required>

               <button type="submit" class="btn">
                   🔍 Search
               </button>

           </form>

        </div>

    </section>


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

    <!-- SEARCH RESULT -->

    <section class="section">

        <%
            if (student == null) {
        %>

            <div class="card">

                <div class="empty-state">

                    <div class="empty-icon">
                        🔎
                    </div>

                    <h3>Student Not Found</h3>

                    <p>
                        No student was found with Registration Number
                        <strong><%= searchedRegNo %></strong>.
                    </p>

                </div>

            </div>

        <%
            } else {
        %>

            <!-- STUDENT PROFILE -->

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


            <!-- STUDENT DETAILS -->

            <div class="card">

                <h2>📋 Student Information</h2>

                <div class="student-info">

                    <div class="info-item">
                        <span>Registration Number</span>
                        <strong><%= student.getRegNo() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Name</span>
                        <strong><%= student.getName() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Class</span>
                        <strong><%= student.getClassNo() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Course</span>
                        <strong><%= student.getCourseName() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Gender</span>
                        <strong><%= student.getGender() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Village</span>
                        <strong><%= student.getVillege() %></strong>
                    </div>

                    <div class="info-item">
                        <span>Pincode</span>
                        <strong><%= student.getPincode() %></strong>
                    </div>

                    <div class="info-item">
                        <span>State</span>
                        <strong><%= student.getState() %></strong>
                    </div>

                </div>

            </div>


            <!-- WEEKLY TEST -->

            <div class="card">

                <h2>📊 Weekly Test Performance</h2>

                <%
                    if (tests == null || tests.isEmpty()) {
                %>

                    <div class="empty-state">

                        <div class="empty-icon">
                            📝
                        </div>

                        <p>
                            No weekly test records available.
                        </p>

                    </div>

                <%
                    } else {
                %>

                    <div class="table-wrapper">

                        <table>

                            <thead>

                                <tr>

                                    <th>Test ID</th>

                                    <th>Marks</th>

                                </tr>

                            </thead>

                            <tbody>

                            <%
                                for (WeeklyTest test : tests) {
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

        <%
            }
        %>

    </section>

<%
    }
%>


    <!-- ABOUT -->

    <section class="section" id="about">

        <div class="section-title">

            <h2>About BTVP High School</h2>

            <p>
                Empowering students through education,
                knowledge and opportunities.
            </p>

        </div>

        <div class="grid-3">

            <div class="card">

                <div class="card-icon">🎓</div>

                <h3>Quality Education</h3>

                <p>
                    We focus on building strong academic
                    foundations and practical knowledge.
                </p>

            </div>


            <div class="card">

                <div class="card-icon">👨‍🏫</div>

                <h3>Experienced Faculty</h3>

                <p>
                    Dedicated faculty members support students
                    throughout their academic journey.
                </p>

            </div>


            <div class="card">

                <div class="card-icon">🚀</div>

                <h3>Student Growth</h3>

                <p>
                    We encourage students to develop skills,
                    confidence and leadership qualities.
                </p>

            </div>

        </div>

    </section>


    <!-- ACADEMICS -->

    <section class="section" id="academics">

        <div class="section-title">

            <h2>📚 Academics</h2>

            <p>
                A balanced approach to academic excellence.
            </p>

        </div>

        <div class="grid-3">

            <div class="card">

                <div class="card-icon">📖</div>

                <h3>Learning</h3>

                <p>
                    Structured academic programs designed
                    for student success.
                </p>

            </div>

            <div class="card">

                <div class="card-icon">📝</div>

                <h3>Assessments</h3>

                <p>
                    Regular tests help students and teachers
                    track academic progress.
                </p>

            </div>

            <div class="card">

                <div class="card-icon">📊</div>

                <h3>Performance</h3>

                <p>
                    Student performance can be viewed through
                    the academic portal.
                </p>

            </div>

        </div>

    </section>


    <!-- ACHIEVEMENTS -->

    <section class="section" id="achievements">

        <div class="section-title">

            <h2>🏆 Achievements</h2>

            <p>
                Celebrating student success and excellence.
            </p>

        </div>

        <div class="grid-3">

            <div class="card">

                <div class="card-icon">🏆</div>

                <h3>Academic Excellence</h3>

                <p>
                    Encouraging students to achieve their
                    highest academic potential.
                </p>

            </div>

            <div class="card">

                <div class="card-icon">💡</div>

                <h3>Innovation</h3>

                <p>
                    Promoting creativity, technology and
                    problem-solving skills.
                </p>

            </div>

            <div class="card">

                <div class="card-icon">🌟</div>

                <h3>Student Success</h3>

                <p>
                    Supporting students in reaching their
                    educational goals.
                </p>

            </div>

        </div>

    </section>


    <!-- CONTACT -->

    <section class="section" id="contact">

        <div class="card">

            <div class="section-title">

                <h2>📞 Contact Us</h2>

                <p>
                    Get in touch with BTVP Scool.
                </p>

            </div>

            <div class="grid-3">

                <div>
                    <h3>📍 Address</h3>
                    <p>Near Old Bus Stand,Hallikhed Road,Dubalgundi-585418</p>
                </div>

                <div>
                    <h3>📧 Email</h3>
                    <p>btvpschool@dbl.com</p>
                </div>

                <div>
                    <h3>📱 Phone</h3>
                    <p>+91 7483174469</p>
                </div>

            </div>

        </div>

    </section>

</main>


<footer>

    <p>
        © 2026 BTVP High School. All Rights Reserved.
    </p>

</footer>


</body>

</html>