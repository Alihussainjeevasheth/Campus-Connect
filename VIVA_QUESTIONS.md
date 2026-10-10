# VIVA PREPARATION GUIDE
## 40+ Advanced Java Viva Questions & Answers

This guide contains key questions and concise answers designed to help you confidently explain your project during practical exams and viva voce.

---

### Section 1: Java Web & Servlets
#### Q1: What is a Java Servlet?
**Answer:** A Java Servlet is a server-side Java program component that extends the capabilities of a web server by handling incoming HTTP requests and generating dynamic responses (such as HTML or JSON).

#### Q2: What is the lifecycle of a Servlet?
**Answer:** A Servlet lifecycle consists of three main methods:
1. `init()`: Called once when the servlet is first loaded and initialized by the container.
2. `service()`: Called for each HTTP request to dispatch to `doGet()`, `doPost()`, etc.
3. `destroy()`: Called once when the servlet container unloads or shuts down the servlet.

#### Q3: Difference between `doGet()` and `doPost()` methods?
**Answer:** 
- `doGet()`: Used to request data from the server. Parameters are appended to the URL (visible in location bar, limited length, bookmarkable).
- `doPost()`: Used to submit data to the server. Parameters are sent in the HTTP request body (hidden from URL, unlimited payload, more secure for forms).

#### Q4: What is `RequestDispatcher` and how does `forward()` differ from `sendRedirect()`?
**Answer:**
- `RequestDispatcher.forward()`: Server-side redirection. The request and response objects are forwarded internally within the server. The URL in the client's browser does NOT change.
- `HttpServletResponse.sendRedirect()`: Client-side redirection. Sends an HTTP 302 status code asking the browser to issue a brand new request to a new URL. The browser URL updates.

#### Q5: How do you handle session management in Servlets?
**Answer:** Using `HttpServletRequest.getSession()`. The container creates an `HttpSession` object associated with a unique JSESSIONID cookie sent to the client browser.

#### Q6: How do you access request parameters in a Servlet?
**Answer:** Using `request.getParameter("paramName")` which returns a String value from form inputs or query string parameters.

---

### Section 2: JSP (JavaServer Pages) & JSTL
#### Q7: What is JSP and how does it relate to Servlets?
**Answer:** JSP is a technology for creating dynamic HTML views. At runtime, the servlet container automatically translates every JSP page into a Java Servlet class.

#### Q8: What are JSP Implicit Objects?
**Answer:** Objects created automatically by the JSP container for use within scriptlets and EL expressions, including `request`, `response`, `session`, `application`, `out`, `config`, `page`, and `pageContext`.

#### Q9: What is JSTL and why is it preferred over Java scriptlets (`<% %>`)?
**Answer:** JSTL (JavaServer Pages Standard Tag Library) provides standard tags for iteration (`<c:forEach>`), conditionals (`<c:if>`, `<c:choose>`), and URL management. It keeps HTML presentation clean and separates view code from Java business logic.

#### Q10: What is Expression Language (EL) in JSP?
**Answer:** EL allows easy access to application data stored in JavaBeans, request attributes, and session attributes using syntax like `${sessionScope.student.name}`.

---

### Section 3: JDBC & Database Operations
#### Q11: What is JDBC?
**Answer:** JDBC (Java Database Connectivity) is a standard Java API that enables Java applications to connect to relational databases and execute SQL statements.

#### Q12: What are the main steps to connect to MySQL using JDBC?
**Answer:**
1. Load JDBC driver class: `Class.forName("com.mysql.cj.jdbc.Driver")`
2. Establish Connection: `DriverManager.getConnection(url, user, password)`
3. Create Statement: `Connection.prepareStatement(sql)`
4. Execute Query: `stmt.executeQuery()` or `stmt.executeUpdate()`
5. Process ResultSet: `rs.next()`
6. Close Resources: Close `ResultSet`, `Statement`, and `Connection`.

