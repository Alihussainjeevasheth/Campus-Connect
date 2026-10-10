package com.campusconnect.servlet;

import com.campusconnect.dao.EventDAO;
import com.campusconnect.model.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/add-event")
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        request.getRequestDispatcher("/admin/add-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        try {
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String venue = request.getParameter("venue");
            String eventDateStr = request.getParameter("eventDate");
            String eventTime = request.getParameter("eventTime");
            String organizer = request.getParameter("organizer");
            String maxParticipantsStr = request.getParameter("maxParticipants");
            String status = request.getParameter("status");

            if (eventName == null || eventName.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                venue == null || venue.trim().isEmpty() ||
                eventDateStr == null || eventDateStr.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "Please fill in all mandatory fields.");
                request.getRequestDispatcher("/admin/add-event.jsp").forward(request, response);
                return;
            }

            Date eventDate = Date.valueOf(eventDateStr.trim());
            int maxParticipants = Integer.parseInt(maxParticipantsStr.trim());

            Event event = new Event(eventName, description, category, venue, eventDate, eventTime, organizer, maxParticipants, status);
            
            boolean success = eventDAO.addEvent(event);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-events?msg=created");
            } else {
                request.setAttribute("errorMessage", "Failed to add event to database.");
                request.getRequestDispatcher("/admin/add-event.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            request.getRequestDispatcher("/admin/add-event.jsp").forward(request, response);
        }
    }
}
