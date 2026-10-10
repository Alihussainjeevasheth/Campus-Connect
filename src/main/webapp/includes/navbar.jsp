<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fa-solid fa-graduation-cap me-2 text-primary-light"></i>Campus<span>Connect</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/">
                        <i class="fa-solid fa-house me-1"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'events' ? 'active' : ''}" href="${pageContext.request.contextPath}/events">
                        <i class="fa-solid fa-calendar-days me-1"></i> Events
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'about' ? 'active' : ''}" href="${pageContext.request.contextPath}/about.jsp">
                        <i class="fa-solid fa-circle-info me-1"></i> About
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'contact' ? 'active' : ''}" href="${pageContext.request.contextPath}/contact.jsp">
                        <i class="fa-solid fa-envelope me-1"></i> Contact
                    </a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${not empty sessionScope.admin}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-warning" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-user-shield me-1"></i> Admin Portal
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin-dashboard"><i class="fa-solid fa-chart-line me-2"></i> Dashboard</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/manage-events"><i class="fa-solid fa-calendar-check me-2"></i> Manage Events</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin-registrations"><i class="fa-solid fa-users-gear me-2"></i> Event Registrations</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/admin-logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Admin Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:when test="${not empty sessionScope.student}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-info" href="#" id="studentDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-user-graduate me-1"></i> ${sessionScope.student.name}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student-dashboard"><i class="fa-solid fa-gauge me-2"></i> My Dashboard</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/my-registrations"><i class="fa-solid fa-ticket me-2"></i> My Registrations</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/student-logout"><i class="fa-solid fa-right-from-bracket me-2"></i> Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light btn-sm px-3 me-2" href="${pageContext.request.contextPath}/student-login">
                                <i class="fa-solid fa-right-to-bracket me-1"></i> Student Login
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-primary btn-sm px-3 text-white" href="${pageContext.request.contextPath}/student-register">
                                <i class="fa-solid fa-user-plus me-1"></i> Register
                            </a>
                        </li>
                        <li class="nav-item ms-lg-2">
                            <a class="nav-link btn btn-outline-warning btn-sm px-3" href="${pageContext.request.contextPath}/admin-login">
                                <i class="fa-solid fa-user-shield me-1"></i> Admin Login
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
