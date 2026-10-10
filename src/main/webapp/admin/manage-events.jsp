<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Manage Events - Admin Portal" />
<c:set var="activePage" value="admin" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <!-- PAGE HEADER -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-primary text-white fw-bold px-3 py-2 rounded-pill mb-1">Event CRUD Module</span>
                <h2 class="fw-bold text-dark mb-0">Event Management System</h2>
            </div>
            <a href="${pageContext.request.contextPath}/add-event" class="btn btn-primary btn-lg fw-semibold shadow-sm">
                <i class="fa-solid fa-square-plus me-1"></i> Add New Event
            </a>
        </div>

        <!-- ALERTS -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- CRUD EVENTS TABLE (READ OPERATION) -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 px-4 d-flex justify-content-between align-items-center border-bottom">
                <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-database me-2 text-primary"></i> Events Table (Fetched from MySQL via JDBC)</h5>
                <span class="badge bg-light text-dark border">Total Records: ${events.size()}</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 custom-table">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Event Name</th>
                            <th>Category</th>
                            <th>Venue</th>
                            <th>Date & Time</th>
                            <th>Organizer</th>
                            <th>Seats</th>
                            <th>Status</th>
                            <th class="pe-4 text-end">Actions (CRUD)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty events}">
                                <c:forEach var="event" items="${events}">
                                    <tr>
                                        <td class="ps-4 fw-bold text-muted">#${event.eventId}</td>
                                        <td>
                                            <div class="fw-bold text-dark">${event.eventName}</div>
                                            <div class="small text-muted text-truncate" style="max-width: 220px;">${event.description}</div>
                                        </td>
                                        <td><span class="badge bg-light text-dark border">${event.category}</span></td>
                                        <td class="small text-muted"><i class="fa-solid fa-location-dot me-1 text-primary"></i> ${event.venue}</td>
                                        <td class="small">
                                            <div class="fw-semibold text-dark">${event.eventDate}</div>
                                            <div class="text-muted">${event.eventTime}</div>
                                        </td>
                                        <td class="small text-muted">${event.organizer}</td>
                                        <td class="small font-weight-semibold">
                                            <span class="${event.availableSeats > 0 ? 'text-success' : 'text-danger'}">
                                                ${event.registeredCount} / ${event.maxParticipants}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge ${event.status == 'Upcoming' ? 'bg-success' : (event.status == 'Completed' ? 'bg-secondary' : 'bg-danger')}">
                                                ${event.status}
                                            </span>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <div class="d-flex justify-content-end gap-2">
                                                <!-- UPDATE BUTTON -->
                                                <a href="${pageContext.request.contextPath}/edit-event?id=${event.eventId}" 
                                                   class="btn btn-sm btn-outline-primary fw-semibold" title="Edit Event">
                                                    <i class="fa-solid fa-pen-to-square me-1"></i> Edit
                                                </a>
                                                
                                                <!-- DELETE BUTTON -->
                                                <a href="${pageContext.request.contextPath}/delete-event?id=${event.eventId}" 
                                                   onclick="return confirmDelete('${event.eventName}');" 
                                                   class="btn btn-sm btn-outline-danger fw-semibold" title="Delete Event">
                                                    <i class="fa-solid fa-trash-can me-1"></i> Delete
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center py-5 text-muted">
                                        <i class="fa-solid fa-folder-open fa-3x mb-3 text-secondary"></i>
                                        <h5>No Events Found in Database</h5>
                                        <p class="mb-3">Click the "Add New Event" button above to create your first event record.</p>
                                        <a href="${pageContext.request.contextPath}/add-event" class="btn btn-primary fw-semibold">Add New Event</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
