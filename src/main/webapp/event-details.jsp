<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="${event != null ? event.eventName : 'Event Details'} - CampusConnect" />
<c:set var="activePage" value="events" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <!-- Error & Alert Messages -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-secondary mb-4">
            <i class="fa-solid fa-arrow-left me-1"></i> Back to Events List
        </a>

        <c:choose>
            <c:when test="${not empty event}">
                <div class="row g-4">
                    <!-- Event Info Card -->
                    <div class="col-lg-8">
                        <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill fw-semibold">
                                    <i class="fa-solid fa-tag me-1"></i> ${event.category}
                                </span>
                                <span class="badge ${event.status == 'Upcoming' ? 'bg-success' : (event.status == 'Completed' ? 'bg-secondary' : 'bg-danger')} px-3 py-2 rounded-pill fs-6">
                                    ${event.status}
                                </span>
                            </div>

                            <h1 class="fw-bold text-dark mb-3">${event.eventName}</h1>

                            <div class="p-3 bg-light rounded-3 mb-4">
                                <h6 class="fw-bold text-secondary mb-2"><i class="fa-solid fa-align-left me-2"></i> Event Overview & Agenda</h6>
                                <p class="text-dark mb-0 style-description">${event.description}</p>
                            </div>

                            <h5 class="fw-bold text-dark mb-3"><i class="fa-solid fa-circle-info me-2 text-primary"></i> Key Details</h5>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="p-3 border rounded-3 bg-white">
                                        <div class="text-muted small">Date & Time</div>
                                        <div class="fw-semibold text-dark"><i class="fa-regular fa-calendar-check me-2 text-primary"></i> ${event.eventDate} at ${event.eventTime}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 border rounded-3 bg-white">
                                        <div class="text-muted small">Venue Location</div>
                                        <div class="fw-semibold text-dark"><i class="fa-solid fa-location-dot me-2 text-primary"></i> ${event.venue}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 border rounded-3 bg-white">
                                        <div class="text-muted small">Event Organizer</div>
                                        <div class="fw-semibold text-dark"><i class="fa-solid fa-user-tie me-2 text-primary"></i> ${event.organizer}</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 border rounded-3 bg-white">
                                        <div class="text-muted small">Maximum Capacity</div>
                                        <div class="fw-semibold text-dark"><i class="fa-solid fa-users me-2 text-primary"></i> ${event.maxParticipants} Participants</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Registration Action Sidebar -->
                    <div class="col-lg-4">
                        <div class="card border-0 shadow-sm rounded-4 p-4 sticky-top" style="top: 90px;">
                            <h5 class="fw-bold mb-3"><i class="fa-solid fa-ticket me-2 text-primary"></i> Registration Status</h5>

                            <div class="p-3 bg-light rounded-3 mb-4">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="text-muted small">Seats Available:</span>
                                    <span class="fw-bold ${event.availableSeats > 0 ? 'text-success' : 'text-danger'} fs-5">
                                        ${event.availableSeats} / ${event.maxParticipants}
                                    </span>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-primary" role="progressbar" 
                                         style="width: ${(event.registeredCount / event.maxParticipants) * 100}%;"></div>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty sessionScope.student}">
                                    <c:choose>
                                        <c:when test="${isRegistered}">
                                            <div class="alert alert-success text-center mb-3">
                                                <i class="fa-solid fa-circle-check fa-2x mb-2 d-block"></i>
                                                <strong>You are registered for this event!</strong>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/my-registrations" class="btn btn-outline-primary w-100 fw-semibold">
                                                View My Registrations
                                            </a>
                                        </c:when>
                                        <c:when test="${event.status != 'Upcoming'}">
                                            <button class="btn btn-secondary w-100 py-2 fw-semibold" disabled>
                                                Registration Closed (${event.status})
                                            </button>
                                        </c:when>
                                        <c:when test="${event.availableSeats <= 0}">
                                            <button class="btn btn-danger w-100 py-2 fw-semibold" disabled>
                                                Registration Full
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/register-event" method="post">
                                                <input type="hidden" name="eventId" value="${event.eventId}">
                                                <button type="submit" class="btn btn-success btn-lg w-100 py-3 fw-bold shadow-sm">
                                                    <i class="fa-solid fa-user-check me-2"></i> Register for Event Now
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${not empty sessionScope.admin}">
                                    <div class="alert alert-warning text-center">
                                        <i class="fa-solid fa-user-shield me-1"></i> Logged in as Admin.
                                    </div>
                                    <a href="${pageContext.request.contextPath}/edit-event?id=${event.eventId}" class="btn btn-warning w-100 fw-semibold">
                                        Edit Event Details
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-light border text-center mb-3">
                                        Please log in to your student account to register for campus events.
                                    </div>
                                    <a href="${pageContext.request.contextPath}/student-login" class="btn btn-primary btn-lg w-100 fw-semibold">
                                        <i class="fa-solid fa-right-to-bracket me-2"></i> Login to Register
                                    </a>
                                    <div class="text-center mt-3">
                                        <span class="text-muted small">New student?</span> 
                                        <a href="${pageContext.request.contextPath}/student-register" class="small fw-bold">Create Account</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <h3>Event Not Found</h3>
                    <p class="text-muted">The requested event could not be retrieved from MySQL.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
