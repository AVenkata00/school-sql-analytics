-- 05_teacher_class_load.sql
-- How many students and courses each teacher has per term

SELECT
  e.term,
  c.teacher,
  COUNT(DISTINCT e.student_id) AS num_students,
  COUNT(DISTINCT e.course_id)  AS num_courses_taught
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
GROUP BY e.term, c.teacher
ORDER BY e.term, c.teacher;