#### Q13: Difference between `Statement` and `PreparedStatement`?
**Answer:**
- `Statement`: Used for static SQL statements compiled at execution time. Susceptible to SQL Injection.
- `PreparedStatement`: Pre-compiled SQL query with parameter placeholders (`?`). Significantly faster for repeated execution and immune to SQL Injection attacks.

#### Q14: Difference between `executeQuery()` and `executeUpdate()`?
**Answer:**
- `executeQuery()`: Used for SELECT queries; returns a `ResultSet` object containing data rows.
- `executeUpdate()`: Used for INSERT, UPDATE, or DELETE queries; returns an integer representing the number of rows affected.

#### Q15: What is a `ResultSet`?
**Answer:** A tabular data structure returned by a database query representing a table of data rows. It uses a cursor (`rs.next()`) to iterate through rows.

---

### Section 4: Project Architecture & Practical Questions
#### Q16: Explain the architecture of CampusConnect.
**Answer:** CampusConnect uses a 3-tier MVC pattern:
- **View (JSP / Bootstrap 5):** Displays user interfaces for students and admins.
- **Controller (Servlets):** Processes user requests, validates input, and invokes DAO layer.
- **Model / DAO (Java Beans & JDBC):** Manages data objects and executes SQL queries against MySQL database.

#### Q17: How is CRUD implemented for Events in CampusConnect?
**Answer:**
- **Create:** Admin submits form on `add-event.jsp` -> `AddEventServlet` -> `EventDAO.addEvent()` executes JDBC `INSERT INTO events`.
- **Read:** `manage-events.jsp` requests data -> `ManageEventsServlet` -> `EventDAO.getAllEvents()` executes JDBC `SELECT * FROM events`.
- **Update:** `edit-event.jsp` submits form -> `UpdateEventServlet` -> `EventDAO.updateEvent()` executes JDBC `UPDATE events SET ... WHERE event_id=?`.
- **Delete:** Admin clicks delete -> `DeleteEventServlet` -> `EventDAO.deleteEvent()` executes JDBC `DELETE FROM events WHERE event_id=?`.

#### Q18: How does CampusConnect prevent duplicate registrations?
**Answer:** On the backend, `RegistrationDAO.isAlreadyRegistered()` queries `registrations` table for matching `student_id` and `event_id` with status `REGISTERED`. Additionally, MySQL database enforces a `UNIQUE(student_id, event_id)` constraint.

#### Q19: How are available event seats calculated dynamically?
**Answer:** `EventDAO` queries the total count of active registrations for an event ID (`SELECT COUNT(*) FROM registrations WHERE event_id=? AND status='REGISTERED'`) and subtracts it from `max_participants`.

#### Q20: Where are database credentials configured?
**Answer:** In `src/main/resources/db.properties` and central JDBC class `com.campusconnect.dao.DBConnection.java`.

---

### Section 5: General Web & Database Concepts
#### Q21: What is a JavaBeans class?
**Answer:** A Java class following specific conventions: private fields, public getters and setters, no-argument constructor, and implementing `Serializable`.

#### Q22: What is a Primary Key and Foreign Key?
**Answer:**
- **Primary Key:** A column (or set of columns) that uniquely identifies each row in a table.
- **Foreign Key:** A column in one table that references the primary key of another table, establishing a relational link.

#### Q23: What is SQL Injection and how is it prevented in your project?
**Answer:** SQL Injection is a vulnerability where malicious SQL statements are inserted into form inputs. CampusConnect prevents it by using `PreparedStatement` parameterized queries (`?`) for all database operations.

#### Q24: What is HTTP Status Code 404 and 500?
**Answer:**
- **404:** Resource Not Found (URL path is incorrect or file does not exist).
- **500:** Internal Server Error (Unhandled Java exception on the server side).

#### Q25: How does session authentication work in your Admin login module?
**Answer:** When admin logs in with `admin` / `admin123`, `AdminLoginServlet` verifies credentials via `AdminDAO`. On success, it executes `session.setAttribute("admin", admin)` and `session.setAttribute("role", "ADMIN")`. Protected admin servlets check if `session.getAttribute("admin")` is non-null before rendering admin views.
