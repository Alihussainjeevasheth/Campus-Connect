package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Student implements Serializable {
    private static final long serialVersionUID = 1L;

    private int studentId;
    private String name;
    private String email;
    private String password;
    private String enrollmentNo;
    private String department;
    private String semester;
    private Timestamp registeredAt;

    public Student() {
    }

    public Student(String name, String email, String password, String enrollmentNo, String department, String semester) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.enrollmentNo = enrollmentNo;
        this.department = department;
        this.semester = semester;
    }

    public Student(int studentId, String name, String email, String password, String enrollmentNo, String department, String semester, Timestamp registeredAt) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.enrollmentNo = enrollmentNo;
        this.department = department;
        this.semester = semester;
        this.registeredAt = registeredAt;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEnrollmentNo() {
        return enrollmentNo;
    }

    public void setEnrollmentNo(String enrollmentNo) {
        this.enrollmentNo = enrollmentNo;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public Timestamp getRegisteredAt() {
        return registeredAt;
    }

    public void setRegisteredAt(Timestamp registeredAt) {
        this.registeredAt = registeredAt;
    }
}
