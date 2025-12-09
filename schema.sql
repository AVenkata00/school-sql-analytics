-- schema.sql
-- School Enrollment & Performance Analytics

DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

CREATE TABLE students (
  student_id   INT PRIMARY KEY,
  first_name   VARCHAR(50),
  last_name    VARCHAR(50),
  grade_level  INT
);

CREATE TABLE courses (
  course_id    INT PRIMARY KEY,
  course_name  VARCHAR(100),
  department   VARCHAR(50),
  teacher      VARCHAR(100)
);

CREATE TABLE enrollments (
  enrollment_id INT PRIMARY KEY,
  student_id    INT REFERENCES students(student_id),
  course_id     INT REFERENCES courses(course_id),
  term          VARCHAR(50)
);

CREATE TABLE assignments (
  assignment_id   INT PRIMARY KEY,
  course_id       INT REFERENCES courses(course_id),
  assignment_name VARCHAR(100),
  max_points      INT
);

CREATE TABLE grades (
  student_id     INT REFERENCES students(student_id),
  assignment_id  INT REFERENCES assignments(assignment_id),
  points_earned  INT,
  PRIMARY KEY (student_id, assignment_id)
);
