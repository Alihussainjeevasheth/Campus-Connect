<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="CampusConnect - College Event Management System" />
<c:set var="activePage" value="home" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main>
    <!-- HERO SECTION -->
    <section class="hero-section text-center text-lg-start">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-7">
                    <span class="badge bg-primary-subtle text-primary border border-primary px-3 py-2 rounded-pill mb-3 fw-semibold">
                        <i class="fa-solid fa-sparkles me-1"></i> Official College Event Portal
                    </span>
                    <h1 class="hero-title">Discover. Participate. Connect.</h1>
                    <p class="hero-subtitle">
                        Discover and register for exciting college events, technical hackathons, workshops, cultural fests, and sports competitions happening across campus.
                    </p>
                    <div class="d-flex flex-wrap gap-3 justify-content-center justify-content-lg-start">
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-primary btn-lg px-4 py-3 fw-semibold shadow-sm">
                            <i class="fa-solid fa-compass me-2"></i> Explore Events
                        </a>
                        <c:if test="${empty sessionScope.student && empty sessionScope.admin}">
                            <a href="${pageContext.request.contextPath}/student-register" class="btn btn-outline-light btn-lg px-4 py-3 fw-semibold">
                                <i class="fa-solid fa-user-plus me-2"></i> Get Started
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-5 text-center">
                    <div class="p-4 bg-white rounded-4 shadow-lg text-dark">
                        <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
                            <h6 class="fw-bold mb-0 text-primary"><i class="fa-solid fa-chart-line me-2"></i> Campus Live Stats</h6>
                            <span class="badge bg-success">Active</span>
                        </div>
                        <div class="row g-3 text-start">
                            <div class="col-6">
                                <div class="p-3 bg-light rounded-3">
                                    <div class="fs-3 fw-bold text-primary">${totalEvents != null ? totalEvents : 5}</div>
                                    <div class="small text-muted">Total Events</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-3 bg-light rounded-3">
                                    <div class="fs-3 fw-bold text-success">${totalStudents != null ? totalStudents : 3}</div>
                                    <div class="small text-muted">Active Students</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-3 bg-light rounded-3">
                                    <div class="fs-3 fw-bold text-warning">${totalRegistrations != null ? totalRegistrations : 4}</div>
                                    <div class="small text-muted">Event Registrations</div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="p-3 bg-light rounded-3">
                                    <div class="fs-3 fw-bold text-info">100%</div>
                                    <div class="small text-muted">Verified Portal</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- UPCOMING EVENTS SECTION -->
    <section class="py-5">
        <div class="container">
            <div class="d-flex justify-content-between align-items-end mb-4">
                <div>
                    <h2 class="fw-bold text-dark mb-1"><i class="fa-solid fa-calendar-star me-2 text-primary"></i> Featured Upcoming Events</h2>
                    <p class="text-muted mb-0">Join top activities organized by departments and clubs</p>
                </div>
                <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-primary fw-semibold">
                    View All Events <i class="fa-solid fa-arrow-right ms-1"></i>
                </a>
            </div>

            <div class="row g-4">
                <c:choose>
                    <c:when test="${not empty upcomingEvents}">
                        <c:forEach var="event" items="${upcomingEvents}">
                            <div class="col-md-6 col-lg-4">
                                <div class="event-card">
                                    <div class="event-card-header d-flex justify-content-between align-items-center">
                                        <span><i class="fa-solid fa-tag me-1"></i> ${event.category}</span>
                                        <span class="badge bg-light text-dark event-badge">${event.status}</span>
                                    </div>
                                    <div class="card-body p-4 d-flex flex-column">
                                        <h5 class="fw-bold card-title text-dark mb-2">${event.eventName}</h5>
                                        <p class="text-muted small flex-grow-1 mb-3">
                                            <c:out value="${event.description.length() > 100 ? event.description.substring(0, 100).concat('...') : event.description}" />
                                        </p>
                                        <div class="small text-secondary mb-3 space-y-1">
                                            <div><i class="fa-solid fa-location-dot me-2 text-primary"></i> ${event.venue}</div>
                                            <div><i class="fa-regular fa-calendar me-2 text-primary"></i> ${event.eventDate} at ${event.eventTime}</div>
                                            <div><i class="fa-solid fa-user-tie me-2 text-primary"></i> Organizer: ${event.organizer}</div>
                                            <div><i class="fa-solid fa-users me-2 text-primary"></i> Seats Remaining: <strong>${event.availableSeats} / ${event.maxParticipants}</strong></div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/event-details?id=${event.eventId}" class="btn btn-primary w-100 fw-semibold">
                                            View Details & Register <i class="fa-solid fa-chevron-right ms-1"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="text-center py-5 bg-white rounded-3 border">
                                <i class="fa-solid fa-calendar-xmark fa-3x text-muted mb-3"></i>
                                <h5>No Upcoming Events Listed Right Now</h5>
                                <p class="text-muted">Check back soon for new campus events!</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- EVENT CATEGORIES -->
    <section class="py-5 bg-white border-top border-bottom">
        <div class="container text-center">
            <h2 class="fw-bold mb-2">Event Categories</h2>
            <p class="text-muted mb-5">Explore various domain activities across campus</p>
            
            <div class="row g-4">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-code fa-2x text-primary mb-2"></i>
                        <h6 class="fw-bold mb-0">Technical</h6>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-laptop-code fa-2x text-success mb-2"></i>
                        <h6 class="fw-bold mb-0">Hackathons</h6>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-masks-theater fa-2x text-warning mb-2"></i>
                        <h6 class="fw-bold mb-0">Cultural</h6>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-chalkboard-user fa-2x text-info mb-2"></i>
                        <h6 class="fw-bold mb-0">Workshops</h6>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-trophy fa-2x text-danger mb-2"></i>
                        <h6 class="fw-bold mb-0">Sports</h6>
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="p-3 border rounded-3 text-center bg-light">
                        <i class="fa-solid fa-graduation-cap fa-2x text-secondary mb-2"></i>
                        <h6 class="fw-bold mb-0">Seminars</h6>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- HOW IT WORKS -->
    <section class="py-5">
        <div class="container text-center">
            <h2 class="fw-bold mb-2">How CampusConnect Works</h2>
            <p class="text-muted mb-5">Seamless event participation in 3 simple steps</p>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-3 border h-100 shadow-sm">
                        <div class="stat-icon bg-primary-subtle text-primary mx-auto mb-3">1</div>
                        <h5 class="fw-bold">Create Account</h5>
                        <p class="text-muted small mb-0">Students can register with their college email, department, semester, and enrollment number.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-3 border h-100 shadow-sm">
                        <div class="stat-icon bg-success-subtle text-success mx-auto mb-3">2</div>
                        <h5 class="fw-bold">Browse Events</h5>
                        <p class="text-muted small mb-0">Explore upcoming workshops, hackathons, sports, and cultural events with search & category filters.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-4 bg-white rounded-3 border h-100 shadow-sm">
                        <div class="stat-icon bg-warning-subtle text-warning mx-auto mb-3">3</div>
                        <h5 class="fw-bold">Instant Registration</h5>
                        <p class="text-muted small mb-0">Register with a single click, manage active registrations, or cancel directly from your dashboard.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="/includes/footer.jsp" %>
