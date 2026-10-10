-- ====================================================================
-- CampusConnect - College Event Management System
-- MySQL Database Script (Pure Servlets + JSP + JDBC)
-- Database Name: campusconnect_db
-- Compatibility: MySQL 8.0+
-- ====================================================================

DROP DATABASE IF EXISTS campusconnect_db;
CREATE DATABASE campusconnect_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campusconnect_db;

-- --------------------------------------------------------------------
-- 1. ADMIN TABLE
-- --------------------------------------------------------------------
CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------------------
-- 2. STUDENTS TABLE
-- --------------------------------------------------------------------
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    enrollment_no VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL,
    semester VARCHAR(20) NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------------------
-- 3. EVENTS TABLE
-- --------------------------------------------------------------------
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50) NOT NULL, -- Technical, Cultural, Sports, Workshop, Seminar, Competition, Other
    venue VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time VARCHAR(20) NOT NULL,
    organizer VARCHAR(100) NOT NULL,
    max_participants INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Upcoming', -- Upcoming, Completed, Cancelled
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------------------
-- 4. REGISTRATIONS TABLE
-- --------------------------------------------------------------------
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    event_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'REGISTERED', -- REGISTERED, CANCELLED
    CONSTRAINT fk_reg_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_reg_event FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    CONSTRAINT uq_student_event UNIQUE (student_id, event_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ====================================================================
-- SEED / SAMPLE DATA INSERTS
-- ====================================================================

-- Demo Admin (username: admin, password: admin123)
INSERT INTO admin (username, password) VALUES 
('admin', 'admin123');

-- Demo Students (password: student123)
INSERT INTO students (name, email, password, enrollment_no, department, semester) VALUES
('Aarav Patel', 'student@campusconnect.com', 'student123', 'EN2023CSE0101', 'Computer Science & Engineering', '6th Semester'),
('Rahul Sharma', 'rahul.sharma@campusconnect.com', 'student123', 'EN2023IT0045', 'Information Technology', '6th Semester'),
('Ananya Verma', 'ananya.verma@campusconnect.com', 'student123', 'EN2024ECE0089', 'Electronics & Communication', '4th Semester');

-- Sample Events
INSERT INTO events (event_name, description, category, venue, event_date, event_time, organizer, max_participants, status) VALUES
('Hackathon 2026: Code for Impact', 'Join us for an intense 24-hour hackathon where students build innovative software solutions for real-world campus and social problems. Cash prizes worth Rs. 50,000!', 'Hackathon', 'Main Campus Auditorium', '2026-10-15', '09:00 AM', 'CSE Department & Tech Club', 100, 'Upcoming'),
('AI & Machine Learning Workshop', 'A hands-on expert workshop covering Deep Learning, Natural Language Processing, and Neural Networks with practical Python live coding exercises.', 'Workshop', 'Seminar Hall 2, Science Block', '2026-10-20', '10:00 AM', 'Department of AI & Data Science', 60, 'Upcoming'),
('Sanskriti 2026 - Annual Cultural Fest', 'Experience the grandest cultural celebration of our institute! Includes music bands, classical and western dance competitions, fashion show, and street play.', 'Cultural', 'Open Air Theatre (OAT)', '2026-11-05', '05:00 PM', 'Student Council', 500, 'Upcoming'),
('Inter-College Robotics Championship', 'Design, build, and race autonomous and manual robots in obstacle courses and robo-wars arena.', 'Competition', 'Indoor Sports Complex', '2026-10-28', '09:30 AM', 'Robotics Society', 40, 'Upcoming'),
('Cloud Computing & DevOps Masterclass', 'Industry expert seminar on AWS, Docker, Kubernetes, and CI/CD pipelines in modern enterprise software engineering.', 'Seminar', 'Virtual Conference Room', '2026-09-15', '11:00 AM', 'Training & Placement Cell', 150, 'Completed');

-- Sample Event Registrations
INSERT INTO registrations (student_id, event_id, registration_date, status) VALUES
(1, 1, '2026-09-25 10:30:00', 'REGISTERED'),
(1, 5, '2026-09-10 14:15:00', 'REGISTERED'),
(2, 1, '2026-09-26 11:00:00', 'REGISTERED'),
(2, 2, '2026-09-27 09:45:00', 'REGISTERED');

-- Verification Query
SELECT 'Admin Accounts' AS Table_Name, COUNT(*) FROM admin
UNION ALL
SELECT 'Students', COUNT(*) FROM students
UNION ALL
SELECT 'Events', COUNT(*) FROM events
UNION ALL
SELECT 'Registrations', COUNT(*) FROM registrations;
