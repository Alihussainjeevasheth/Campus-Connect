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

@WebServlet("/update-event")
public class UpdateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String venue = request.getParameter("venue");
            String eventDateStr = request.getParameter("eventDate");
            String eventTime = request.getParameter("eventTime");
            String organizer = request.getParameter("organizer");
            int maxParticipants = Integer.parseInt(request.getParameter("maxParticipants"));
            String status = request.getParameter("status");

            Date eventDate = Date.valueOf(eventDateStr.trim());

            Event event = new Event();
            event.setEventId(eventId);
            event.setEventName(eventName);
            event.setDescription(description);
            event.setCategory(category);
            event.setVenue(venue);
            event.setEventDate(eventDate);
            event.setEventTime(eventTime);
            event.setOrganizer(organizer);
            event.setMaxParticipants(maxParticipants);
            event.setStatus(status);

            boolean success = eventDAO.updateEvent(event);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-events?msg=updated");
            } else {
                request.setAttribute("errorMessage", "Failed to update event.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("/admin/edit-event.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating event: " + e.getMessage());
            request.getRequestDispatcher("/admin/edit-event.jsp").forward(request, response);
        }
    }
}
