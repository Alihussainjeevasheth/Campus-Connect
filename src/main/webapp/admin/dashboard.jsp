<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Admin Dashboard - CampusConnect" />
<c:set var="activePage" value="admin" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <!-- HEADER -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-warning text-dark fw-bold px-3 py-2 rounded-pill mb-1">
                    <i class="fa-solid fa-user-shield me-1"></i> Administrator Control Panel
                </span>
                <h2 class="fw-bold text-dark mb-0">System Overview & Dashboard</h2>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/add-event" class="btn btn-primary fw-semibold">
                    <i class="fa-solid fa-plus me-1"></i> Add New Event
                </a>
                <a href="${pageContext.request.contextPath}/manage-events" class="btn btn-outline-dark fw-semibold">
                    <i class="fa-solid fa-calendar-check me-1"></i> Manage Events
                </a>
            </div>
        </div>

        <!-- NAVIGATION SHORTCUT BAR -->
        <div class="card border-0 shadow-sm rounded-3 mb-4 p-3 bg-white">
            <div class="d-flex flex-wrap gap-2 align-items-center justify-content-between">
                <div class="fw-semibold text-secondary">
                    <i class="fa-solid fa-sliders me-2 text-primary"></i> Quick Navigation:
                </div>
                <div class="d-flex flex-wrap gap-2">
                    <a href="${pageContext.request.contextPath}/admin-dashboard" class="btn btn-sm btn-primary active fw-semibold"><i class="fa-solid fa-chart-pie me-1"></i> Dashboard</a>
                    <a href="${pageContext.request.contextPath}/manage-events" class="btn btn-sm btn-outline-secondary fw-semibold"><i class="fa-solid fa-list-check me-1"></i> Manage Events</a>
                    <a href="${pageContext.request.contextPath}/add-event" class="btn btn-sm btn-outline-secondary fw-semibold"><i class="fa-solid fa-folder-plus me-1"></i> Add Event</a>
                    <a href="${pageContext.request.contextPath}/admin-registrations" class="btn btn-sm btn-outline-secondary fw-semibold"><i class="fa-solid fa-ticket me-1"></i> Registrations</a>
                    <a href="${pageContext.request.contextPath}/admin-logout" class="btn btn-sm btn-outline-danger fw-semibold"><i class="fa-solid fa-right-from-bracket me-1"></i> Logout</a>
                </div>
            </div>
        </div>

        <!-- STATS CARDS (LIVE MYSQL DATA) -->
        <div class="row g-4 mb-5">
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Total Events</div>
                        <div class="stat-icon bg-primary-subtle text-primary"><i class="fa-solid fa-calendar-days"></i></div>
                    </div>
                    <div class="stat-number">${totalEvents}</div>
                    <div class="small text-muted mt-1">Total in MySQL DB</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Upcoming Events</div>
                        <div class="stat-icon bg-success-subtle text-success"><i class="fa-solid fa-clock"></i></div>
                    </div>
                    <div class="stat-number">${upcomingEvents}</div>
                    <div class="small text-muted mt-1">Open for students</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Completed Events</div>
                        <div class="stat-icon bg-secondary-subtle text-secondary"><i class="fa-solid fa-calendar-check"></i></div>
                    </div>
                    <div class="stat-number">${completedEvents}</div>
                    <div class="small text-muted mt-1">Concluded activities</div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="stat-card">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="stat-label">Total Registrations</div>
                        <div class="stat-icon bg-warning-subtle text-warning"><i class="fa-solid fa-ticket"></i></div>
                    </div>
                    <div class="stat-number">${totalRegistrations}</div>
                    <div class="small text-muted mt-1">Student registrations</div>
                </div>
            </div>
        </div>

        <!-- RECENT EVENTS TABLE -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
            <div class="card-header bg-white py-3 px-4 d-flex justify-content-between align-items-center border-bottom">
                <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-list me-2 text-primary"></i> Recently Managed Events</h5>
                <a href="${pageContext.request.contextPath}/manage-events" class="btn btn-sm btn-outline-primary fw-semibold">View All & Perform CRUD</a>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 custom-table">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Event Name</th>
                            <th>Category</th>
                            <th>Venue</th>
                            <th>Event Date</th>
                            <th>Status</th>
                            <th class="pe-4 text-end">Quick Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentEvents}">
                                <c:forEach var="event" items="${recentEvents}">
                                    <tr>
                                        <td class="ps-4 fw-semibold text-muted">#${event.eventId}</td>
                                        <td class="fw-bold text-dark">${event.eventName}</td>
                                        <td><span class="badge bg-light text-dark border">${event.category}</span></td>
                                        <td class="small text-muted">${event.venue}</td>
                                        <td class="small fw-semibold">${event.eventDate}</td>
                                        <td>
                                            <span class="badge ${event.status == 'Upcoming' ? 'bg-success' : (event.status == 'Completed' ? 'bg-secondary' : 'bg-danger')}">
                                                ${event.status}
                                            </span>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <a href="${pageContext.request.contextPath}/edit-event?id=${event.eventId}" class="btn btn-sm btn-outline-primary me-1" title="Edit">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/delete-event?id=${event.eventId}" 
                                               onclick="return confirmDelete('${event.eventName}');" 
                                               class="btn btn-sm btn-outline-danger" title="Delete">
                                                <i class="fa-solid fa-trash-can"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-4 text-muted">No events available in database.</td>
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
