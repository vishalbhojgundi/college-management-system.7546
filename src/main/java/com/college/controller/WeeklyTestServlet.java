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

@WebServlet("/weeklytest")
public class WeeklyTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final WeeklyTestDAO testDAO = new WeeklyTestDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    // Check whether user is ADMIN or STAFF
    private boolean isAuthorized(HttpServletRequest req) {

        HttpSession session = req.getSession(false);

        if (session == null) {
            return false;
        }

        String role = (String) session.getAttribute("role");

        return "ADMIN".equals(role) ||
                "STAFF".equals(role);
    }

    // GET
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // Check login
        if (!isAuthorized(req)) {

            resp.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );

            return;
        }

        String action = req.getParameter("action");

        // DELETE
        if ("delete".equals(action)) {

            String idValue = req.getParameter("id");

            if (idValue != null &&
                    !idValue.trim().isEmpty()) {

                try {

                    int id = Integer.parseInt(idValue);

                    testDAO.deleteTest(id);

                } catch (NumberFormatException e) {

                    e.printStackTrace();
                }
            }

            resp.sendRedirect(
                    req.getContextPath() + "/weeklytest"
            );

            return;
        }

        // Load all tests
        req.setAttribute(
                "tests",
                testDAO.getAllTests()
        );

        // Load all students
        req.setAttribute(
                "students",
                studentDAO.getAllStudents()
        );

        // Open weekly test page
        req.getRequestDispatcher(
                "/admin/tests.jsp"
        ).forward(req, resp);
    }

    // POST
    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        // Check login
        if (!isAuthorized(req)) {

            resp.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );

            return;
        }

        String action = req.getParameter("action");

        WeeklyTest test = new WeeklyTest();

        test.setTestId(
                req.getParameter("testId")
        );

        test.setRegNo(
                req.getParameter("regNo")
        );

        test.setMarks(
                parseIntSafe(
                        req.getParameter("marks")
                )
        );

        // ADD
        if ("add".equals(action)) {

            testDAO.addTest(test);
        }

        // UPDATE
        else if ("update".equals(action)) {

            String idValue =
                    req.getParameter("id");

            if (idValue != null &&
                    !idValue.trim().isEmpty()) {

                try {

                    test.setId(
                            Integer.parseInt(idValue)
                    );

                    testDAO.updateTest(test);

                } catch (NumberFormatException e) {

                    e.printStackTrace();
                }
            }
        }

        // Invalid action
        else {

            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid weekly test action"
            );

            return;
        }

        // Reload page
        resp.sendRedirect(
                req.getContextPath() + "/weeklytest"
        );
    }

    // Convert String to int safely
    private int parseIntSafe(String value) {

        try {

            if (value == null ||
                    value.trim().isEmpty()) {

                return 0;
            }

            return Integer.parseInt(value);

        } catch (NumberFormatException e) {

            return 0;
        }
    }
}