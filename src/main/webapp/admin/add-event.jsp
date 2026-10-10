<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Add New Event - Admin Portal" />
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
                        <div class="stat-icon bg-primary-subtle text-primary me-3">
                            <i class="fa-solid fa-square-plus"></i>
                        </div>
                        <div>
                            <h3 class="fw-bold text-dark mb-0">Create New Event</h3>
                            <p class="text-muted small mb-0">JSP Form → AddEventServlet → JDBC PreparedStatement → MySQL INSERT</p>
                        </div>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/add-event" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Event Name <span class="text-danger">*</span></label>
                            <input type="text" name="eventName" class="form-control py-2" required placeholder="e.g. National Hackathon 2026">
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Description <span class="text-danger">*</span></label>
                            <textarea name="description" class="form-control" rows="4" required placeholder="Provide a detailed overview of the event, rules, agenda, and prizes..."></textarea>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <select name="category" class="form-select py-2" required>
                                    <option value="Technical">Technical</option>
                                    <option value="Hackathon">Hackathon</option>
                                    <option value="Cultural">Cultural</option>
                                    <option value="Workshop">Workshop</option>
                                    <option value="Seminar">Seminar</option>
                                    <option value="Competition">Competition</option>
                                    <option value="Sports">Sports</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Venue <span class="text-danger">*</span></label>
                                <input type="text" name="venue" class="form-control py-2" required placeholder="e.g. Main Auditorium / Lab 3">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Event Date <span class="text-danger">*</span></label>
                                <input type="date" name="eventDate" class="form-control py-2" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Event Time <span class="text-danger">*</span></label>
                                <input type="text" name="eventTime" class="form-control py-2" required placeholder="e.g. 10:00 AM - 04:00 PM">
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Organizer <span class="text-danger">*</span></label>
                                <input type="text" name="organizer" class="form-control py-2" required placeholder="e.g. CSE Department">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Max Participants <span class="text-danger">*</span></label>
                                <input type="number" name="maxParticipants" class="form-control py-2" required min="1" value="100">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Status <span class="text-danger">*</span></label>
                                <select name="status" class="form-select py-2" required>
                                    <option value="Upcoming" selected>Upcoming</option>
                                    <option value="Completed">Completed</option>
                                    <option value="Cancelled">Cancelled</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-primary btn-lg px-4 py-2 fw-bold shadow-sm">
                                <i class="fa-solid fa-floppy-disk me-2"></i> Save Event to Database
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
