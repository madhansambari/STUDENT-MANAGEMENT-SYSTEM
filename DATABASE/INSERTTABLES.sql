
USE student_management_system;

INSERT INTO courses (course_name, course_fee) VALUES
('Computer Science', 45000),
('Data Science', 50000),
('Artificial Intelligence', 55000),
('Information Technology', 40000);

INSERT INTO students
(student_name, age, gender, phone, email, course_id)
VALUES
('Rahul', 21, 'Male', '9876500001', 'rahul@example.com', 1),
('Priya', 20, 'Female', '9876500002', 'priya@example.com', 2),
('Arjun', 22, 'Male', '9876500003', 'arjun@example.com', 1),
('Sneha', 21, 'Female', '9876500004', 'sneha@example.com', 3),
('Kiran', 20, 'Male', '9876500005', 'kiran@example.com', 4);

INSERT INTO marks
(student_id, subject_name, marks_obtained)
VALUES
(1, 'MySQL', 85),
(1, 'Python', 78),
(2, 'MySQL', 92),
(2, 'Python', 88),
(3, 'MySQL', 74),
(3, 'Python', 81),
(4, 'MySQL', 90),
(4, 'Python', 95),
(5, 'MySQL', 68),
(5, 'Python', 72);

USE student_management_system;

SELECT * FROM students;


SELECT
    s.student_id,
    s.student_name,
    s.age,
    c.course_name,
    c.course_fee
FROM students s
JOIN courses c
ON s.course_id = c.course_id;


SELECT * FROM students
WHERE age > 20;
