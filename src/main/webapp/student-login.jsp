<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Student Login - CampusConnect" />
<c:set var="activePage" value="login" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="stat-icon bg-primary-subtle text-primary mx-auto mb-2" style="width: 56px; height: 56px; font-size: 1.8rem;">
                            <i class="fa-solid fa-graduation-cap"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Student Login</h3>
                        <p class="text-muted small">Access your registered events and campus dashboard</p>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/student-login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-envelope text-muted"></i></span>
                                <input type="email" name="email" class="form-control py-2" required placeholder="student@campusconnect.com" value="student@campusconnect.com">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-lock text-muted"></i></span>
                                <input type="password" name="password" class="form-control py-2" required placeholder="Enter password" value="student123">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow-sm">
                            <i class="fa-solid fa-right-to-bracket me-2"></i> Log In to Portal
                        </button>
                    </form>

                    <div class="p-3 bg-light rounded-3 mt-4 text-center small">
                        <span class="text-muted">Demo Credentials:</span><br>
                        <strong>Email:</strong> student@campusconnect.com | <strong>Password:</strong> student123
                    </div>

                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted">Don't have a student account?</span>
                        <a href="${pageContext.request.contextPath}/student-register" class="fw-bold text-primary ms-1">Register Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
