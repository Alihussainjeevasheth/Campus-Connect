package com.campusconnect.servlet;

import com.campusconnect.dao.RegistrationDAO;
import com.campusconnect.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cancel-registration")
public class CancelRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        String regIdStr = request.getParameter("registrationId");

        if (regIdStr != null && !regIdStr.trim().isEmpty()) {
            try {
                int registrationId = Integer.parseInt(regIdStr.trim());
                registrationDAO.cancelRegistration(registrationId, student.getStudentId());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/my-registrations?msg=cancelled");
    }
}
