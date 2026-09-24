package com.college.controller;

import com.college.dao.CourseDAO;
import com.college.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles:
 * 1. View courses
 * 2. Add course
 * 3. Update course
 * 4. Delete course
 *
 * Only ADMIN and STAFF can access this servlet.
 */
@WebServlet("/course")
public class CourseServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
     * /course
     *              -> Show all courses
     *
     * /course?action=delete&courseId=...
     *              -> Delete course
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
         * DELETE COURSE
         */
        if ("delete".equals(action)) {

            String courseId = req.getParameter("courseId");

            if (courseId != null && !courseId.trim().isEmpty()) {

                courseDAO.deleteCourse(courseId);
            }

            /*
             * IMPORTANT:
             *
             * Do NOT redirect directly to:
             *
             * /admin/courses.jsp
             *
             * Redirect to /course so that the servlet
             * loads the courses again.
             */
            resp.sendRedirect(req.getContextPath() + "/course");
            return;
        }

        /*
         * LOAD ALL COURSES
         */
        req.setAttribute(
                "courses",
                courseDAO.getAllCourses()
        );

        /*
         * Forward to JSP only after courses
         * have been loaded.
         */
        req.getRequestDispatcher(
                "/admin/courses.jsp"
        ).forward(req, resp);
    }

    /**
     * POST requests:
     *
     * action=add
     *      -> Add course
     *
     * action=update
     *      -> Update course
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
         * Get action from form.
         */
        String action = req.getParameter("action");

        /*
         * Create Course object.
         */
        Course course = new Course();

        course.setCourseId(
                req.getParameter("courseId")
        );

        course.setCourseName(
                req.getParameter("courseName")
        );

        /*
         * ADD COURSE
         */
        if ("add".equals(action)) {

            courseDAO.addCourse(course);
        }

        /*
         * UPDATE COURSE
         */
        else if ("update".equals(action)) {

            courseDAO.updateCourse(course);
        }

        /*
         * Invalid action
         */
        else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid course action"
            );

            return;
        }

        /*
         * IMPORTANT:
         *
         * Redirect to /course.
         *
         * The servlet will:
         *
         * 1. Get all courses
         * 2. Put them into request
         * 3. Forward to courses.jsp
         */
        resp.sendRedirect(
                req.getContextPath() + "/course"
        );
    }
}