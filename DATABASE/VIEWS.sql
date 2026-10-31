
-- STUDENT MANAGEMENT SYSTEM
-- TAB 5: VIEWS

USE student_management_system;

-- 1. Create a view for student and course details

CREATE OR REPLACE VIEW student_course_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    c.course_name
FROM students s
INNER JOIN courses c
ON s.course_id = c.course_id;


-- 2. Display student course details

SELECT * FROM student_course_view;


-- 3. Create a view for student marks

CREATE OR REPLACE VIEW student_marks_view AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    sub.subject_name,
    m.exam_type,
    m.marks_obtained
FROM students s
INNER JOIN marks m
ON s.student_id = m.student_id
INNER JOIN subjects sub
ON m.subject_id = sub.subject_id;


-- 4. Display student marks

SELECT * FROM student_marks_view;


-- 5. Create a view for active students

CREATE OR REPLACE VIEW active_students_view AS
SELECT
    student_id,
    first_name,
    last_name,
    email,
    student_status
FROM students
WHERE student_status = 'Active';


-- 6. Display active students

SELECT * FROM active_students_view;
