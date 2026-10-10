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

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {
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

        String registered = request.getParameter("registered");
        if ("true".equals(registered)) {
            request.setAttribute("successMessage", "Registration successful! Please log in with your credentials.");
        }

        request.getRequestDispatcher("/student-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and Password are required.");
            request.getRequestDispatcher("/student-login.jsp").forward(request, response);
            return;
        }

        Student student = studentDAO.authenticate(email, password);

        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student);
            session.setAttribute("role", "STUDENT");
            response.sendRedirect(request.getContextPath() + "/student-dashboard");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("/student-login.jsp").forward(request, response);
        }
    }
}
