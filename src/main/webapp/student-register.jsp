<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Student Registration - CampusConnect" />
<c:set var="activePage" value="register" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="stat-icon bg-primary-subtle text-primary mx-auto mb-2" style="width: 56px; height: 56px; font-size: 1.8rem;">
                            <i class="fa-solid fa-user-plus"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Student Registration</h3>
                        <p class="text-muted small">Create your student account to register for college events</p>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form id="studentRegisterForm" action="${pageContext.request.contextPath}/student-register" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                            <input type="text" name="name" class="form-control py-2" required placeholder="e.g. Aarav Patel">
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                                <input type="email" name="email" class="form-control py-2" required placeholder="student@campusconnect.com">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Enrollment Number <span class="text-danger">*</span></label>
                                <input type="text" name="enrollmentNo" class="form-control py-2" required placeholder="EN2023CSE0101">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Department <span class="text-danger">*</span></label>
                                <select name="department" class="form-select py-2" required>
                                    <option value="">Select Department</option>
                                    <option value="Computer Science & Engineering">Computer Science & Engineering</option>
                                    <option value="Information Technology">Information Technology</option>
                                    <option value="Electronics & Communication">Electronics & Communication</option>
                                    <option value="Electrical Engineering">Electrical Engineering</option>
                                    <option value="Mechanical Engineering">Mechanical Engineering</option>
                                    <option value="Civil Engineering">Civil Engineering</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Semester <span class="text-danger">*</span></label>
                                <select name="semester" class="form-select py-2" required>
                                    <option value="">Select Semester</option>
                                    <option value="1st Semester">1st Semester</option>
                                    <option value="2nd Semester">2nd Semester</option>
                                    <option value="3rd Semester">3rd Semester</option>
                                    <option value="4th Semester">4th Semester</option>
                                    <option value="5th Semester">5th Semester</option>
                                    <option value="6th Semester">6th Semester</option>
                                    <option value="7th Semester">7th Semester</option>
                                    <option value="8th Semester">8th Semester</option>
                                </select>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Password <span class="text-danger">*</span></label>
                                <input type="password" id="password" name="password" class="form-control py-2" required minlength="6" placeholder="At least 6 characters">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Confirm Password <span class="text-danger">*</span></label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control py-2" required placeholder="Repeat password">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-lg w-100 py-3 fw-bold shadow-sm">
                            <i class="fa-solid fa-user-check me-2"></i> Register Account
                        </button>
                    </form>

                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted">Already have a student account?</span>
                        <a href="${pageContext.request.contextPath}/student-login" class="fw-bold text-primary ms-1">Login Here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
