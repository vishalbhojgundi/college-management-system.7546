package com.college.dao;

import com.college.model.User;
import com.college.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * Validate username and password.
     */
    public User authenticate(String username, String password) {

        String sql = "SELECT user_id, username, password, role " +
                "FROM users " +
                "WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    User user = new User();

                    user.setUserId(
                            rs.getInt("user_id")
                    );

                    user.setUsername(
                            rs.getString("username")
                    );

                    user.setPassword(
                            rs.getString("password")
                    );

                    user.setRole(
                            rs.getString("role")
                    );

                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * Add a new STAFF account.
     */
    public boolean addStaff(String username, String password) {

        String sql =
                "INSERT INTO users (username, password, role) " +
                        "VALUES (?, ?, 'STAFF')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

            return false;
        }
    }


    /**
     * Get all STAFF accounts.
     */
    public List<User> getAllStaff() {

        List<User> staffList = new ArrayList<>();

        String sql =
                "SELECT user_id, username, password, role " +
                        "FROM users " +
                        "WHERE role = 'STAFF' " +
                        "ORDER BY username ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                User user = new User();

                user.setUserId(
                        rs.getInt("user_id")
                );

                user.setUsername(
                        rs.getString("username")
                );

                user.setPassword(
                        rs.getString("password")
                );

                user.setRole(
                        rs.getString("role")
                );

                staffList.add(user);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return staffList;
    }


    /**
     * Delete a STAFF account.
     */
    public boolean deleteStaff(int userId) {

        String sql =
                "DELETE FROM users " +
                        "WHERE user_id = ? AND role = 'STAFF'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

            return false;
        }
    }
}