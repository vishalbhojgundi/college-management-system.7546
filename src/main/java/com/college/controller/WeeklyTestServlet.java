
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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
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

        // Delete one weekly-test record.
        if ("delete".equals(action)) {
            String idValue = req.getParameter("id");

            try {
                int id = Integer.parseInt(idValue);
                testDAO.deleteTest(id);

            } catch (NumberFormatException e) {
                resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid test record ID"
                );
                return;
            }

            String filterClass = req.getParameter("filterClass");

            if (filterClass != null && !filterClass.isEmpty()) {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/weeklytest?filterClass="
                                + URLEncoder.encode(
                                filterClass,
                                StandardCharsets.UTF_8
                        )
                );
            } else {
                resp.sendRedirect(req.getContextPath() + "/weeklytest");
            }

            return;
        }

        /*
         * Load every weekly-test record.
         * Do not filter by test name here.
         */
        List<WeeklyTest> allTests = testDAO.getAllTests();

        String filterClass = req.getParameter("filterClass");

        List<WeeklyTest> filteredTests = new ArrayList<>();

        for (WeeklyTest test : allTests) {

            boolean includeRecord =
                    filterClass == null
                            || filterClass.trim().isEmpty()
                            || "all".equals(filterClass)
                            || String.valueOf(test.getClassNo())
                            .equals(filterClass);

            if (includeRecord) {
                filteredTests.add(test);
            }
        }

        // All records are used when filling previously saved marks.
        req.setAttribute("allTests", allTests);

        // The table displays all tests belonging to the selected class.
        req.setAttribute("tests", filteredTests);

        req.setAttribute("filterClass", filterClass);

        // Load students for the bulk-entry form.
        List<Student> students = studentDAO.getAllStudents();
        req.setAttribute("students", students);

        // Preserve bulk-entry selections.
        req.setAttribute("selectedClass", req.getParameter("classNo"));
        req.setAttribute("testId", req.getParameter("testId"));

        // Display messages after saving marks.
        req.setAttribute("status", req.getParameter("status"));

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

        // Preserve the existing single-record actions.
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

            try {
                test.setId(
                        Integer.parseInt(req.getParameter("id"))
                );

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
                    "Invalid weekly-test action"
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
            redirectWithStatus(req, resp, "invalidClass", null, null);
            return;
        }

        if (testId == null
                || testId.trim().isEmpty()
                || testId.trim().length() > 20
                || classNo < 7
                || classNo > 10) {

            redirectWithStatus(req, resp, "invalidInput", null, null);
            return;
        }

        String[] regNos = req.getParameterValues("regNos");

        if (regNos == null || regNos.length == 0) {
            redirectWithStatus(req, resp, "noStudents", null, null);
            return;
        }

        Map<String, Integer> marksByRegNo = new LinkedHashMap<>();

        try {
            for (String regNo : regNos) {

                if (regNo == null || regNo.trim().isEmpty()) {
                    continue;
                }

                String value = req.getParameter("marks_" + regNo);

                // Skip blank fields.
                if (value == null || value.trim().isEmpty()) {
                    continue;
                }

                int mark = Integer.parseInt(value.trim());

                if (mark < 0 || mark > 100) {
                    redirectWithStatus(
                            req, resp, "invalidMarks", null, null
                    );
                    return;
                }

                marksByRegNo.put(regNo, mark);
            }

        } catch (NumberFormatException e) {
            redirectWithStatus(req, resp, "invalidMarks", null, null);
            return;
        }

        if (marksByRegNo.isEmpty()) {
            redirectWithStatus(req, resp, "noMarks", null, null);
            return;
        }

        boolean saved = testDAO.saveBulkMarks(
                testId.trim(),
                classNo,
                marksByRegNo
        );

        String status = saved ? "saved" : "saveFailed";

        redirectWithStatus(
                req,
                resp,
                status,
                classNo,
                testId.trim()
        );
    }

    private void redirectWithStatus(
            HttpServletRequest req,
            HttpServletResponse resp,
            String status,
            Integer classNo,
            String testId) throws IOException {

        StringBuilder url = new StringBuilder(
                req.getContextPath()
                        + "/weeklytest?status="
                        + URLEncoder.encode(
                        status,
                        StandardCharsets.UTF_8
                )
        );

        if (classNo != null) {
            url.append("&classNo=").append(classNo);
        }

        if (testId != null) {
            url.append("&testId=").append(
                    URLEncoder.encode(
                            testId,
                            StandardCharsets.UTF_8
                    )
            );
        }

        resp.sendRedirect(url.toString());
    }

    private int parseIntSafe(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
