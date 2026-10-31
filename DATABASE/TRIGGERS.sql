
-- ================================================
-- STUDENT MANAGEMENT SYSTEM
-- TAB 8: TRIGGERS
-- ================================================

USE student_management_system;


-- 1. CREATE MARKS AUDIT TABLE

CREATE TABLE IF NOT EXISTS marks_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    mark_id INT NOT NULL,
    student_id INT NOT NULL,
    action_type VARCHAR(20) NOT NULL,
    old_marks DECIMAL(5,2),
    new_marks DECIMAL(5,2),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- 2. CREATE AFTER INSERT TRIGGER

DROP TRIGGER IF EXISTS AfterMarksInsert;

DELIMITER //

CREATE TRIGGER AfterMarksInsert
AFTER INSERT ON marks
FOR EACH ROW
BEGIN
    INSERT INTO marks_audit
    (mark_id, student_id, action_type, old_marks, new_marks)
    VALUES
    (NEW.mark_id, NEW.student_id, 'INSERT', NULL, NEW.marks_obtained);
END //

DELIMITER ;


-- 3. CREATE AFTER UPDATE TRIGGER

DROP TRIGGER IF EXISTS AfterMarksUpdate;

DELIMITER //

CREATE TRIGGER AfterMarksUpdate
AFTER UPDATE ON marks
FOR EACH ROW
BEGIN
    INSERT INTO marks_audit
    (mark_id, student_id, action_type, old_marks, new_marks)
    VALUES
    (NEW.mark_id, NEW.student_id, 'UPDATE',
     OLD.marks_obtained, NEW.marks_obtained);
END //

DELIMITER ;


-- 4. TEST INSERT TRIGGER
-- Insert a new marks record for student 1

INSERT INTO marks
(student_id, subject_id, exam_type, marks_obtained, exam_date)
VALUES
(1, 1, 'Final Exam', 95, '2026-03-20');


-- 5. TEST UPDATE TRIGGER
-- Update the newly inserted marks

UPDATE marks
SET marks_obtained = 98
WHERE student_id = 1
AND subject_id = 1
AND exam_type = 'Final Exam';


-- 6. DISPLAY AUDIT RECORDS

SELECT * FROM marks_audit;


-- 7. VERIFY TRIGGERS

SHOW TRIGGERS;


-- ================================================
-- END OF TAB 8
-- ================================================
