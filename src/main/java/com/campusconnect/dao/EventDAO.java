package com.campusconnect.dao;

import com.campusconnect.model.Event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public boolean addEvent(Event event) {
        String sql = "INSERT INTO events (event_name, description, category, venue, event_date, event_time, organizer, max_participants, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, event.getEventName());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getCategory());
            stmt.setString(4, event.getVenue());
            stmt.setDate(5, event.getEventDate());
            stmt.setString(6, event.getEventTime());
            stmt.setString(7, event.getOrganizer());
            stmt.setInt(8, event.getMaxParticipants());
            stmt.setString(9, event.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEvent(Event event) {
        String sql = "UPDATE events SET event_name = ?, description = ?, category = ?, venue = ?, "
                   + "event_date = ?, event_time = ?, organizer = ?, max_participants = ?, status = ? "
                   + "WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, event.getEventName());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getCategory());
            stmt.setString(4, event.getVenue());
            stmt.setDate(5, event.getEventDate());
            stmt.setString(6, event.getEventTime());
            stmt.setString(7, event.getOrganizer());
            stmt.setInt(8, event.getMaxParticipants());
            stmt.setString(9, event.getStatus());
            stmt.setInt(10, event.getEventId());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteEvent(int eventId) {
        String sql = "DELETE FROM events WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Event getEventById(int eventId) {
        String sql = "SELECT * FROM events WHERE event_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Event event = mapEvent(rs);
                    event.setRegisteredCount(getRegisteredCountForEvent(eventId));
                    return event;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY event_date DESC, event_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = mapEvent(rs);
                event.setRegisteredCount(getRegisteredCountForEvent(event.getEventId()));
                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> getUpcomingEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events WHERE status = 'Upcoming' ORDER BY event_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = mapEvent(rs);
                event.setRegisteredCount(getRegisteredCountForEvent(event.getEventId()));
                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<Event> searchAndFilterEvents(String search, String category, String status) {
        List<Event> events = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM events WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            sql.append(" AND (LOWER(event_name) LIKE ? OR LOWER(description) LIKE ? OR LOWER(venue) LIKE ? OR LOWER(organizer) LIKE ?)");
        }
        if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
            sql.append(" AND category = ?");
        }
        if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
            sql.append(" AND status = ?");
        }

        sql.append(" ORDER BY event_date ASC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                String kw = "%" + search.trim().toLowerCase() + "%";
                stmt.setString(paramIndex++, kw);
                stmt.setString(paramIndex++, kw);
                stmt.setString(paramIndex++, kw);
                stmt.setString(paramIndex++, kw);
            }
            if (category != null && !category.trim().isEmpty() && !"ALL".equalsIgnoreCase(category)) {
                stmt.setString(paramIndex++, category.trim());
            }
            if (status != null && !status.trim().isEmpty() && !"ALL".equalsIgnoreCase(status)) {
                stmt.setString(paramIndex++, status.trim());
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Event event = mapEvent(rs);
                    event.setRegisteredCount(getRegisteredCountForEvent(event.getEventId()));
                    events.add(event);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public long getTotalEventsCount() {
        String sql = "SELECT COUNT(*) FROM events";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getLong(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public long getEventsCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM events WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getLong(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int getRegisteredCountForEvent(int eventId) {
        String sql = "SELECT COUNT(*) FROM registrations WHERE event_id = ? AND status = 'REGISTERED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Event mapEvent(ResultSet rs) throws Exception {
        Event e = new Event();
        e.setEventId(rs.getInt("event_id"));
        e.setEventName(rs.getString("event_name"));
        e.setDescription(rs.getString("description"));
        e.setCategory(rs.getString("category"));
        e.setVenue(rs.getString("venue"));
        e.setEventDate(rs.getDate("event_date"));
        e.setEventTime(rs.getString("event_time"));
        e.setOrganizer(rs.getString("organizer"));
        e.setMaxParticipants(rs.getInt("max_participants"));
        e.setStatus(rs.getString("status"));
        e.setCreatedAt(rs.getTimestamp("created_at"));
        return e;
    }
}
