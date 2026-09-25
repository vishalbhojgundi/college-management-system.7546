package com.college.dao;

import com.college.model.WeeklyTest;
import com.college.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WeeklyTestDAO {

    // Get all weekly test records
    public List<WeeklyTest> getAllTests() {

        List<WeeklyTest> tests = new ArrayList<>();

        String sql =
                "SELECT w.id, w.test_id, w.regNo, w.marks, " +
                        "s.name AS student_name, s.class AS class_no " +
                        "FROM weekly_test w " +
                        "JOIN student s ON w.regNo = s.regNo " +
                        "ORDER BY s.class, w.test_id, s.name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                WeeklyTest test = new WeeklyTest();

                test.setId(rs.getInt("id"));
                test.setTestId(rs.getString("test_id"));
                test.setRegNo(rs.getString("regNo"));
                test.setMarks(rs.getInt("marks"));

                test.setStudentName(
                        rs.getString("student_name")
                );

                test.setClassNo(
                        rs.getInt("class_no")
                );

                tests.add(test);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tests;
    }


    // Get tests for one student
    public List<WeeklyTest> getTestsByRegNo(String regNo) {

        List<WeeklyTest> tests = new ArrayList<>();

        String sql =
                "SELECT w.id, w.test_id, w.regNo, w.marks, " +
                        "s.name AS student_name, s.class AS class_no " +
                        "FROM weekly_test w " +
                        "JOIN student s ON w.regNo = s.regNo " +
                        "WHERE w.regNo = ? " +
                        "ORDER BY w.test_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, regNo);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    WeeklyTest test = new WeeklyTest();

                    test.setId(rs.getInt("id"));
                    test.setTestId(rs.getString("test_id"));
                    test.setRegNo(rs.getString("regNo"));
                    test.setMarks(rs.getInt("marks"));

                    test.setStudentName(
                            rs.getString("student_name")
                    );

                    test.setClassNo(
                            rs.getInt("class_no")
                    );

                    tests.add(test);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tests;
    }


    // Add test
    public boolean addTest(WeeklyTest test) {

        String sql =
                "INSERT INTO weekly_test " +
                        "(test_id, regNo, marks) " +
                        "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, test.getTestId());
            ps.setString(2, test.getRegNo());
            ps.setInt(3, test.getMarks());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Update test
    public boolean updateTest(WeeklyTest test) {

        String sql =
                "UPDATE weekly_test " +
                        "SET test_id = ?, regNo = ?, marks = ? " +
                        "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, test.getTestId());
            ps.setString(2, test.getRegNo());
            ps.setInt(3, test.getMarks());
            ps.setInt(4, test.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // Delete test
    public boolean deleteTest(int id) {

        String sql =
                "DELETE FROM weekly_test WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}