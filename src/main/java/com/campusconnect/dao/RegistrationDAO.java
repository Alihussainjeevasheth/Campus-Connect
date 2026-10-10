package com.campusconnect.dao;

import com.campusconnect.model.Registration;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {

    public boolean registerStudentForEvent(int studentId, int eventId) throws Exception {
        if (isAlreadyRegistered(studentId, eventId)) {
            throw new IllegalStateException("You are already registered for this event.");
        }

        String sql = "INSERT INTO registrations (student_id, event_id, status) VALUES (?, ?, 'REGISTERED')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);
            stmt.setInt(2, eventId);

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean cancelRegistration(int registrationId, int studentId) {
        String sql = "UPDATE registrations SET status = 'CANCELLED' WHERE registration_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, registrationId);
            stmt.setInt(2, studentId);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isAlreadyRegistered(int studentId, int eventId) {
        String sql = "SELECT COUNT(*) FROM registrations WHERE student_id = ? AND event_id = ? AND status = 'REGISTERED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);
            stmt.setInt(2, eventId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Registration> getRegistrationsByStudentId(int studentId) {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.*, e.event_name, e.event_date, e.venue "
                   + "FROM registrations r "
                   + "JOIN events e ON r.event_id = e.event_id "
                   + "WHERE r.student_id = ? "
                   + "ORDER BY r.registration_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Registration reg = new Registration();
                    reg.setRegistrationId(rs.getInt("registration_id"));
                    reg.setStudentId(rs.getInt("student_id"));
                    reg.setEventId(rs.getInt("event_id"));
                    reg.setRegistrationDate(rs.getTimestamp("registration_date"));
                    reg.setStatus(rs.getString("status"));
                    reg.setEventName(rs.getString("event_name"));
                    reg.setEventDate(rs.getDate("event_date"));
                    reg.setVenue(rs.getString("venue"));
                    list.add(reg);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Registration> getAllRegistrations() {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.*, s.name AS student_name, s.email AS student_email, e.event_name, e.event_date, e.venue "
                   + "FROM registrations r "
                   + "JOIN students s ON r.student_id = s.student_id "
                   + "JOIN events e ON r.event_id = e.event_id "
                   + "ORDER BY r.registration_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationId(rs.getInt("registration_id"));
                reg.setStudentId(rs.getInt("student_id"));
                reg.setEventId(rs.getInt("event_id"));
                reg.setRegistrationDate(rs.getTimestamp("registration_date"));
                reg.setStatus(rs.getString("status"));
                reg.setStudentName(rs.getString("student_name"));
                reg.setStudentEmail(rs.getString("student_email"));
                reg.setEventName(rs.getString("event_name"));
                reg.setEventDate(rs.getDate("event_date"));
                reg.setVenue(rs.getString("venue"));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public long getTotalRegistrationsCount() {
        String sql = "SELECT COUNT(*) FROM registrations WHERE status = 'REGISTERED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) return rs.getLong(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
