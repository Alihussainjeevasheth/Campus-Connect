<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="About - CampusConnect" />
<c:set var="activePage" value="about" />
<%@ include file="/includes/header.jsp" %>
<%@ include file="/includes/navbar.jsp" %>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5">
                    <div class="text-center mb-4">
                        <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill fw-semibold mb-2">College Event Portal</span>
                        <h2 class="fw-bold">About CampusConnect</h2>
                        <p class="text-muted">Advanced Java Web Technology Project Submission</p>
                    </div>

                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            <div class="p-4 bg-light rounded-3 h-100">
                                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-bullseye me-2"></i> Project Purpose</h5>
                                <p class="text-muted small mb-0">
                                    CampusConnect was developed to replace manual paper-based event registration systems in colleges with a centralized, automated web portal built entirely with traditional <strong>Java Servlets</strong>, <strong>JSP</strong>, <strong>JDBC</strong>, and <strong>MySQL</strong>.
                                </p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-4 bg-light rounded-3 h-100">
                                <h5 class="fw-bold text-success mb-3"><i class="fa-solid fa-layer-group me-2"></i> Architecture</h5>
                                <p class="text-muted small mb-0">
                                    Following clean MVC (Model-View-Controller) principles, the front-end uses JSP and HTML5/Bootstrap 5, the backend uses Java Servlets for HTTP request processing, and database operations run through JDBC PreparedStatement SQL queries on MySQL 8.0.
                                </p>
                            </div>
                        </div>
                    </div>

                    <h4 class="fw-bold mb-3 border-bottom pb-2"><i class="fa-solid fa-gears me-2 text-primary"></i> Key Technologies Used</h4>
                    <div class="table-responsive mb-4">
                        <table class="table table-bordered align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Layer</th>
                                    <th>Technologies</th>
                                    <th>Role in System</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Frontend</strong></td>
                                    <td>JSP, HTML5, CSS3, JavaScript, Bootstrap 5</td>
                                    <td>User interface rendering, forms, cards, tables, client validation</td>
                                </tr>
                                <tr>
                                    <td><strong>Backend</strong></td>
                                    <td>Java Servlets (Jakarta Servlet 6.0)</td>
                                    <td>HTTP request processing, routing, business logic, session management</td>
                                </tr>
                                <tr>
                                    <td><strong>Database Connectivity</strong></td>
                                    <td>JDBC (Java Database Connectivity)</td>
                                    <td>PreparedStatement SQL execution, connection pooling & resource cleanup</td>
                                </tr>
                                <tr>
                                    <td><strong>Database</strong></td>
                                    <td>MySQL 8.0 Relational DB</td>
                                    <td>Persistent storage of students, admin credentials, events, and registrations</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="alert alert-info d-flex align-items-center mb-0">
                        <i class="fa-solid fa-circle-check fa-2x me-3"></i>
                        <div>
                            <strong>Practical Submission Guarantee:</strong> Demonstrates complete CRUD (Create, Read, Update, Delete) operations, student registrations, duplicate check constraints, and role-based session authentication.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/includes/footer.jsp" %>
