
-- ================================================
-- STUDENT MANAGEMENT SYSTEM
-- TAB 9: TRANSACTIONS
-- ================================================

USE student_management_system;


-- 1. CREATE A TABLE FOR TRANSACTION DEMONSTRATION

CREATE TABLE IF NOT EXISTS transaction_demo (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ================================================
-- 2. COMMIT EXAMPLE
-- COMMIT SAVES CHANGES PERMANENTLY
-- ================================================

START TRANSACTION;

INSERT INTO transaction_demo (description)
VALUES ('Transaction committed successfully');

COMMIT;

-- Verify committed record
SELECT * FROM transaction_demo;


-- ================================================
-- 3. ROLLBACK EXAMPLE
-- ROLLBACK CANCELS UNCOMMITTED CHANGES
-- ================================================

START TRANSACTION;

INSERT INTO transaction_demo (description)
VALUES ('This record will be rolled back');

ROLLBACK;

-- Verify: rolled-back record should not appear
SELECT * FROM transaction_demo;


-- ================================================
-- 4. SAVEPOINT EXAMPLE
-- ================================================

START TRANSACTION;

INSERT INTO transaction_demo (description)
VALUES ('Record before savepoint');

SAVEPOINT my_savepoint;

INSERT INTO transaction_demo (description)
VALUES ('Record after savepoint');

ROLLBACK TO SAVEPOINT my_savepoint;

COMMIT;

-- Verify final records
SELECT * FROM transaction_demo;


-- ================================================
-- 5. TRANSACTION WITH UPDATE
-- ================================================

START TRANSACTION;

UPDATE students
SET student_status = 'Inactive'
WHERE student_id = 1;

-- Check temporary change
SELECT student_id, first_name, student_status
FROM students
WHERE student_id = 1;

-- Cancel the update
ROLLBACK;

-- Verify original status
SELECT student_id, first_name, student_status
FROM students
WHERE student_id = 1;


-- ================================================
-- END OF TAB 9
-- ================================================
