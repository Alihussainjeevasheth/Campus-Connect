<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Contact Us - CampusConnect" />
<c:set var="activePage" value="contact" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5">
                    <h3 class="fw-bold mb-2"><i class="fa-solid fa-envelope-open-text me-2 text-primary"></i> Contact Campus Event Helpdesk</h3>
                    <p class="text-muted mb-4">Have questions regarding events, venue allocations, or registrations? Reach out to us.</p>

                    <form action="#" method="post" onsubmit="alert('Thank you! Your message has been sent to the Event Coordinator.'); return false;">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Your Name</label>
                                <input type="text" class="form-control" required placeholder="Enter full name">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Email Address</label>
                                <input type="email" class="form-control" required placeholder="name@college.edu">
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Subject</label>
                                <input type="text" class="form-control" required placeholder="Event Inquiry / Technical Support">
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Message</label>
                                <textarea class="form-control" rows="4" required placeholder="Write your message..."></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary px-4 py-2 fw-semibold">
                                    <i class="fa-solid fa-paper-plane me-1"></i> Send Message
                                </button>
                            </div>
                        </div>
                    </form>

                    <hr class="my-4">

                    <div class="row text-muted small g-3">
                        <div class="col-md-4">
                            <i class="fa-solid fa-location-dot me-1 text-primary"></i> Main Campus Block A
                        </div>
                        <div class="col-md-4">
                            <i class="fa-solid fa-phone me-1 text-primary"></i> +91 (0) 1234 567 890
                        </div>
                        <div class="col-md-4">
                            <i class="fa-solid fa-envelope me-1 text-primary"></i> events@campusconnect.edu
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
