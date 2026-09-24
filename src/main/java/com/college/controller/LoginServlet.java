package com.college.controller;

import com.college.dao.UserDAO;
import com.college.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.authenticate(username, password);

        if (user == null) {
            req.setAttribute("error", "Invalid username or password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());

        switch (user.getRole()) {

            case "ADMIN":
                resp.sendRedirect(
                        req.getContextPath() + "/admin/dashboard.jsp"
                );
                break;

            case "STAFF":
                resp.sendRedirect(
                        req.getContextPath() + "/staff/dashboard.jsp"
                );
                break;

            default:
                /*
                 * Parent login is no longer supported.
                 */
                resp.sendRedirect(
                        req.getContextPath() + "/login.jsp"
                );
                break;
        }
    }
}
