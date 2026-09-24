package com.college.dao;

import com.college.model.Student;
import com.college.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    private static final String BASE_SELECT =
            "SELECT s.regNo, s.name, s.class, s.course_id, s.gender, s.villege, " +
            "s.pincode, s.state, c.course_name " +
            "FROM student s LEFT JOIN course c ON s.course_id = c.course_id ";

    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY s.name";

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

    public Student getStudentByRegNo(String regNo) {
        String sql = BASE_SELECT + "WHERE s.regNo = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, regNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /** Search by regNo or name (used by parents / admin / staff). */
    public List<Student> searchStudents(String keyword) {
        List<Student> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE s.regNo LIKE ? OR s.name LIKE ? ORDER BY s.name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String like = "%" + keyword + "%";
            ps.setString(1, like);
            ps.setString(2, like);
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

    public boolean addStudent(Student s) {
        String sql = "INSERT INTO student (regNo, name, class, course_id, gender, villege, pincode, state) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            bindStudent(ps, s);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStudent(Student s) {
        String sql = "UPDATE student SET name=?, class=?, course_id=?, gender=?, villege=?, pincode=?, state=? " +
                     "WHERE regNo=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setInt(2, s.getClassNo());
            ps.setString(3, s.getCourseId());
            ps.setString(4, s.getGender());
            ps.setString(5, s.getVillege());
            ps.setInt(6, s.getPincode());
            ps.setString(7, s.getState());
            ps.setString(8, s.getRegNo());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteStudent(String regNo) {
        String sql = "DELETE FROM student WHERE regNo = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, regNo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void bindStudent(PreparedStatement ps, Student s) throws SQLException {
        ps.setString(1, s.getRegNo());
        ps.setString(2, s.getName());
        ps.setInt(3, s.getClassNo());
        ps.setString(4, s.getCourseId());
        ps.setString(5, s.getGender());
        ps.setString(6, s.getVillege());
        ps.setInt(7, s.getPincode());
        ps.setString(8, s.getState());
    }

    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setRegNo(rs.getString("regNo"));
        s.setName(rs.getString("name"));
        s.setClassNo(rs.getInt("class"));
        s.setCourseId(rs.getString("course_id"));
        s.setGender(rs.getString("gender"));
        s.setVillege(rs.getString("villege"));
        s.setPincode(rs.getInt("pincode"));
        s.setState(rs.getString("state"));
        s.setCourseName(rs.getString("course_name"));
        return s;
    }
}
