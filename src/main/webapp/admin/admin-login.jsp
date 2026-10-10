<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Admin Login - CampusConnect" />
<c:set var="activePage" value="admin" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="stat-icon bg-warning-subtle text-warning mx-auto mb-2" style="width: 56px; height: 56px; font-size: 1.8rem;">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Admin Control Panel</h3>
                        <p class="text-muted small">Authorized college event administrator login</p>
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

                    <form action="${pageContext.request.contextPath}/admin-login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Admin Username</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-user-shield text-muted"></i></span>
                                <input type="text" name="username" class="form-control py-2" required placeholder="admin" value="admin">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">Password</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light"><i class="fa-solid fa-key text-muted"></i></span>
                                <input type="password" name="password" class="form-control py-2" required placeholder="admin123" value="admin123">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-warning btn-lg w-100 py-3 fw-bold text-dark shadow-sm">
                            <i class="fa-solid fa-shield-halved me-2"></i> Log In to Dashboard
                        </button>
                    </form>

                    <div class="p-3 bg-light rounded-3 mt-4 text-center small">
                        <span class="text-muted">Demo Admin Credentials:</span><br>
                        <strong>Username:</strong> admin | <strong>Password:</strong> admin123
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
