-- 03_gpa_by_department.sql
-- Simple GPA by department based on course percentage

WITH student_course_scores AS (
  SELECT
    c.department,
    s.student_id,
    SUM(g.points_earned) AS total_points,
    SUM(a.max_points)    AS total_max_points,
    100.0 * SUM(g.points_earned) / SUM(a.max_points) AS pct_score
  FROM enrollments e
  JOIN students   s ON s.student_id = e.student_id
  JOIN courses    c ON c.course_id = e.course_id
  JOIN assignments a ON a.course_id = c.course_id
  JOIN grades      g ON g.student_id = s.student_id
                     AND g.assignment_id = a.assignment_id
  GROUP BY c.department, s.student_id
),
student_course_gpa AS (
  SELECT
    department,
    student_id,
    CASE
      WHEN pct_score >= 90 THEN 4.0
      WHEN pct_score >= 80 THEN 3.0
      WHEN pct_score >= 70 THEN 2.0
      WHEN pct_score >= 60 THEN 1.0
      ELSE 0.0
    END AS grade_points
  FROM student_course_scores
)
SELECT
  department,
  ROUND(AVG(grade_points), 2) AS avg_gpa
FROM student_course_gpa
GROUP BY department
ORDER BY department;
