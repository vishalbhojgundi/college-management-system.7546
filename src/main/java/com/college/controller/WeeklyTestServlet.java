
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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/weeklytest")
public class WeeklyTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final WeeklyTestDAO testDAO = new WeeklyTestDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    private boolean isAuthorized(HttpServletRequest req) {
        HttpSession session = req.getSession(false);

        if (session == null) {
            return false;
        }

        String role = (String) session.getAttribute("role");

        return "ADMIN".equals(role) || "STAFF".equals(role);
    }

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAuthorized(req)) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            String idValue = req.getParameter("id");

            try {
                if (idValue != null && !idValue.trim().isEmpty()) {
                    testDAO.deleteTest(Integer.parseInt(idValue));
                }
            } catch (NumberFormatException e) {
                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid test record ID"
                );
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/weeklytest");
            return;
        }

        // Load the test records and student list.
        req.setAttribute("tests", testDAO.getAllTests());

        List<Student> students = studentDAO.getAllStudents();
        req.setAttribute("students", students);

        // Preserve the selected class and test name after filtering.
        req.setAttribute("selectedClass", req.getParameter("classNo"));
        req.setAttribute("testId", req.getParameter("testId"));

        req.getRequestDispatcher("/admin/tests.jsp")
                .forward(req, resp);
    }

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

        if ("bulkSave".equals(action)) {
            saveBulkMarks(req, resp);
            return;
        }

        // Preserve existing single-record add and update actions.
        WeeklyTest test = new WeeklyTest();

        test.setTestId(req.getParameter("testId"));
        test.setRegNo(req.getParameter("regNo"));

        int marks = parseIntSafe(req.getParameter("marks"));

        if (marks < 0 || marks > 100) {
            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Marks must be between 0 and 100"
            );
            return;
        }

        test.setMarks(marks);

        if ("add".equals(action)) {
            testDAO.addTest(test);

        } else if ("update".equals(action)) {
            String idValue = req.getParameter("id");

            try {
                test.setId(Integer.parseInt(idValue));
                testDAO.updateTest(test);
            } catch (NumberFormatException e) {
                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid test record ID"
                );
                return;
            }

        } else {
            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid weekly test action"
            );
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/weeklytest");
    }

    private void saveBulkMarks(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException {

        String testId = req.getParameter("testId");
        String classValue = req.getParameter("classNo");

        int classNo;

        try {
            classNo = Integer.parseInt(classValue);
        } catch (NumberFormatException e) {
            resp.sendRedirect(
                    req.getContextPath()
                            + "/weeklytest?status=invalidClass"
            );
            return;
        }

        if (testId == null || testId.trim().isEmpty()
                || testId.trim().length() > 20
                || classNo < 7 || classNo > 10) {

            resp.sendRedirect(
                    req.getContextPath()
                            + "/weeklytest?status=invalidInput"
            );
            return;
        }

        String[] regNos = req.getParameterValues("regNos");

        if (regNos == null || regNos.length == 0) {
            resp.sendRedirect(
                    req.getContextPath()
                            + "/weeklytest?status=noStudents"
            );
            return;
        }

        Map<String, Integer> marksByRegNo = new LinkedHashMap<>();

        try {
            for (String regNo : regNos) {
                if (regNo == null || regNo.trim().isEmpty()) {
                    continue;
                }

                String value = req.getParameter("marks_" + regNo);

                // Blank marks are skipped; other entered marks are saved.
                if (value == null || value.trim().isEmpty()) {
                    continue;
                }

                int mark = Integer.parseInt(value.trim());

                if (mark < 0 || mark > 100) {
                    resp.sendRedirect(
                            req.getContextPath()
                                    + "/weeklytest?status=invalidMarks"
                    );
                    return;
                }

                marksByRegNo.put(regNo, mark);
            }

        } catch (NumberFormatException e) {
            resp.sendRedirect(
                    req.getContextPath()
                            + "/weeklytest?status=invalidMarks"
            );
            return;
        }

        if (marksByRegNo.isEmpty()) {
            resp.sendRedirect(
                    req.getContextPath()
                            + "/weeklytest?status=noMarks"
            );
            return;
        }

        boolean saved = testDAO.saveBulkMarks(
                testId.trim(),
                classNo,
                marksByRegNo
        );

        String status = saved ? "saved" : "saveFailed";

        resp.sendRedirect(
                req.getContextPath()
                        + "/weeklytest?status=" + status
                        + "&classNo=" + classNo
                        + "&testId=" + java.net.URLEncoder.encode(
                        testId.trim(),
                        java.nio.charset.StandardCharsets.UTF_8
                )
        );
    }

    private int parseIntSafe(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
