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

@WebServlet("/register-event")
public class EventRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RegistrationDAO registrationDAO = new RegistrationDAO();
    private EventDAO eventDAO = new EventDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            response.sendRedirect(request.getContextPath() + "/student-login?error=auth_required");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        String eventIdStr = request.getParameter("eventId");

        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/events");
            return;
        }

        try {
            int eventId = Integer.parseInt(eventIdStr.trim());
            Event event = eventDAO.getEventById(eventId);

            if (event == null) {
                request.setAttribute("errorMessage", "Event not found.");
                request.getRequestDispatcher("/events.jsp").forward(request, response);
                return;
            }

            if ("Cancelled".equalsIgnoreCase(event.getStatus()) || "Completed".equalsIgnoreCase(event.getStatus())) {
                request.setAttribute("errorMessage", "Registration is closed for this event.");
                request.getRequestDispatcher("/event-details.jsp").forward(request, response);
                return;
            }

            if (event.getAvailableSeats() <= 0) {
                request.setAttribute("errorMessage", "Registration Full! No seats remaining.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("/event-details.jsp").forward(request, response);
                return;
            }

            boolean registered = registrationDAO.registerStudentForEvent(student.getStudentId(), eventId);

            if (registered) {
                response.sendRedirect(request.getContextPath() + "/my-registrations?msg=registered");
            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("/event-details.jsp").forward(request, response);
            }
        } catch (IllegalStateException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/event-details?id=" + eventIdStr).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration error: " + e.getMessage());
            request.getRequestDispatcher("/events").forward(request, response);
        }
    }
}
