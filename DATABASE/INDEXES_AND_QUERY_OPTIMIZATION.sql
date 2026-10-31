
-- ================================================
-- STUDENT MANAGEMENT SYSTEM
-- TAB 10: INDEXES AND QUERY OPTIMIZATION
-- ================================================

USE student_management_system;


-- 1. CREATE INDEX ON STUDENT STATUS

CREATE INDEX idx_student_status
ON students(student_status);


-- 2. CREATE COMPOSITE INDEX ON STUDENTS

CREATE INDEX idx_student_status_course
ON students(student_status, course_id);


-- 3. CREATE INDEX ON MARKS

CREATE INDEX idx_marks_subject_marks
ON marks(subject_id, marks_obtained);


-- 4. CREATE COMPOSITE INDEX ON ATTENDANCE

CREATE INDEX idx_attendance_date_status
ON attendance(attendance_date, attendance_status);


-- ================================================
-- 5. VIEW ALL INDEXES ON STUDENTS TABLE
-- ================================================

SHOW INDEX FROM students;


-- 6. VIEW ALL INDEXES ON MARKS TABLE

SHOW INDEX FROM marks;


-- 7. VIEW ALL INDEXES ON ATTENDANCE TABLE

SHOW INDEX FROM attendance;


-- ================================================
-- 8. EXPLAIN: ANALYSE STUDENT SEARCH QUERY
-- ================================================

EXPLAIN
SELECT *
FROM students
WHERE student_status = 'Active';


-- ================================================
-- 9. EXPLAIN: ANALYSE MARKS SEARCH QUERY
-- ================================================

EXPLAIN
SELECT *
FROM marks
WHERE subject_id = 1
AND marks_obtained > 80;


-- ================================================
-- 10. EXPLAIN: ANALYSE ATTENDANCE QUERY
-- ================================================

EXPLAIN
SELECT *
FROM attendance
WHERE attendance_date = '2026-03-01'
AND attendance_status = 'Present';


-- ================================================
-- 11. COUNT STUDENTS BY STATUS
-- ================================================

SELECT
    student_status,
    COUNT(*) AS total_students
FROM students
GROUP BY student_status;


-- ================================================
-- END OF TAB 10
-- ================================================
