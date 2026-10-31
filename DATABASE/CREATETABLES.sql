
USE student_management_system;

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_fee DECIMAL(10,2) NOT NULL
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    course_id INT,
    admission_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);


SHOW TABLES;

