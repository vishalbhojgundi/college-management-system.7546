package com.college.dao;

import com.college.model.WeeklyTest;
import com.college.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WeeklyTestDAO {

    private static final String BASE_SELECT =
            "SELECT w.test_id, w.regNo, w.marks, s.name AS student_name " +
            "FROM weekly_test w JOIN student s ON w.regNo = s.regNo ";

    public List<WeeklyTest> getAllTests() {
        List<WeeklyTest> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY w.test_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** All weekly test results for a single student (used on parent search results). */
    public List<WeeklyTest> getTestsByRegNo(String regNo) {
        List<WeeklyTest> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE w.regNo = ? ORDER BY w.test_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, regNo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addTest(WeeklyTest t) {
        String sql = "INSERT INTO weekly_test (test_id, regNo, marks) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getTestId());
            ps.setString(2, t.getRegNo());
            ps.setInt(3, t.getMarks());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTest(WeeklyTest t) {
        String sql = "UPDATE weekly_test SET regNo = ?, marks = ? WHERE test_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getRegNo());
            ps.setInt(2, t.getMarks());
            ps.setString(3, t.getTestId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTest(String testId) {
        String sql = "DELETE FROM weekly_test WHERE test_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, testId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private WeeklyTest mapRow(ResultSet rs) throws SQLException {
        WeeklyTest t = new WeeklyTest();
        t.setTestId(rs.getString("test_id"));
        t.setRegNo(rs.getString("regNo"));
        t.setMarks(rs.getInt("marks"));
        t.setStudentName(rs.getString("student_name"));
        return t;
    }
}
