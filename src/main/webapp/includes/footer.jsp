<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer>
    <div class="container">
        <div class="row g-4 mb-4">
            <div class="col-md-5">
                <h5 class="text-white font-weight-bold mb-3">
                    <i class="fa-solid fa-graduation-cap me-2 text-primary-light"></i>CampusConnect
                </h5>
                <p class="small text-slate-400">
                    CampusConnect is a comprehensive College Event Management System built with Java Servlets, JSP, JDBC, and MySQL. Designed to streamline campus event organization, registrations, and student participation.
                </p>
            </div>
            <div class="col-md-3">
                <h6 class="text-white mb-3 font-weight-semibold">Quick Links</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-angle-right me-1"></i> Home</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/events"><i class="fa-solid fa-angle-right me-1"></i> Browse Events</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/about.jsp"><i class="fa-solid fa-angle-right me-1"></i> About System</a></li>
                    <li class="mb-2"><a href="${pageContext.request.contextPath}/contact.jsp"><i class="fa-solid fa-angle-right me-1"></i> Contact Us</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6 class="text-white mb-3 font-weight-semibold">Access Portals</h6>
                <div class="d-flex flex-column gap-2 small">
                    <a href="${pageContext.request.contextPath}/student-login" class="text-slate-300"><i class="fa-solid fa-user-graduate me-2"></i> Student Portal Login</a>
                    <a href="${pageContext.request.contextPath}/student-register" class="text-slate-300"><i class="fa-solid fa-id-card me-2"></i> New Student Registration</a>
                    <a href="${pageContext.request.contextPath}/admin-login" class="text-warning"><i class="fa-solid fa-user-shield me-2"></i> Admin Control Panel</a>
                </div>
            </div>
        </div>
        <hr class="border-secondary opacity-25">
        <div class="row pt-2 align-items-center">
            <div class="col-md-6 text-center text-md-start small">
                &copy; 2026 CampusConnect. Advanced Java College Practical Submission.
            </div>
            <div class="col-md-6 text-center text-md-end small">
                <span>Built with Java Servlets • JSP • JDBC • MySQL</span>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
<!-- Custom JavaScript -->
<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
