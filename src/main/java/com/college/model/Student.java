package com.college.model;

public class Student {
    private String regNo;
    private String name;
    private int classNo;
    private String courseId;
    private String gender;
    private String villege;
    private int pincode;
    private String state;

    // Extra field, populated by JOIN with course table (not a DB column)
    private String courseName;

    public Student() {
    }

    public Student(String regNo, String name, int classNo, String courseId,
                   String gender, String villege, int pincode, String state) {
        this.regNo = regNo;
        this.name = name;
        this.classNo = classNo;
        this.courseId = courseId;
        this.gender = gender;
        this.villege = villege;
        this.pincode = pincode;
        this.state = state;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getClassNo() {
        return classNo;
    }

    public void setClassNo(int classNo) {
        this.classNo = classNo;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getVillege() {
        return villege;
    }

    public void setVillege(String villege) {
        this.villege = villege;
    }

    public int getPincode() {
        return pincode;
    }

    public void setPincode(int pincode) {
        this.pincode = pincode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
}
