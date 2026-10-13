
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>BTVP HIGH SCHOOL | Student Management</title>

    <meta name="description"
          content="BTVP High School student information and academic management portal.">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<header class="site-header">
    <div class="container header-inner">

        <a class="brand" href="${pageContext.request.contextPath}/">
            <span class="brand-logo">B</span>

            <span class="brand-text">
                <span class="brand-name">BTVP HIGH SCHOOL</span>
                <span class="brand-subtitle">
                    Education · Excellence · Success
                </span>
            </span>
        </a>

        <nav class="main-nav" aria-label="Main navigation">
            <a href="#home">Home</a>
            <a href="#about">About College</a>
            <a href="#staff">Staff</a>
            <a href="#achievements">Achievements</a>
            <a href="#contact">Contact</a>

            <a class="nav-login"
               href="${pageContext.request.contextPath}/login.jsp">
                Admin / Staff Login
            </a>
        </nav>

    </div>
</header>

<main>

    <!-- Hero section -->
    <section class="hero" id="home">
        <div class="container hero-inner">

            <div class="hero-content">
                <span class="hero-label">Welcome to our institution</span>

                <h1>Building Knowledge.<br>Shaping the Future.</h1>

                <p>
                    Welcome to BTVP HIGH SCHOOL. We are committed to
                    quality education, student development, and creating
                    a supportive environment where every student can grow
                    and succeed.
                </p>

                <div class="hero-actions">
                    <a class="btn btn-white" href="#student-search">
                        Search Student Results
                    </a>

                    <a class="btn btn-outline" href="#about">
                        Discover Our School
                    </a>
                </div>
            </div>

            <aside class="hero-panel">
                <h2>Student Information Portal</h2>

                <p>
                    Access student information using the registration
                    number provided by the school.
                </p>

                <div class="hero-panel-list">
                    <div class="hero-panel-item">
                        <span class="hero-panel-icon">&#10003;</span>
                        Student information lookup
                    </div>

                    <div class="hero-panel-item">
                        <span class="hero-panel-icon">&#128218;</span>
                        Academic information
                    </div>

                    <div class="hero-panel-item">
                        <span class="hero-panel-icon">&#128274;</span>
                        Staff and administrator access
                    </div>
                </div>
            </aside>

        </div>
    </section>

    <!-- Student search -->
    <section class="search-section" id="student-search">
        <div class="container">

            <div class="search-card">
                <h2>Find Student Information</h2>

                <p>
                    Enter the student's registration number to view
                    the available student and academic details.
                </p>

                <form class="search-form"
                      action="${pageContext.request.contextPath}/searchStudent"
                      method="get">

                    <input
                        type="text"
                        id="regNo"
                        name="regNo"
                        placeholder="Example: BTVP2026STD01"
                        aria-label="Student registration number"
                        autocomplete="off"
                        required>

                    <button type="submit" class="btn btn-primary">
                        Search Student
                    </button>

                </form>
            </div>

        </div>
    </section>

    <!-- About -->
    <section class="section" id="about">
        <div class="container">

            <h2 class="section-heading">About Our School</h2>

            <p class="section-description">
                Our aim is to support students through quality teaching,
                academic guidance, discipline, and opportunities to
                develop their knowledge and abilities.
            </p>

            <div class="card-grid">

                <article class="card">
                    <div class="card-icon">&#128218;</div>
                    <h3>Quality Education</h3>
                    <p>
                        Encourage learning, understanding, curiosity,
                        and strong academic foundations.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#127919;</div>
                    <h3>Student Development</h3>
                    <p>
                        Support students in developing confidence,
                        responsibility, and practical skills.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#129309;</div>
                    <h3>Supportive Environment</h3>
                    <p>
                        Promote respect, cooperation, discipline,
                        and positive relationships.
                    </p>
                </article>

            </div>
        </div>
    </section>

    <!-- Staff -->
    <section class="section" id="staff"
             style="background: #edf2f9;">

        <div class="container">
            <h2 class="section-heading">Our Staff</h2>

            <p class="section-description">
                Teachers and staff contribute to student learning,
                academic guidance, and the smooth functioning of
                the school.
            </p>

            <div class="card-grid">

                <article class="card">
                    <div class="card-icon">&#128104;&#8205;&#127979;</div>
                    <h3>Dedicated Teachers</h3>
                    <p>
                        Helping students understand subjects and
                        strengthen their academic foundations.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#128100;</div>
                    <h3>Academic Guidance</h3>
                    <p>
                        Supporting students in their learning
                        progress and educational development.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#128188;</div>
                    <h3>School Administration</h3>
                    <p>
                        Managing student records, academic activities,
                        and essential school information.
                    </p>
                </article>

            </div>
        </div>
    </section>

    <!-- Achievements -->
    <section class="section" id="achievements">
        <div class="container">

            <h2 class="section-heading">Our Commitment</h2>

            <p class="section-description">
                We focus on the essential foundations of a successful
                educational experience.
            </p>

            <div class="card-grid">

                <article class="card">
                    <div class="card-icon">&#127942;</div>
                    <h3>Academic Progress</h3>
                    <p>
                        Encourage continuous improvement in learning
                        and academic performance.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#127793;</div>
                    <h3>Overall Growth</h3>
                    <p>
                        Promote personal development, confidence,
                        good habits, and responsibility.
                    </p>
                </article>

                <article class="card">
                    <div class="card-icon">&#11088;</div>
                    <h3>Future Readiness</h3>
                    <p>
                        Inspire students to set goals and prepare
                        for future educational opportunities.
                    </p>
                </article>

            </div>
        </div>
    </section>

    <!-- Contact -->
    <section class="section" id="contact"
             style="background: #edf2f9;">

        <div class="container">
            <h2 class="section-heading">Contact &amp; Information</h2>

            <p class="section-description">
                For student records, academic information, or
                administrative assistance, please contact the school
                office.
            </p>

            <div class="content-panel">
                <h3>BTVP HIGH SCHOOL</h3>

                <p class="muted">
                    Please contact the school office for verified
                    address details, office hours, and other official
                    contact information.
                </p>

                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/login.jsp">
                    Staff / Admin Login
                </a>
            </div>
        </div>
    </section>

</main>

<footer class="site-footer">
    <div class="container footer-inner">

        <p>
            &copy; <%= java.time.Year.now().getValue() %>
            BTVP HIGH SCHOOL. All rights reserved.
        </p>

        <div class="footer-links">
            <a href="#home">Home</a>
            <a href="#about">About</a>
            <a href="#student-search">Student Search</a>
            <a href="#contact">Contact</a>
        </div>

    </div>
</footer>

</body>
</html>
