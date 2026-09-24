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

/**
 * Admin-only Staff Management.
 *
 * Admin can:
 * 1. View staff
 * 2. Add staff
 * 3. Delete staff
 */
@WebServlet("/staff-management")
public class StaffServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();


    /**
     * Check whether logged-in user is ADMIN.
     */
    private boolean isAdmin(HttpServletRequest req) {

        HttpSession session = req.getSession(false);

        if (session == null) {
            return false;
        }

        String role = (String) session.getAttribute("role");

        return "ADMIN".equals(role);
    }


    /**
     * GET
     *
     * /staff-management
     *          -> Show all staff
     *
     * /staff-management?action=delete&userId=5
     *          -> Delete staff
     */
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req)) {

            resp.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );

            return;
        }


        String action = req.getParameter("action");


        /*
         * DELETE STAFF
         */
        if ("delete".equals(action)) {

            String userIdValue =
                    req.getParameter("userId");

            try {

                int userId =
                        Integer.parseInt(userIdValue);

                userDAO.deleteStaff(userId);

            } catch (Exception e) {

                e.printStackTrace();
            }


            resp.sendRedirect(
                    req.getContextPath() +
                            "/staff-management"
            );

            return;
        }


        /*
         * LOAD STAFF
         */
        req.setAttribute(
                "staffList",
                userDAO.getAllStaff()
        );


        /*
         * OPEN STAFF MANAGEMENT PAGE
         */
        req.getRequestDispatcher(
                "/admin/staff.jsp"
        ).forward(req, resp);
    }


    /**
     * POST
     *
     * Add new STAFF account.
     */
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req)) {

            resp.sendRedirect(
                    req.getContextPath() + "/login.jsp"
            );

            return;
        }


        String username =
                req.getParameter("username");

        String password =
                req.getParameter("password");


        /*
         * Validate input.
         */
        if (username == null ||
                username.trim().isEmpty() ||
                password == null ||
                password.trim().isEmpty()) {

            req.setAttribute(
                    "error",
                    "Username and password are required."
            );

            req.setAttribute(
                    "staffList",
                    userDAO.getAllStaff()
            );

            req.getRequestDispatcher(
                    "/admin/staff.jsp"
            ).forward(req, resp);

            return;
        }


        username = username.trim();


        /*
         * Add staff.
         */
        boolean success =
                userDAO.addStaff(
                        username,
                        password
                );


        if (success) {

            resp.sendRedirect(
                    req.getContextPath() +
                            "/staff-management"
            );

        } else {

            req.setAttribute(
                    "error",
                    "Unable to add staff. Username may already exist."
            );

            req.setAttribute(
                    "staffList",
                    userDAO.getAllStaff()
            );

            req.getRequestDispatcher(
                    "/admin/staff.jsp"
            ).forward(req, resp);
        }
    }
}