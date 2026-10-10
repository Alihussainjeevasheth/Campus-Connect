<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Event Registrations - Admin Portal" />
<c:set var="activePage" value="admin" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-warning text-dark fw-bold px-3 py-2 rounded-pill mb-1">Admin Audit</span>
                <h2 class="fw-bold text-dark mb-0">Student Event Registrations</h2>
            </div>
            <a href="${pageContext.request.contextPath}/admin-dashboard" class="btn btn-outline-secondary fw-semibold">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-header bg-white py-3 px-4 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="fw-bold mb-0 text-dark"><i class="fa-solid fa-users me-2 text-primary"></i> Registration Records</h5>
                <span class="badge bg-light text-dark border">Total Registrations: ${registrations.size()}</span>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 custom-table">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Student Name</th>
                            <th>Student Email</th>
                            <th>Event Name</th>
                            <th>Event Date</th>
                            <th>Registration Date</th>
                            <th class="pe-4 text-end">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty registrations}">
                                <c:forEach var="reg" items="${registrations}">
                                    <tr>
                                        <td class="ps-4 fw-bold text-muted">#${reg.registrationId}</td>
                                        <td class="fw-semibold text-dark">${reg.studentName}</td>
                                        <td class="small text-muted">${reg.studentEmail}</td>
                                        <td class="fw-bold text-primary">${reg.eventName}</td>
                                        <td class="small">${reg.eventDate}</td>
                                        <td class="small text-muted">${reg.registrationDate}</td>
                                        <td class="pe-4 text-end">
                                            <span class="badge ${reg.status == 'REGISTERED' ? 'bg-success' : 'bg-secondary'} px-3 py-2 rounded-pill">
                                                ${reg.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center py-5 text-muted">No student registrations found in database.</td>
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
