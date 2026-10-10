<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Campus Events - CampusConnect" />
<c:set var="activePage" value="events" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h2 class="fw-bold text-dark mb-1"><i class="fa-solid fa-calendar-days me-2 text-primary"></i> Explore Campus Events</h2>
                <p class="text-muted mb-0">Browse workshops, hackathons, sports, and cultural competitions</p>
            </div>
            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                <span class="badge bg-primary px-3 py-2 fs-6 rounded-pill">Total Events: ${events.size()}</span>
            </div>
        </div>

        <!-- SEARCH AND FILTERS CARD -->
        <div class="card border-0 shadow-sm rounded-3 mb-4 p-3 bg-white">
            <form action="${pageContext.request.contextPath}/events" method="get" class="row g-3 align-items-center">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                        <input type="text" name="search" class="form-control border-start-0 bg-light" placeholder="Search by event name, venue, organizer..." value="${searchQuery}">
                    </div>
                </div>
                <div class="col-md-3">
                    <select name="category" class="form-select bg-light">
                        <option value="ALL" ${selectedCategory == 'ALL' ? 'selected' : ''}>All Categories</option>
                        <option value="Technical" ${selectedCategory == 'Technical' ? 'selected' : ''}>Technical</option>
                        <option value="Hackathon" ${selectedCategory == 'Hackathon' ? 'selected' : ''}>Hackathon</option>
                        <option value="Cultural" ${selectedCategory == 'Cultural' ? 'selected' : ''}>Cultural</option>
                        <option value="Workshop" ${selectedCategory == 'Workshop' ? 'selected' : ''}>Workshop</option>
                        <option value="Seminar" ${selectedCategory == 'Seminar' ? 'selected' : ''}>Seminar</option>
                        <option value="Competition" ${selectedCategory == 'Competition' ? 'selected' : ''}>Competition</option>
                        <option value="Sports" ${selectedCategory == 'Sports' ? 'selected' : ''}>Sports</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select name="status" class="form-select bg-light">
                        <option value="ALL" ${selectedStatus == 'ALL' ? 'selected' : ''}>All Statuses</option>
                        <option value="Upcoming" ${selectedStatus == 'Upcoming' ? 'selected' : ''}>Upcoming</option>
                        <option value="Completed" ${selectedStatus == 'Completed' ? 'selected' : ''}>Completed</option>
                        <option value="Cancelled" ${selectedStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex gap-2">
                    <button type="submit" class="btn btn-primary w-100 fw-semibold"><i class="fa-solid fa-filter me-1"></i> Filter</button>
                    <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-secondary" title="Reset Filters"><i class="fa-solid fa-rotate-left"></i></a>
                </div>
            </form>
        </div>

        <!-- EVENTS GRID -->
        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty events}">
                    <c:forEach var="event" items="${events}">
                        <div class="col-md-6 col-lg-4">
                            <div class="event-card">
                                <div class="event-card-header d-flex justify-content-between align-items-center">
                                    <span><i class="fa-solid fa-tag me-1"></i> ${event.category}</span>
                                    <span class="badge ${event.status == 'Upcoming' ? 'bg-success' : (event.status == 'Completed' ? 'bg-secondary' : 'bg-danger')} text-white event-badge">
                                        ${event.status}
                                    </span>
                                </div>
                                <div class="card-body p-4 d-flex flex-column">
                                    <h5 class="fw-bold card-title text-dark mb-2">${event.eventName}</h5>
                                    <p class="text-muted small flex-grow-1 mb-3">
                                        <c:out value="${event.description.length() > 110 ? event.description.substring(0, 110).concat('...') : event.description}" />
                                    </p>
                                    <div class="small text-secondary mb-3 space-y-1">
                                        <div><i class="fa-solid fa-location-dot me-2 text-primary"></i> Venue: ${event.venue}</div>
                                        <div><i class="fa-regular fa-calendar me-2 text-primary"></i> Date: ${event.eventDate}</div>
                                        <div><i class="fa-regular fa-clock me-2 text-primary"></i> Time: ${event.eventTime}</div>
                                        <div><i class="fa-solid fa-user-tie me-2 text-primary"></i> Organizer: ${event.organizer}</div>
                                        <div class="mt-2 pt-2 border-top">
                                            <i class="fa-solid fa-users me-2 text-primary"></i> Available Seats: 
                                            <span class="fw-bold ${event.availableSeats > 0 ? 'text-success' : 'text-danger'}">
                                                ${event.availableSeats} / ${event.maxParticipants}
                                            </span>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/event-details?id=${event.eventId}" class="btn btn-outline-primary w-100 fw-semibold mt-auto">
                                        View Details <i class="fa-solid fa-chevron-right ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 bg-white rounded-3 border">
                        <i class="fa-solid fa-folder-open fa-3x text-muted mb-3"></i>
                        <h5>No Events Found</h5>
                        <p class="text-muted mb-0">Try changing your search terms or filter criteria.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
