package com.college.controller;
import com.college.model.Student;
import java.util.ArrayList;
import java.util.List;

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

/**
 * Handles:
 * 1. View students
 * 2. Add student
 * 3. Update student
 * 4. Delete student
 *
 * Only ADMIN and STAFF can access this servlet.
 */
@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();
    private final CourseDAO courseDAO = new CourseDAO();

    /**
     * Check whether the logged-in user is ADMIN or STAFF.
     */
    private boolean isAuthorized(HttpServletRequest req) {

        HttpSession session = req.getSession(false);

        if (session == null) {
            return false;
        }

        String role = (String) session.getAttribute("role");

        return "ADMIN".equals(role) || "STAFF".equals(role);
    }

    /**
     * GET requests:
     *
     * /student
     *              -> Show all students
     *
     * /student?action=edit&regNo=...
     *              -> Show student in edit mode
     *
     * /student?action=delete&regNo=...
     *              -> Delete student
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check login and role
        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        /*
         * DELETE STUDENT
         */
        if ("delete".equals(action)) {

            String regNo = req.getParameter("regNo");

            if (regNo != null && !regNo.trim().isEmpty()) {
                studentDAO.deleteStudent(regNo);
            }

            /*
             * IMPORTANT:
             * Do NOT redirect directly to students.jsp.
             *
             * Redirect to /student so that:
             * - students are loaded
             * - courses are loaded
             * - JSP receives all required attributes
             */
            resp.sendRedirect(req.getContextPath() + "/student");
            return;
        }

        /*
         * EDIT STUDENT
         */
        if ("edit".equals(action)) {

            String regNo = req.getParameter("regNo");

            if (regNo != null && !regNo.trim().isEmpty()) {

                Student student = studentDAO.getStudentByRegNo(regNo);

                req.setAttribute("editStudent", student);
            }
        }

        /*
         * LOAD STUDENTS
         */

        List<Student> allStudents = studentDAO.getAllStudents();

        String selectedClass = req.getParameter("classNo");

        List<Student> displayedStudents = new ArrayList<>();

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
                // Invalid class selection: display no students.
            }
        }

        req.setAttribute("students", displayedStudents);
        req.setAttribute("selectedClass", selectedClass);

        /*
         * LOAD COURSES
         *
         * This is VERY IMPORTANT because students.jsp
         * contains:
         *
         * for (Course c : courses)
         */
        req.setAttribute(
                "courses",
                courseDAO.getAllCourses()
        );

        /*
         * Open the students JSP.
         */
        req.getRequestDispatcher(
                "/admin/students.jsp"
        ).forward(req, resp);
    }

    /**
     * POST requests:
     *
     * action=add
     *      -> Add student
     *
     * action=update
     *      -> Update student
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check login and role
        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        /*
         * Get action from the form.
         */
        String action = req.getParameter("action");

        /*
         * Create Student object.
         */
        Student student = new Student();

        student.setRegNo(
                req.getParameter("regNo")
        );

        student.setName(
                req.getParameter("name")
        );

        student.setClassNo(
                parseIntSafe(req.getParameter("classNo"))
        );

        student.setCourseId(
                req.getParameter("courseId")
        );

        student.setGender(
                req.getParameter("gender")
        );

        student.setVillege(
                req.getParameter("villege")
        );

        student.setPincode(
                parseIntSafe(req.getParameter("pincode"))
        );

        student.setState(
                req.getParameter("state")
        );

        /*
         * ADD STUDENT
         */
        if ("add".equals(action)) {

            studentDAO.addStudent(student);
        }

        /*
         * UPDATE STUDENT
         */
        else if ("update".equals(action)) {

            studentDAO.updateStudent(student);
        }

        /*
         * Unknown action
         */
        else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid student action"
            );

            return;
        }

        /*
         * IMPORTANT:
         *
         * After adding/updating the student,
         * redirect to /student instead of directly
         * opening students.jsp.
         *
         * /student will load:
         *
         * students
         * courses
         *
         * and then forward to students.jsp.
         */
        resp.sendRedirect(
                req.getContextPath() + "/student"
        );
    }

    /**
     * Safely convert String to int.
     */
    private int parseIntSafe(String value) {

        try {

            if (value == null || value.trim().isEmpty()) {
                return 0;
            }

            return Integer.parseInt(value);

        } catch (NumberFormatException e) {

            return 0;
        }
    }
}