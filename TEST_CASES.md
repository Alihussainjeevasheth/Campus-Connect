# TEST CASES DOCUMENTATION
## CampusConnect – College Event Management System

**Project:** CampusConnect College Event Management System  
**Testing Scope:** Functional Verification of Servlets, JSP, JDBC, Session Management, and MySQL Database CRUD.  

---

| Test ID | Feature / Module | Test Description | Input Data | Expected Result | Status |
| :--- | :--- | :--- | :--- | :--- | :---: |
| **TC-01** | Student Registration | Register new student with valid unique details | Name: `Rahul Sharma`, Email: `rahul@test.com`, Enrollment: `EN999`, Pass: `123456` | Student record created in MySQL; Redirected to login page with success message. | **PASS** |
| **TC-02** | Student Registration | Register with existing email address | Email: `student@campusconnect.com` | Display error: "Email is already registered. Please login." | **PASS** |
| **TC-03** | Student Registration | Password mismatch check | Password: `pass1`, Confirm: `pass2` | Registration blocked; Display error: "Passwords do not match." | **PASS** |
| **TC-04** | Student Login | Login with valid student credentials | Email: `student@campusconnect.com`, Pass: `student123` | Session `student` created; Redirected to `/student-dashboard`. | **PASS** |
| **TC-05** | Student Login | Login with invalid password | Email: `student@campusconnect.com`, Pass: `wrongpass` | Login fails; Display error: "Invalid email or password." | **PASS** |
| **TC-06** | Admin Login | Login with valid admin credentials | Username: `admin`, Password: `admin123` | Session `admin` created; Redirected to `/admin-dashboard`. | **PASS** |
| **TC-07** | Admin Login | Login with incorrect password | Username: `admin`, Password: `wrongpassword` | Login fails; Display error: "Invalid username or password." | **PASS** |
| **TC-08** | Event CREATE | Admin adds a new event | Event Name: `AI Summit`, Date: `2026-11-20`, Max: `100` | New row inserted in `events` table; Redirected to `/manage-events` with success alert. | **PASS** |
| **TC-09** | Event READ | Admin views list of all events | Click "Manage Events" menu | JDBC retrieves all rows from `events` table and renders them in JSP table. | **PASS** |
| **TC-10** | Event UPDATE | Admin edits an existing event | Modify venue from `Auditorium` to `Hall A` | MySQL row updated via JDBC `UPDATE`; Table displays modified venue. | **PASS** |
| **TC-11** | Event DELETE | Admin deletes an event | Click Delete on event #5 and confirm prompt | Row deleted from `events` table; Event removed from table. | **PASS** |
| **TC-12** | Event Registration | Logged-in student registers for an event | Click "Register for Event Now" | Row inserted into `registrations` table; Button changes to "You are registered". | **PASS** |
| **TC-13** | Duplicate Registration | Student attempts to register twice for same event | Click Register again on same event | System prevents duplicate; Displays error: "You are already registered for this event." | **PASS** |
| **TC-14** | Capacity Check | Register for event with 0 available seats | Click Register when `availableSeats = 0` | Registration blocked; Displays error: "Registration Full! No seats remaining." | **PASS** |
| **TC-15** | Cancel Registration | Student cancels active registration | Click "Cancel Registration" in My Registrations | Registration status updated to `CANCELLED` in MySQL; Seats released. | **PASS** |
| **TC-16** | Unauthenticated Guard| Unauthenticated user accesses `/student-dashboard` | Direct URL navigation in browser | Intercepted/checked; Redirected to `/student-login`. | **PASS** |
| **TC-17** | Logout | User clicks Logout | Click Logout button | Session invalidated; Redirected to login page with logout notification. | **PASS** |
