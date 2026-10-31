
-- =====================================================
-- STUDENT MANAGEMENT SYSTEM
-- TAB 11: BUSINESS REPORTS AND STUDENT ANALYSIS
-- =====================================================

USE student_management_system;


-- =====================================================
-- SECTION 1: GENERAL REPORTS
-- =====================================================

-- 1. Total number of students

SELECT COUNT(*) AS total_students
FROM students;


-- 2. Total number of courses

SELECT COUNT(*) AS total_courses
FROM courses;


-- 3. Total number of departments

SELECT COUNT(*) AS total_departments
FROM departments;


-- 4. Count students by status

SELECT
    student_status,
    COUNT(*) AS total_students
FROM students
GROUP BY student_status;


-- =====================================================
-- SECTION 2: DEPARTMENT AND COURSE REPORTS
-- =====================================================

-- 5. Department-wise student count

SELECT
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN courses c
    ON d.department_id = c.department_id
LEFT JOIN students s
    ON c.course_id = s.course_id
GROUP BY d.department_id, d.department_name;


-- 6. Course-wise student count

SELECT
    c.course_name,
    COUNT(s.student_id) AS total_students
FROM courses c
LEFT JOIN students s
    ON c.course_id = s.course_id
GROUP BY c.course_id, c.course_name;


-- 7. Find courses having more than one student

SELECT
    c.course_name,
    COUNT(s.student_id) AS total_students
FROM courses c
INNER JOIN students s
    ON c.course_id = s.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(s.student_id) > 1;


-- 8. Display course fees from highest to lowest

SELECT
    course_name,
    course_fee
FROM courses
ORDER BY course_fee DESC;


-- =====================================================
-- SECTION 3: STUDENT PERFORMANCE REPORTS
-- =====================================================

-- 9. Top 5 students based on average marks

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_marks DESC
LIMIT 5;


-- 10. Student with the highest marks

SELECT
    s.first_name,
    s.last_name,
    m.marks_obtained,
    sub.subject_name
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id
INNER JOIN subjects sub
    ON m.subject_id = sub.subject_id
WHERE m.marks_obtained = (
    SELECT MAX(marks_obtained)
    FROM marks
);


-- 11. Student with the lowest marks

SELECT
    s.first_name,
    s.last_name,
    m.marks_obtained,
    sub.subject_name
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id
INNER JOIN subjects sub
    ON m.subject_id = sub.subject_id
WHERE m.marks_obtained = (
    SELECT MIN(marks_obtained)
    FROM marks
);


-- 12. Second-highest distinct marks

SELECT MAX(marks_obtained) AS second_highest_marks
FROM marks
WHERE marks_obtained < (
    SELECT MAX(marks_obtained)
    FROM marks
);


-- 13. Subject-wise average marks

SELECT
    sub.subject_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM subjects sub
INNER JOIN marks m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name
ORDER BY average_marks DESC;


-- 14. Students with average marks above 85

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING AVG(m.marks_obtained) > 85;


-- 15. Display student performance categories

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks,
    CASE
        WHEN AVG(m.marks_obtained) >= 90 THEN 'Excellent'
        WHEN AVG(m.marks_obtained) >= 75 THEN 'Very Good'
        WHEN AVG(m.marks_obtained) >= 60 THEN 'Good'
        WHEN AVG(m.marks_obtained) >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS performance
FROM students s
INNER JOIN marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_marks DESC;


-- =====================================================
-- SECTION 4: ATTENDANCE REPORTS
-- =====================================================

-- 16. Total attendance records by status

SELECT
    attendance_status,
    COUNT(*) AS total_records
FROM attendance
GROUP BY attendance_status;


-- 17. Student-wise attendance summary

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(a.attendance_id) AS total_classes,
    SUM(a.attendance_status = 'Present') AS present_days,
    SUM(a.attendance_status = 'Absent') AS absent_days,
    SUM(a.attendance_status = 'Late') AS late_days
FROM students s
LEFT JOIN attendance a
    ON s.student_id = a.student_id
GROUP BY s.student_id, s.first_name, s.last_name;


-- 18. Calculate student attendance percentage

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(
        100.0 * SUM(a.attendance_status = 'Present')
        / NULLIF(COUNT(a.attendance_id), 0),
        2
    ) AS attendance_percentage
FROM students s
LEFT JOIN attendance a
    ON s.student_id = a.student_id
GROUP BY s.student_id, s.first_name, s.last_name;


-- 19. Find students with attendance below 75%

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    ROUND(
        100.0 * SUM(a.attendance_status = 'Present')
        / NULLIF(COUNT(a.attendance_id), 0),
        2
    ) AS attendance_percentage
FROM students s
INNER JOIN attendance a
    ON s.student_id = a.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING attendance_percentage < 75;


-- =====================================================
-- SECTION 5: MONTHLY REPORTS
-- =====================================================

-- 20. Monthly examination report

SELECT
    DATE_FORMAT(exam_date, '%Y-%m') AS exam_month,
    COUNT(*) AS total_exams,
    ROUND(AVG(marks_obtained), 2) AS average_marks
FROM marks
WHERE exam_date IS NOT NULL
GROUP BY DATE_FORMAT(exam_date, '%Y-%m')
ORDER BY exam_month;


-- 21. Monthly attendance report

SELECT
    DATE_FORMAT(attendance_date, '%Y-%m') AS attendance_month,
    COUNT(*) AS total_records,
    SUM(attendance_status = 'Present') AS present_records,
    SUM(attendance_status = 'Absent') AS absent_records
FROM attendance
GROUP BY DATE_FORMAT(attendance_date, '%Y-%m')
ORDER BY attendance_month;


-- =====================================================
-- SECTION 6: COMBINED MANAGEMENT REPORT
-- =====================================================

-- 22. Student details with course, department and average marks

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS student_name,
    c.course_name,
    d.department_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
INNER JOIN courses c
    ON s.course_id = c.course_id
INNER JOIN departments d
    ON c.department_id = d.department_id
LEFT JOIN marks m
    ON s.student_id = m.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    d.department_name
ORDER BY average_marks DESC;


-- =====================================================
-- END OF TAB 11
-- TOTAL: 22 BUSINESS REPORT QUERIES
-- =====================================================
