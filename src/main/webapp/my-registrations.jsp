<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="My Registrations - CampusConnect" />
<c:set var="activePage" value="dashboard" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1"><i class="fa-solid fa-ticket me-2 text-primary"></i> My Registered Events</h2>
                <p class="text-muted mb-0">Manage your active event registrations and participation status</p>
            </div>
            <a href="${pageContext.request.contextPath}/events" class="btn btn-primary fw-semibold">
                <i class="fa-solid fa-plus me-1"></i> Register for New Event
            </a>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 custom-table">
                    <thead>
                        <tr>
                            <th class="ps-4">Event Name</th>
                            <th>Event Date</th>
                            <th>Venue</th>
                            <th>Registration Date</th>
                            <th>Status</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty registrations}">
                                <c:forEach var="reg" items="${registrations}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="fw-bold text-dark">${reg.eventName}</div>
                                            <a href="${pageContext.request.contextPath}/event-details?id=${reg.eventId}" class="small text-primary text-decoration-none">
                                                View Event Details <i class="fa-solid fa-arrow-up-right-from-square ms-1" style="font-size: 0.75rem;"></i>
                                            </a>
                                        </td>
                                        <td>
                                            <span class="fw-semibold text-dark"><i class="fa-regular fa-calendar me-1 text-primary"></i> ${reg.eventDate}</span>
                                        </td>
                                        <td class="text-muted"><i class="fa-solid fa-location-dot me-1 text-primary"></i> ${reg.venue}</td>
                                        <td class="small text-muted">${reg.registrationDate}</td>
                                        <td>
                                            <span class="badge ${reg.status == 'REGISTERED' ? 'bg-success' : 'bg-secondary'} px-3 py-2 rounded-pill">
                                                ${reg.status}
                                            </span>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <c:if test="${reg.status == 'REGISTERED'}">
                                                <form action="${pageContext.request.contextPath}/cancel-registration" method="post" onsubmit="return confirm('Are you sure you want to cancel registration for ${reg.eventName}?');">
                                                    <input type="hidden" name="registrationId" value="${reg.registrationId}">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm px-3 fw-semibold">
                                                        <i class="fa-solid fa-xmark me-1"></i> Cancel Registration
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${reg.status == 'CANCELLED'}">
                                                <span class="text-muted small">Cancelled</span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="fa-solid fa-ticket fa-3x mb-3 text-secondary"></i>
                                        <h5>No Event Registrations Found</h5>
                                        <p class="mb-3">You haven't registered for any college events yet.</p>
                                        <a href="${pageContext.request.contextPath}/events" class="btn btn-primary fw-semibold">Explore Available Events</a>
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
