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
import java.util.List;

@WebServlet("/manage-events")
public class ManageEventsServlet extends HttpServlet {
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

        List<Event> events = eventDAO.getAllEvents();
        request.setAttribute("events", events);

        String msg = request.getParameter("msg");
        if ("created".equals(msg)) {
            request.setAttribute("successMessage", "Event added successfully.");
        } else if ("updated".equals(msg)) {
            request.setAttribute("successMessage", "Event updated successfully.");
        } else if ("deleted".equals(msg)) {
            request.setAttribute("successMessage", "Event deleted successfully.");
        }

        request.getRequestDispatcher("/admin/manage-events.jsp").forward(request, response);
    }
}
