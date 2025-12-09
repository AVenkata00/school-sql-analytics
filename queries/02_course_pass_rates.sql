-- 02_course_pass_rates.sql
-- Pass rate per course in Fall 2024 (pass = avg >= 70%)

WITH student_course_scores AS (
  SELECT
    e.term,
    c.course_id,
    c.course_name,
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
  WHERE e.term = 'Fall 2024'
  GROUP BY e.term, c.course_id, c.course_name, s.student_id
),
course_pass_rates AS (
  SELECT
    term,
    course_id,
    course_name,
    COUNT(*) AS num_students,
    SUM(CASE WHEN pct_score >= 70 THEN 1 ELSE 0 END) AS num_passing
  FROM student_course_scores
  GROUP BY term, course_id, course_name
)
SELECT
  term,
  course_id,
  course_name,
  num_students,
  num_passing,
  ROUND(100.0 * num_passing / NULLIF(num_students, 0), 1) AS pass_rate_pct
FROM course_pass_rates
ORDER BY course_id;
