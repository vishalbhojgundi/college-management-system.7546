package com.college.model;

public class WeeklyTest {
    private String testId;
    private String regNo;
    private int marks;

    // Extra field populated by JOIN with student table (not a DB column)
    private String studentName;

    public WeeklyTest() {
    }

    public WeeklyTest(String testId, String regNo, int marks) {
        this.testId = testId;
        this.regNo = regNo;
        this.marks = marks;
    }

    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}
