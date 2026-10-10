<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Edit Event #${event.eventId} - Admin Portal" />
<c:set var="activePage" value="admin" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <a href="${pageContext.request.contextPath}/manage-events" class="btn btn-outline-secondary mb-4">
                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Event List
                </a>

                <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5">
                    <div class="d-flex align-items-center mb-4">
                        <div class="stat-icon bg-warning-subtle text-warning me-3">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </div>
                        <div>
                            <h3 class="fw-bold text-dark mb-0">Update Event Information</h3>
                            <p class="text-muted small mb-0">JSP Form → UpdateEventServlet → JDBC PreparedStatement → MySQL UPDATE</p>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/update-event" method="post">
                        <input type="hidden" name="eventId" value="${event.eventId}">

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Event Name <span class="text-danger">*</span></label>
                            <input type="text" name="eventName" class="form-control py-2" required value="${event.eventName}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Description <span class="text-danger">*</span></label>
                            <textarea name="description" class="form-control" rows="4" required>${event.description}</textarea>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <select name="category" class="form-select py-2" required>
                                    <option value="Technical" ${event.category == 'Technical' ? 'selected' : ''}>Technical</option>
                                    <option value="Hackathon" ${event.category == 'Hackathon' ? 'selected' : ''}>Hackathon</option>
                                    <option value="Cultural" ${event.category == 'Cultural' ? 'selected' : ''}>Cultural</option>
                                    <option value="Workshop" ${event.category == 'Workshop' ? 'selected' : ''}>Workshop</option>
                                    <option value="Seminar" ${event.category == 'Seminar' ? 'selected' : ''}>Seminar</option>
                                    <option value="Competition" ${event.category == 'Competition' ? 'selected' : ''}>Competition</option>
                                    <option value="Sports" ${event.category == 'Sports' ? 'selected' : ''}>Sports</option>
                                    <option value="Other" ${event.category == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Venue <span class="text-danger">*</span></label>
                                <input type="text" name="venue" class="form-control py-2" required value="${event.venue}">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Event Date <span class="text-danger">*</span></label>
                                <input type="date" name="eventDate" class="form-control py-2" required value="${event.eventDate}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Event Time <span class="text-danger">*</span></label>
                                <input type="text" name="eventTime" class="form-control py-2" required value="${event.eventTime}">
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Organizer <span class="text-danger">*</span></label>
                                <input type="text" name="organizer" class="form-control py-2" required value="${event.organizer}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Max Participants <span class="text-danger">*</span></label>
                                <input type="number" name="maxParticipants" class="form-control py-2" required min="1" value="${event.maxParticipants}">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Status <span class="text-danger">*</span></label>
                                <select name="status" class="form-select py-2" required>
                                    <option value="Upcoming" ${event.status == 'Upcoming' ? 'selected' : ''}>Upcoming</option>
                                    <option value="Completed" ${event.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                    <option value="Cancelled" ${event.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-warning btn-lg px-4 py-2 fw-bold text-dark shadow-sm">
                                <i class="fa-solid fa-arrows-rotate me-2"></i> Update Event in Database
                            </button>
                            <a href="${pageContext.request.contextPath}/manage-events" class="btn btn-outline-secondary btn-lg px-4 py-2 fw-semibold">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
