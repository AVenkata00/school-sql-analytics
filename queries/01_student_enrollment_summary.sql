-- 01_student_enrollment_summary.sql
-- How many courses each student is taking in Fall 2024

SELECT
  s.student_id,
  s.first_name,
  s.last_name,
  COUNT(e.course_id) AS num_courses
FROM students s
LEFT JOIN enrollments e
  ON s.student_id = e.student_id
WHERE e.term = 'Fall 2024'
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY num_courses DESC, s.last_name, s.first_name;
