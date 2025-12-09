-- 04_at_risk_students.sql
-- Students whose overall percentage across all graded work is below 70%

WITH student_overall AS (
  SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    SUM(g.points_earned) AS total_points,
    SUM(a.max_points)    AS total_max_points,
    100.0 * SUM(g.points_earned) / SUM(a.max_points) AS pct_score
  FROM students s
  JOIN grades g       ON g.student_id = s.student_id
  JOIN assignments a  ON a.assignment_id = g.assignment_id
  GROUP BY s.student_id, s.first_name, s.last_name
)
SELECT
  student_id,
  first_name,
  last_name,
  ROUND(pct_score, 1) AS overall_pct
FROM student_overall
WHERE pct_score < 70
ORDER BY pct_score;
