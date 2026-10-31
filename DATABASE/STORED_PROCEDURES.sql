
-- ================================================
-- STUDENT MANAGEMENT SYSTEM
-- TAB 6: STORED PROCEDURES
-- ================================================

USE student_management_system;


-- 1. PROCEDURE TO DISPLAY ALL STUDENTS

DROP PROCEDURE IF EXISTS GetAllStudents;

DELIMITER //

CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT
        student_id,
        first_name,
        last_name,
        email,
        age,
        student_status
    FROM students;
END //

DELIMITER ;


-- 2. PROCEDURE TO DISPLAY STUDENT DETAILS BY ID

DROP PROCEDURE IF EXISTS GetStudentByID;

DELIMITER //

CREATE PROCEDURE GetStudentByID(IN p_student_id INT)
BEGIN
    SELECT
        s.student_id,
        s.first_name,
        s.last_name,
        s.email,
        s.age,
        c.course_name
    FROM students s
    INNER JOIN courses c
    ON s.course_id = c.course_id
    WHERE s.student_id = p_student_id;
END //

DELIMITER ;


-- 3. PROCEDURE TO DISPLAY STUDENTS BY COURSE

DROP PROCEDURE IF EXISTS GetStudentsByCourse;

DELIMITER //

CREATE PROCEDURE GetStudentsByCourse(IN p_course_id INT)
BEGIN
    SELECT
        student_id,
        first_name,
        last_name,
        email,
        course_id
    FROM students
    WHERE course_id = p_course_id;
END //

DELIMITER ;


-- ================================================
-- 4. EXECUTE THE STORED PROCEDURES
-- ================================================

-- Display all students
CALL GetAllStudents();

-- Display student with ID 1
CALL GetStudentByID(1);

-- Display students enrolled in course ID 1
CALL GetStudentsByCourse(1);


-- ================================================
-- 5. VERIFY STORED PROCEDURES
-- ================================================

SHOW PROCEDURE STATUS
WHERE Db = 'student_management_system';

-- ================================================
-- END OF TAB 6
-- ================================================
