package com.campusconnect.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class Event implements Serializable {
    private static final long serialVersionUID = 1L;

    private int eventId;
    private String eventName;
    private String description;
    private String category;
    private String venue;
    private Date eventDate;
    private String eventTime;
    private String organizer;
    private int maxParticipants;
    private String status; // Upcoming, Completed, Cancelled
    private Timestamp createdAt;

    // Helper transient field
    private int registeredCount;

    public Event() {
    }

    public Event(String eventName, String description, String category, String venue, Date eventDate, 
                 String eventTime, String organizer, int maxParticipants, String status) {
        this.eventName = eventName;
        this.description = description;
        this.category = category;
        this.venue = venue;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.organizer = organizer;
        this.maxParticipants = maxParticipants;
        this.status = status;
    }

    public Event(int eventId, String eventName, String description, String category, String venue, 
                 Date eventDate, String eventTime, String organizer, int maxParticipants, String status, Timestamp createdAt) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.description = description;
        this.category = category;
        this.venue = venue;
        this.eventDate = eventDate;
        this.eventTime = eventTime;
        this.organizer = organizer;
        this.maxParticipants = maxParticipants;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public Date getEventDate() {
        return eventDate;
    }

    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    public String getOrganizer() {
        return organizer;
    }

    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(int maxParticipants) {
        this.maxParticipants = maxParticipants;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getRegisteredCount() {
        return registeredCount;
    }

    public void setRegisteredCount(int registeredCount) {
        this.registeredCount = registeredCount;
    }

    public int getAvailableSeats() {
        return Math.max(0, maxParticipants - registeredCount);
    }
}
