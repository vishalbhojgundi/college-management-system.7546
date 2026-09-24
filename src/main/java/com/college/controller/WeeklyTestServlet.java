package com.college.controller;

import com.college.dao.StudentDAO;
import com.college.dao.WeeklyTestDAO;
import com.college.model.WeeklyTest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles:
 * 1. View weekly tests
 * 2. Add weekly test
 * 3. Update weekly test
 * 4. Delete weekly test
 *
 * Only ADMIN and STAFF can access this servlet.
 */
@WebServlet("/weeklytest")
public class WeeklyTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final WeeklyTestDAO testDAO = new WeeklyTestDAO();
    private final StudentDAO studentDAO = new StudentDAO();

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
     * GET:
     *
     * /weeklytest
     *                  -> Show all tests and students
     *
     * /weeklytest?action=delete&testId=...
     *                  -> Delete test
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
         * DELETE TEST
         */
        if ("delete".equals(action)) {

            String testId = req.getParameter("testId");

            if (testId != null && !testId.trim().isEmpty()) {
                testDAO.deleteTest(testId);
            }

            /*
             * IMPORTANT:
             *
             * Do NOT redirect directly to:
             *
             * /admin/tests.jsp
             *
             * Redirect to /weeklytest so that the servlet
             * loads tests and students again.
             */
            resp.sendRedirect(
                    req.getContextPath() + "/weeklytest"
            );

            return;
        }

        /*
         * LOAD ALL WEEKLY TEST RECORDS
         */
        req.setAttribute(
                "tests",
                testDAO.getAllTests()
        );

        /*
         * LOAD ALL STUDENTS
         *
         * This is required by tests.jsp because
         * the Student dropdown uses:
         *
         * for (Student s : students)
         */
        req.setAttribute(
                "students",
                studentDAO.getAllStudents()
        );

        /*
         * Forward to JSP.
         */
        req.getRequestDispatcher(
                "/admin/tests.jsp"
        ).forward(req, resp);
    }

    /**
     * POST:
     *
     * action=add
     *      -> Add weekly test
     *
     * action=update
     *      -> Update weekly test
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check login and role
        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        /*
         * Create WeeklyTest object.
         */
        WeeklyTest test = new WeeklyTest();

        test.setTestId(
                req.getParameter("testId")
        );

        test.setRegNo(
                req.getParameter("regNo")
        );

        test.setMarks(
                parseIntSafe(req.getParameter("marks"))
        );

        /*
         * ADD TEST
         */
        if ("add".equals(action)) {

            testDAO.addTest(test);
        }

        /*
         * UPDATE TEST
         */
        else if ("update".equals(action)) {

            testDAO.updateTest(test);
        }

        /*
         * Invalid action
         */
        else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid weekly test action"
            );

            return;
        }

        /*
         * IMPORTANT:
         *
         * Redirect to /weeklytest.
         *
         * The servlet will reload:
         *
         * 1. tests
         * 2. students
         *
         * and then forward to tests.jsp.
         */
        resp.sendRedirect(
                req.getContextPath() + "/weeklytest"
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