package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.dao.RegistrationDAO;
import com.campusconnect.dao.StudentDAO;
import com.campusconnect.model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO = new EventDAO();
    private RegistrationDAO registrationDAO = new RegistrationDAO();
    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        long totalEvents = eventDAO.getTotalEventsCount();
        long upcomingEvents = eventDAO.getEventsCountByStatus("Upcoming");
        long completedEvents = eventDAO.getEventsCountByStatus("Completed");
        long totalRegistrations = registrationDAO.getTotalRegistrationsCount();
        long totalStudents = studentDAO.getTotalStudentsCount();

        List<Event> recentEvents = eventDAO.getAllEvents();
        if (recentEvents.size() > 5) {
            recentEvents = recentEvents.subList(0, 5);
        }

        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("upcomingEvents", upcomingEvents);
        request.setAttribute("completedEvents", completedEvents);
        request.setAttribute("totalRegistrations", totalRegistrations);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("recentEvents", recentEvents);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
