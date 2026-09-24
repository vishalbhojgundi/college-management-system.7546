package com.college.controller;

import com.college.dao.StudentDAO;
import com.college.dao.WeeklyTestDAO;
import com.college.model.Student;
import com.college.model.WeeklyTest;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Public student search.
 *
 * No login or authentication is required.
 *
 * Parents can use the Home page to search
 * their child's academic information using
 * the student's Registration Number.
 */
@WebServlet("/searchStudent")
public class SearchStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final StudentDAO studentDAO = new StudentDAO();
    private final WeeklyTestDAO testDAO = new WeeklyTestDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String regNo = req.getParameter("regNo");

        /*
         * If registration number is empty,
         * simply return to Home page.
         */
        if (regNo == null || regNo.trim().isEmpty()) {

            resp.sendRedirect(
                    req.getContextPath() + "/index.jsp"
            );

            return;
        }

        regNo = regNo.trim();

        /*
         * Find student by Registration Number.
         */
        Student student =
                studentDAO.getStudentByRegNo(regNo);

        /*
         * Send student information to Home page.
         */
        req.setAttribute(
                "student",
                student
        );

        /*
         * If student exists, load weekly test results.
         */
        if (student != null) {

            List<WeeklyTest> tests =
                    testDAO.getTestsByRegNo(regNo);

            req.setAttribute(
                    "tests",
                    tests
            );
        }

        /*
         * Show the result directly on Home page.
         */
        req.getRequestDispatcher(
                "/index.jsp"
        ).forward(req, resp);
    }
}