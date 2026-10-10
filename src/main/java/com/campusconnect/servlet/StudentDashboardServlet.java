package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.dao.RegistrationDAO;
import com.campusconnect.model.Event;
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

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO = new EventDAO();
    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login");
            return;
        }

        Student currentStudent = (Student) session.getAttribute("student");
        
        List<Registration> myRegistrations = registrationDAO.getRegistrationsByStudentId(currentStudent.getStudentId());
        List<Event> upcomingEvents = eventDAO.getUpcomingEvents();

        request.setAttribute("student", currentStudent);
        request.setAttribute("myRegistrations", myRegistrations);
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("registeredCount", myRegistrations.size());
        request.setAttribute("availableEventsCount", upcomingEvents.size());

        request.getRequestDispatcher("/student-dashboard.jsp").forward(request, response);
    }
}
