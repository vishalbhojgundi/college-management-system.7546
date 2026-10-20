
package com.college.controller;

import com.college.dao.CourseDAO;
import com.college.dao.StudentDAO;
import com.college.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    // Allow only logged-in ADMIN and STAFF users.
    private boolean isAuthorized(HttpServletRequest req) {

        HttpSession session = req.getSession(false);

        if (session == null) {
            return false;
        }

        String role = (String) session.getAttribute("role");

        return "ADMIN".equals(role) || "STAFF".equals(role);
    }

    // Create or reuse the CSRF token stored in the session.
    private String getOrCreateCsrfToken(HttpSession session) {

        String token = (String) session.getAttribute("csrfToken");

        if (token == null || token.trim().isEmpty()) {
            token = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", token);
        }

        return token;
    }

    // Validate the submitted CSRF token.
    private boolean isValidCsrfToken(
            HttpServletRequest req,
            HttpSession session) {

        if (session == null) {
            return false;
        }

        String expectedToken =
                (String) session.getAttribute("csrfToken");

        String submittedToken =
                req.getParameter("csrfToken");

        if (expectedToken == null || submittedToken == null) {
            return false;
        }

        return MessageDigest.isEqual(
                expectedToken.getBytes(StandardCharsets.UTF_8),
                submittedToken.getBytes(StandardCharsets.UTF_8)
        );
    }

    // GET: Display students and the edit form.
    // GET requests never delete records.
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        HttpSession session = req.getSession(false);

        req.setAttribute(
                "csrfToken",
                getOrCreateCsrfToken(session)
        );

        String action = req.getParameter("action");

        // An old GET delete URL must never delete anything.
        if ("delete".equals(action)) {
            resp.sendError(
                    HttpServletResponse.SC_METHOD_NOT_ALLOWED,
                    "Student deletion requires a POST request."
            );
            return;
        }

        // Load the selected student for editing.
        if ("edit".equals(action)) {

            String regNo = req.getParameter("regNo");

            if (regNo != null && !regNo.trim().isEmpty()) {
                Student student =
                        studentDAO.getStudentByRegNo(regNo.trim());

                req.setAttribute("editStudent", student);
            }
        }

        // Load all students.
        List<Student> allStudents = studentDAO.getAllStudents();

        String selectedClass = req.getParameter("classNo");

        List<Student> displayedStudents = new ArrayList<>();

        // Show every student when no class is selected.
        if (selectedClass == null
                || selectedClass.trim().isEmpty()
                || "all".equals(selectedClass)) {

            displayedStudents.addAll(allStudents);

        } else {

            try {
                int classNumber = Integer.parseInt(selectedClass);

                if (classNumber >= 7 && classNumber <= 10) {

                    for (Student student : allStudents) {
                        if (student.getClassNo() == classNumber) {
                            displayedStudents.add(student);
                        }
                    }
                }

            } catch (NumberFormatException e) {
                // Invalid class selection: show no students.
            }
        }

        req.setAttribute("students", displayedStudents);
        req.setAttribute("selectedClass", selectedClass);

        // Load courses required by the JSP.
        req.setAttribute("courses", courseDAO.getAllCourses());

        // Forward to the existing students page.
        req.getRequestDispatcher("/admin/students.jsp")
                .forward(req, resp);
    }

    // POST: Add, update, or delete a student.
    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        // Handle deletion separately before creating a Student object.
        if ("delete".equals(action)) {

            HttpSession session = req.getSession(false);

            if (!isValidCsrfToken(req, session)) {
                resp.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "Invalid security token. Refresh the page and try again."
                );
                return;
            }

            // Only ADMIN may delete students.
            if (!"ADMIN".equals(session.getAttribute("role"))) {
                resp.sendError(
                        HttpServletResponse.SC_FORBIDDEN,
                        "You are not permitted to delete students."
                );
                return;
            }

            String regNo = req.getParameter("regNo");

            if (regNo == null || regNo.trim().isEmpty()) {
                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Student registration number is required."
                );
                return;
            }

            boolean deleted =
                    studentDAO.deleteStudent(regNo.trim());

            if (!deleted) {
                resp.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Student was not deleted. The record may not exist."
                );
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/student");
            return;
        }

        // Preserve existing add and update functionality.
        Student student = new Student();

        student.setRegNo(req.getParameter("regNo"));
        student.setName(req.getParameter("name"));
        student.setClassNo(parseIntSafe(req.getParameter("classNo")));
        student.setCourseId(req.getParameter("courseId"));
        student.setGender(req.getParameter("gender"));
        student.setVillege(req.getParameter("villege"));
        student.setPincode(parseIntSafe(req.getParameter("pincode")));
        student.setState(req.getParameter("state"));

        if ("add".equals(action)) {

            studentDAO.addStudent(student);

        } else if ("update".equals(action)) {

            studentDAO.updateStudent(student);

        } else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student action."
            );
            return;
        }

        // Reload the student list after adding or updating.
        resp.sendRedirect(req.getContextPath() + "/student");
    }

    // Safely convert form values to integers.
    private int parseIntSafe(String value) {

        try {
            if (value == null || value.trim().isEmpty()) {
                return 0;
            }

            return Integer.parseInt(value.trim());

        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
