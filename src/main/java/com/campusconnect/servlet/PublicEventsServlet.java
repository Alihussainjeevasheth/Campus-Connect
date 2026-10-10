package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.dao.RegistrationDAO;
import com.campusconnect.model.Event;
import com.campusconnect.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/events", "/event-details"})
public class PublicEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO = new EventDAO();
    private RegistrationDAO registrationDAO = new RegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();

        if ("/event-details".equals(path)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int eventId = Integer.parseInt(idStr.trim());
                    Event event = eventDAO.getEventById(eventId);

                    if (event != null) {
                        HttpSession session = request.getSession(false);
                        boolean isRegistered = false;
                        if (session != null && session.getAttribute("student") != null) {
                            Student student = (Student) session.getAttribute("student");
                            isRegistered = registrationDAO.isAlreadyRegistered(student.getStudentId(), eventId);
                        }

                        request.setAttribute("event", event);
                        request.setAttribute("isRegistered", isRegistered);
                        request.getRequestDispatcher("/event-details.jsp").forward(request, response);
                        return;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            request.setAttribute("errorMessage", "Event not found.");
            request.getRequestDispatcher("/events.jsp").forward(request, response);
        } else {
            // /events
            String search = request.getParameter("search");
            String category = request.getParameter("category");
            String status = request.getParameter("status");

            List<Event> events = eventDAO.searchAndFilterEvents(search, category, status);

            request.setAttribute("events", events);
            request.setAttribute("searchQuery", search != null ? search : "");
            request.setAttribute("selectedCategory", category != null ? category : "ALL");
            request.setAttribute("selectedStatus", status != null ? status : "ALL");

            request.getRequestDispatcher("/events.jsp").forward(request, response);
        }
    }
}
