CREATE TABLE Students
(
  student_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  birth_date DATE
);

CREATE TABLE Courses 
(
course_id INT PRIMARY KEY,
  course_name VARCHAR(100),
  credits INT
);

CREATE TABLE Enrollments 
(
  enrollment_id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Grades 
(
  grade_id INT PRIMARY KEY,
  enrollment_id INT,
  grade DECIMAL(3,2),
  FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);

SELECT * FROM Students;
INSERT INTO Students VALUES
(1, 'Ivan', 'Petrov', '2004-05-12'),
(2, 'Maria', 'Ivanova', '2003-11-03'),
(3, 'Georgi', 'Dimitrov', '2004-01-20');

SELECT * FROM Courses;
INSERT INTO Courses VALUES
(101, 'Databases', 6),
(102, 'Algorithms', 5),
(103, 'OOP', 6);



