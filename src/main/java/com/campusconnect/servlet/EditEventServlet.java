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

@WebServlet("/edit-event")
public class EditEventServlet extends HttpServlet {
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

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-events");
            return;
        }

        try {
            int eventId = Integer.parseInt(idStr.trim());
            Event event = eventDAO.getEventById(eventId);
            if (event != null) {
                request.setAttribute("event", event);
                request.getRequestDispatcher("/admin/edit-event.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-events");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manage-events");
        }
    }
}
