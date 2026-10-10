<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Student Dashboard - CampusConnect" />
<c:set var="activePage" value="dashboard" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <!-- WELCOME BANNER -->
        <div class="card border-0 shadow-sm rounded-4 bg-primary text-white p-4 mb-4">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <span class="badge bg-white text-primary fw-bold px-3 py-2 rounded-pill mb-2">Student Portal</span>
                    <h2 class="fw-bold mb-1">Welcome back, ${sessionScope.student.name}!</h2>
                    <p class="mb-0 text-white-50">
                        Department of ${sessionScope.student.department} (${sessionScope.student.semester}) | Enrollment: ${sessionScope.student.enrollmentNo}
                    </p>
                </div>
                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-light fw-bold px-4 py-2 text-primary">
                        <i class="fa-solid fa-plus-circle me-1"></i> Browse & Register Events
                    </a>
                </div>
            </div>
        </div>

        <!-- STATS CARDS -->
        <div class="row g-4 mb-5">
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Available Events</div>
                        <div class="stat-icon bg-primary-subtle text-primary"><i class="fa-solid fa-calendar-day"></i></div>
                    </div>
                    <div class="stat-number">${availableEventsCount}</div>
                    <div class="small text-muted mt-1">Open for registration</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">My Registrations</div>
                        <div class="stat-icon bg-success-subtle text-success"><i class="fa-solid fa-ticket"></i></div>
                    </div>
                    <div class="stat-number">${registeredCount}</div>
                    <div class="small text-muted mt-1">Active registrations</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Department</div>
                        <div class="stat-icon bg-warning-subtle text-warning"><i class="fa-solid fa-building-columns"></i></div>
                    </div>
                    <div class="fs-6 fw-bold text-dark text-truncate mt-1">${sessionScope.student.department}</div>
                    <div class="small text-muted">Verified student</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Enrollment No</div>
                        <div class="stat-icon bg-info-subtle text-info"><i class="fa-solid fa-id-badge"></i></div>
                    </div>
                    <div class="fs-6 fw-bold text-dark mt-1">${sessionScope.student.enrollmentNo}</div>
                    <div class="small text-muted">Official Student ID</div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- MY REGISTRATIONS RECENT -->
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-ticket me-2 text-primary"></i> My Event Registrations</h5>
                        <a href="${pageContext.request.contextPath}/my-registrations" class="btn btn-sm btn-outline-primary fw-semibold">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Event Name</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty myRegistrations}">
                                        <c:forEach var="reg" items="${myRegistrations}" end="3">
                                            <tr>
                                                <td class="fw-semibold text-dark">${reg.eventName}</td>
                                                <td class="small text-muted">${reg.eventDate}</td>
                                                <td>
                                                    <span class="badge ${reg.status == 'REGISTERED' ? 'bg-success' : 'bg-secondary'}">
                                                        ${reg.status}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted py-4">No active event registrations yet.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- UPCOMING EVENTS RECENT -->
            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4 h-100">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-calendar-star me-2 text-primary"></i> Upcoming Campus Events</h5>
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-sm btn-outline-primary fw-semibold">Explore All</a>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${not empty upcomingEvents}">
                                <c:forEach var="event" items="${upcomingEvents}" end="3">
                                    <div class="list-group-item px-0 py-3 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <h6 class="fw-bold mb-0 text-dark">${event.eventName}</h6>
                                            <span class="badge bg-primary-subtle text-primary">${event.category}</span>
                                        </div>
                                        <div class="small text-muted mb-2">
                                            <i class="fa-regular fa-calendar me-1"></i> ${event.eventDate} | <i class="fa-solid fa-location-dot me-1"></i> ${event.venue}
                                        </div>
                                        <a href="${pageContext.request.contextPath}/event-details?id=${event.eventId}" class="btn btn-sm btn-light border text-primary font-weight-semibold">
                                            View Details & Register
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-4">No upcoming events listed.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
