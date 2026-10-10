# CampusConnect – College Event Management System

CampusConnect is a complete, professional, end-to-end **Advanced Java Web Application** built for college practical submission and viva demonstration. 

The application is engineered strictly with mandatory college technologies: **Java Servlets**, **JSP (JavaServer Pages)**, **JDBC (Java Database Connectivity)**, and **MySQL 8.0**, running on **Apache Tomcat** and built using **Maven** in **Eclipse IDE**.

---

## 📌 Project Overview

CampusConnect provides a streamlined, centralized web portal for managing college events.
- **Students** can create accounts, log in, discover upcoming technical hackathons, workshops, cultural fests, and sports events, filter by category or date, register with a single click, and manage their event registrations.
- **Administrators** can log in to a dedicated control panel to view live calculated database metrics and perform complete **CRUD (Create, Read, Update, Delete)** operations on events, as well as audit student registrations.

---

## 🛠️ Technology Stack

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Frontend** | JSP, HTML5, CSS3, JavaScript, Bootstrap 5 | Modern, responsive SaaS design, event cards, dashboard widgets, and dynamic tables. |
| **Backend** | Java Servlets (Jakarta Servlet 6.0) | HTTP request processing (`doGet`, `doPost`), session management, and routing. |
| **Database Connectivity** | JDBC | PreparedStatements for secure, SQL-injection-safe queries. |
| **Database** | MySQL 8.0+ | Relational schema (`campusconnect_db`) with normalized tables & foreign keys. |
| **Server** | Apache Tomcat 10.1+ / 9.0+ | Web servlet container. |
| **Build System** | Apache Maven | Dependency management (`pom.xml`). |
| **IDE** | Eclipse IDE for Enterprise Java and Web Developers | Development environment. |

---

## 🔑 Demo Login Credentials

### 1. Administrator Account
- **Username:** `admin`
- **Password:** `admin123`
- **Portal URL:** `http://localhost:8080/CampusConnect/admin-login`

### 2. Student Account
- **Email:** `student@campusconnect.com`
- **Password:** `student123`
- **Portal URL:** `http://localhost:8080/CampusConnect/student-login`

---

## 🗄️ Database Setup (MySQL)

1. Open **MySQL Workbench** or MySQL Command Line Client.
2. Execute the provided SQL script located in `database/campusconnect_db.sql`:
   ```sql
   SOURCE C:/path/to/project/database/campusconnect_db.sql;
   ```
3. The script automatically:
   - Creates `campusconnect_db` with `utf8mb4` encoding.
   - Creates `admin`, `students`, `events`, and `registrations` tables with primary keys, foreign keys, and unique constraints.
   - Populates initial demo accounts and sample events.

---

## ⚙️ MySQL Database Configuration

All JDBC database parameters are centralized in `src/main/resources/db.properties` and `com.campusconnect.dao.DBConnection.java`:

```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/campusconnect_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&createDatabaseIfNotExist=true
jdbc.username=root
jdbc.password=root  <-- EDIT YOUR MYSQL PASSWORD HERE
```

If your MySQL password is not `root`, update `jdbc.password` in `db.properties` or inside `DBConnection.java`:
```java
// File: src/main/java/com/campusconnect/dao/DBConnection.java
private static String DB_PASSWORD = "YOUR_MYSQL_PASSWORD";
```

---

## 🚀 Eclipse Import & Running Guide

### Step 1: Import into Eclipse
1. Open **Eclipse IDE for Enterprise Java and Web Developers**.
2. Click **File** → **Import...**
3. Select **Maven** → **Existing Maven Projects** and click **Next**.
4. Browse to the project folder (`Advance java` or `CampusConnect`) and click **Finish**.

### Step 2: Configure JDK
1. Right-click the project → **Properties** → **Java Build Path**.
2. Under **Libraries**, ensure **JRE System Library [Java SE 17]** is selected.

### Step 3: Configure Apache Tomcat
1. In Eclipse, open the **Servers** view (`Window` → `Show View` → `Servers`).
2. Right-click → **New** → **Server** → Select **Apache** → **Tomcat v10.1 Server** (or Tomcat v9.0).
3. Specify your local Tomcat installation directory.
4. Add `CampusConnect` project to the server and click **Finish**.

### Step 4: Run the Project
1. Right-click project `CampusConnect` → **Run As** → **Run on Server**.
2. Open your browser and navigate to:
   ```
   http://localhost:8080/CampusConnect/
   ```

---

## 🔄 Complete Architecture & Data Flow

```
[ Browser / Client (JSP / HTML / CSS / Bootstrap) ]
                        │
                        ▼  (HTTP GET / POST)
             [ Java Servlet Controller ]
                        │
                        ▼  (Business Logic & Validation)
               [ DAO (Data Access Object) ]
                        │
                        ▼  (JDBC PreparedStatement Queries)
                [ MySQL Database ]
```

---

## 🔁 Complete CRUD Demonstration Flow

| CRUD Operation | User Interface | Servlet | DAO / JDBC | MySQL Query |
| :--- | :--- | :--- | :--- | :--- |
| **CREATE** | `admin/add-event.jsp` | `AddEventServlet.java` | `EventDAO.addEvent()` | `INSERT INTO events (...)` |
| **READ** | `admin/manage-events.jsp` | `ManageEventsServlet.java` | `EventDAO.getAllEvents()` | `SELECT * FROM events` |
| **UPDATE** | `admin/edit-event.jsp` | `UpdateEventServlet.java` | `EventDAO.updateEvent()` | `UPDATE events SET ... WHERE event_id=?` |
| **DELETE** | `admin/manage-events.jsp` | `DeleteEventServlet.java` | `EventDAO.deleteEvent()` | `DELETE FROM events WHERE event_id=?` |

---

## 🛠️ Troubleshooting Guide

1. **MySQL Connection Failed / Access Denied:**
   - Verify MySQL server service is running.
   - Double-check password in `db.properties` / `DBConnection.java`.
2. **`jakarta.servlet` package missing on Tomcat 9:**
   - Tomcat 10.1 uses `jakarta.servlet.*`. If running on older Tomcat 9, change `jakarta.servlet` dependencies in `pom.xml` to `javax.servlet`.
3. **HTTP Status 404 - Not Found:**
   - Verify context root in Tomcat deployment path matches `/CampusConnect`.
