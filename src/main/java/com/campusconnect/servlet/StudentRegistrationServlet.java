package com.campusconnect.servlet;

import com.campusconnect.dao.StudentDAO;
import com.campusconnect.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-register")
public class StudentRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("student") != null) {
            response.sendRedirect(request.getContextPath() + "/student-dashboard");
            return;
        }
        request.getRequestDispatcher("/student-register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String enrollmentNo = request.getParameter("enrollmentNo");
        String department = request.getParameter("department");
        String semester = request.getParameter("semester");

        // Basic Frontend / Backend Validations
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            enrollmentNo == null || enrollmentNo.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All required fields must be filled out.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (studentDAO.getStudentByEmail(email) != null) {
            request.setAttribute("errorMessage", "Email is already registered. Please login.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (studentDAO.getStudentByEnrollment(enrollmentNo) != null) {
            request.setAttribute("errorMessage", "Enrollment Number is already registered.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        try {
            Student student = new Student(name, email, password, enrollmentNo, department, semester);
            boolean success = studentDAO.registerStudent(student);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/student-login?registered=true");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration error: " + e.getMessage());
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
        }
    }
}
