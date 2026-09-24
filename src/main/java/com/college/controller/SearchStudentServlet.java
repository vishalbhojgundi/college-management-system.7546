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

@WebServlet("/searchStudent")
public class SearchStudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final WeeklyTestDAO weeklyTestDAO = new WeeklyTestDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String regNo = request.getParameter("regNo");

        // If registration number is empty
        if (regNo == null || regNo.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/index.jsp"
            );

            return;
        }

        regNo = regNo.trim();

        // Find student
        Student student =
                studentDAO.getStudentByRegNo(regNo);

        request.setAttribute("student", student);

        // If student exists, get weekly tests
        if (student != null) {

            List<WeeklyTest> tests =
                    weeklyTestDAO.getTestsByRegNo(regNo);

            request.setAttribute("tests", tests);
        }

        // Send result to a NEW JSP PAGE
        request.getRequestDispatcher(
                "/student-result.jsp"
        ).forward(request, response);
    }
}