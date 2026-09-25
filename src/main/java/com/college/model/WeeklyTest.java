package com.college.model;

public class WeeklyTest {

    private int id;
    private String testId;
    private String regNo;
    private int marks;

    // Extra fields populated by JOIN
    private String studentName;
    private int classNo;

    public WeeklyTest() {
    }

    public WeeklyTest(int id, String testId, String regNo, int marks) {
        this.id = id;
        this.testId = testId;
        this.regNo = regNo;
        this.marks = marks;
    }

    // ID
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Test ID
    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    // Registration Number
    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    // Marks
    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    // Student Name
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    // Class
    public int getClassNo() {
        return classNo;
    }

    public void setClassNo(int classNo) {
        this.classNo = classNo;
    }
}