
package com.college.dao;

import com.college.model.WeeklyTest;
import com.college.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class WeeklyTestDAO {

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
                test.setStudentName(rs.getString("student_name"));
                test.setClassNo(rs.getInt("class_no"));
                tests.add(test);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tests;
    }

    public List<WeeklyTest> getTestsByRegNo(String regNo) {
        List<WeeklyTest> tests = new ArrayList<>();

        String sql =
                "SELECT w.id, w.test_id, w.regNo, w.marks, " +
                        "s.name AS student_name, s.class AS class_no " +
                        "FROM weekly_test w " +
                        "JOIN student s ON w.regNo = s.regNo " +
                        "WHERE w.regNo = ? ORDER BY w.test_id";

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
                    test.setStudentName(rs.getString("student_name"));
                    test.setClassNo(rs.getInt("class_no"));
                    tests.add(test);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tests;
    }

    public boolean addTest(WeeklyTest test) {
        String sql =
                "INSERT INTO weekly_test (test_id, regNo, marks) " +
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

    public boolean updateTest(WeeklyTest test) {
        String sql =
                "UPDATE weekly_test SET test_id = ?, regNo = ?, marks = ? " +
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

    public boolean deleteTest(int id) {
        String sql = "DELETE FROM weekly_test WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /*
     * Save marks for multiple students in one transaction.
     * Existing records for the same test and student are updated.
     * New records are inserted.
     */
    public boolean saveBulkMarks(
            String testId,
            int classNo,
            Map<String, Integer> marksByRegNo) {

        if (testId == null || testId.trim().isEmpty()
                || classNo < 7 || classNo > 10
                || marksByRegNo == null || marksByRegNo.isEmpty()) {
            return false;
        }

        String classSql =
                "SELECT class FROM student WHERE regNo = ?";

        String findSql =
                "SELECT id FROM weekly_test " +
                        "WHERE test_id = ? AND regNo = ? LIMIT 1";

        String updateSql =
                "UPDATE weekly_test SET marks = ? WHERE id = ?";

        String insertSql =
                "INSERT INTO weekly_test (test_id, regNo, marks) " +
                        "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try (PreparedStatement classPs = con.prepareStatement(classSql);
                 PreparedStatement findPs = con.prepareStatement(findSql);
                 PreparedStatement updatePs = con.prepareStatement(updateSql);
                 PreparedStatement insertPs = con.prepareStatement(insertSql)) {

                for (Map.Entry<String, Integer> entry
                        : marksByRegNo.entrySet()) {

                    String regNo = entry.getKey();
                    Integer marks = entry.getValue();

                    if (regNo == null || marks == null
                            || marks < 0 || marks > 100) {
                        throw new SQLException("Invalid student marks.");
                    }

                    // Verify the student belongs to the selected class.
                    classPs.setString(1, regNo);

                    try (ResultSet rs = classPs.executeQuery()) {
                        if (!rs.next() || rs.getInt("class") != classNo) {
                            throw new SQLException(
                                    "Student does not belong to selected class: "
                                            + regNo);
                        }
                    }

                    // Find an existing result for this test and student.
                    findPs.setString(1, testId);
                    findPs.setString(2, regNo);

                    Integer existingId = null;

                    try (ResultSet rs = findPs.executeQuery()) {
                        if (rs.next()) {
                            existingId = rs.getInt("id");
                        }
                    }

                    if (existingId != null) {
                        updatePs.setInt(1, marks);
                        updatePs.setInt(2, existingId);
                        updatePs.executeUpdate();
                    } else {
                        insertPs.setString(1, testId);
                        insertPs.setString(2, regNo);
                        insertPs.setInt(3, marks);
                        insertPs.executeUpdate();
                    }
                }

                con.commit();
                return true;

            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                return false;
            } finally {
                con.setAutoCommit(true);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
