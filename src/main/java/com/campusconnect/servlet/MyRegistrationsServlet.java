package com.campusconnect.servlet;

import com.campusconnect.dao.RegistrationDAO;
import com.campusconnect.model.Registration;
import com.campusconnect.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-registrations")
public class MyRegistrationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        List<Registration> registrations = registrationDAO.getRegistrationsByStudentId(student.getStudentId());

        request.setAttribute("registrations", registrations);

        String msg = request.getParameter("msg");
        if ("registered".equals(msg)) {
            request.setAttribute("successMessage", "Registration for event successful!");
        } else if ("cancelled".equals(msg)) {
            request.setAttribute("successMessage", "Event registration cancelled.");
        }

        request.getRequestDispatcher("/my-registrations.jsp").forward(request, response);
    }
}
