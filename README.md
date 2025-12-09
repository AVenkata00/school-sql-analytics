# school-sql-analytics
This is a SQL portfolio project analyzing student enrollment, course performance, and at-risk indicators using realistic school SIS-format data. This is the typical LTI 1.3 format for rosters.

# School Enrollment & Performance Analytics (SQL)

A small SQL portfolio project that simulates a Chicago-area high school and explores:

- Student enrollment patterns  
- Course performance and pass rates  
- Department-level GPA  
- At-risk students  
- Teacher class loads  

The dataset uses **multicultural, Midwest-style names** and a simple SIS-like schema that mirrors real EdTech work.

---

## Schema

Tables:

- **students**  
  - `student_id` (PK)  
  - `first_name`  
  - `last_name`  
  - `grade_level`

- **courses**  
  - `course_id` (PK)  
  - `course_name`  
  - `department`  
  - `teacher`

- **enrollments**  
  - `enrollment_id` (PK)  
  - `student_id` → `students.student_id`  
  - `course_id` → `courses.course_id`  
  - `term` (e.g., `Fall 2024`)

- **assignments**  
  - `assignment_id` (PK)  
  - `course_id` → `courses.course_id`  
  - `assignment_name`  
  - `max_points`

- **grades**  
  - `student_id` → `students.student_id`  
  - `assignment_id` → `assignments.assignment_id`  
  - `points_earned`  
  - PK: (`student_id`, `assignment_id`)

---

## How to Run

You can use any relational database (PostgreSQL, MySQL, SQLite, etc.). Example using SQLite:

```bash
sqlite3 school.db
.read schema.sql
.mode csv
.import data/students.csv students
.import data/courses.csv courses
.import data/enrollments.csv enrollments
.import data/assignments.csv assignments
.import data/grades.csv grades
