
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BTVP HIGH SCHOOL | Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/script.js" defer></script>
</head>
<body>
<header>
    <h1>BTVP HIGH SCHOOL</h1>
    <nav>
        <a href="#home">Home</a>
        <a href="#about">About</a>
        <a href="#academics">Academics</a>
        <a href="#achievements">Achievements</a>
        <a href="#contact">Contact</a>
        <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
    </nav>
</header>

<main class="container" id="home">
    <section class="hero">
        <div class="hero-content">
            <span class="hero-badge">Welcome to BTVP HIGH SCHOOL</span>
            <h2>Building Knowledge.<br>Creating Futures.</h2>
            <p>A supportive learning environment focused on quality education, discipline and student development.</p>
            <div class="hero-buttons">
                <a href="#student-search" class="btn">Check Student Information</a>
                <a href="#about" class="btn btn-secondary">Learn More</a>
            </div>
        </div>
    </section>

    <section class="section" id="student-search">
        <div class="section-title">
            <h2>Student Academic Portal</h2>
            <p>Parents can search for student information and weekly test results using the registration number.</p>
        </div>
        <div class="card search-card">
            <form class="search-form"
                  action="${pageContext.request.contextPath}/searchStudent"
                  method="get">
                <input type="text" name="regNo"
                       placeholder="Enter Student Registration Number"
                       required>
                <button type="submit" class="btn">Search Student</button>
            </form>
        </div>
    </section>

    <section class="section" id="about">
        <div class="section-title">
            <h2>About Our School</h2>
            <p>Helping students learn, grow and prepare for the future.</p>
        </div>
        <div class="grid-3">
            <div class="card">
                <h3>Quality Education</h3>
                <p>Build strong foundations through structured learning and regular assessment.</p>
            </div>
            <div class="card">
                <h3>Dedicated Staff</h3>
                <p>Support student learning with guidance, encouragement and academic feedback.</p>
            </div>
            <div class="card">
                <h3>Student Development</h3>
                <p>Encourage responsibility, confidence and continuous improvement.</p>
            </div>
        </div>
    </section>

    <section class="section" id="academics">
        <div class="section-title">
            <h2>Academics</h2>
            <p>Our academic management system helps organize student records and assessments.</p>
        </div>
        <div class="grid-3">
            <div class="card">
                <h3>Student Records</h3>
                <p>Maintain student registration and academic information.</p>
            </div>
            <div class="card">
                <h3>Weekly Tests</h3>
                <p>Record marks and monitor academic performance.</p>
            </div>
            <div class="card">
                <h3>Academic Reports</h3>
                <p>View student details and available weekly test results.</p>
            </div>
        </div>
    </section>

    <section class="section" id="achievements">
        <div class="section-title">
            <h2>Our Goals</h2>
        </div>
        <div class="grid-3">
            <div class="card">
                <h3>Learning</h3>
                <p>Build knowledge through consistent practice.</p>
            </div>
            <div class="card">
                <h3>Progress</h3>
                <p>Use assessments to understand student progress.</p>
            </div>
            <div class="card">
                <h3>Excellence</h3>
                <p>Encourage students to reach their potential.</p>
            </div>
        </div>
    </section>

    <section class="section" id="contact">
        <div class="card">
            <h2>Contact</h2>
            <p><strong>BTVP HIGH SCHOOL</strong></p>
            <p>Please contact the school office for admissions and other enquiries.</p>
        </div>
    </section>
</main>

<footer>
    <p>&copy; <%= java.time.Year.now().getValue() %> BTVP HIGH SCHOOL. All rights reserved.</p>
</footer>
</body>
</html>
