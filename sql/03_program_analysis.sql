-- ============================================================
-- LEARNER ENGAGEMENT ANALYTICS
-- 03 - PROGRAM PERFORMANCE ANALYSIS
-- Database: learner_analytics
-- Table: learner_enrollments
-- ============================================================


-- 1. Overall performance by program
SELECT
    program_name,
    COUNT(*) AS enrollments,
    COUNT(*) FILTER (WHERE completed_flag = 1) AS completed_enrollments,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    ROUND(AVG(attendance_rate) * 100, 2) AS average_attendance_pct,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement
FROM learner_enrollments
GROUP BY program_name
ORDER BY completion_rate_pct DESC;


-- 2. Program ranking by completion rate
WITH program_metrics AS (
    SELECT
        program_name,
        COUNT(*) AS enrollments,
        AVG(completed_flag) * 100 AS completion_rate
    FROM learner_enrollments
    GROUP BY program_name
)
SELECT
    program_name,
    enrollments,
    ROUND(completion_rate, 2) AS completion_rate_pct,
    RANK() OVER (
        ORDER BY completion_rate DESC
    ) AS completion_rank
FROM program_metrics
ORDER BY completion_rank;


-- 3. Program ranking by attendance
WITH program_attendance AS (
    SELECT
        program_name,
        COUNT(*) AS enrollments,
        AVG(attendance_rate) * 100 AS attendance_rate
    FROM learner_enrollments
    GROUP BY program_name
)
SELECT
    program_name,
    enrollments,
    ROUND(attendance_rate, 2) AS attendance_rate_pct,
    RANK() OVER (
        ORDER BY attendance_rate DESC
    ) AS attendance_rank
FROM program_attendance
ORDER BY attendance_rank;


-- 4. Program ranking by learning improvement
WITH program_scores AS (
    SELECT
        program_name,
        COUNT(*) AS enrollments,
        AVG(pre_score) AS average_pre_score,
        AVG(post_score) AS average_post_score,
        AVG(score_improvement) AS average_improvement
    FROM learner_enrollments
    GROUP BY program_name
)
SELECT
    program_name,
    enrollments,
    ROUND(average_pre_score, 2) AS average_pre_score,
    ROUND(average_post_score, 2) AS average_post_score,
    ROUND(average_improvement, 2) AS average_score_improvement,
    RANK() OVER (
        ORDER BY average_improvement DESC
    ) AS improvement_rank
FROM program_scores
ORDER BY improvement_rank;


-- 5. Program support demand
SELECT
    program_name,
    COUNT(*) AS enrollments,
    SUM(ticket_count) AS total_support_tickets,
    ROUND(AVG(ticket_count), 2) AS average_tickets_per_enrollment,
    ROUND(AVG(avg_resolution_hours), 2) AS average_resolution_hours,
    ROUND(AVG(support_sla_rate) * 100, 2) AS support_sla_rate_pct
FROM learner_enrollments
GROUP BY program_name
ORDER BY total_support_tickets DESC;


-- 6. Program satisfaction and recommendation
SELECT
    program_name,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction,
    ROUND(AVG(recommendation_score), 2) AS average_recommendation_score,
    COUNT(*) AS enrollments
FROM learner_enrollments
GROUP BY program_name
ORDER BY average_satisfaction DESC;


-- 7. Identify programs below the overall completion rate
WITH overall AS (
    SELECT
        AVG(completed_flag) * 100 AS overall_completion_rate
    FROM learner_enrollments
),
programs AS (
    SELECT
        program_name,
        COUNT(*) AS enrollments,
        AVG(completed_flag) * 100 AS completion_rate
    FROM learner_enrollments
    GROUP BY program_name
)
SELECT
    p.program_name,
    p.enrollments,
    ROUND(p.completion_rate, 2) AS completion_rate_pct,
    ROUND(o.overall_completion_rate, 2) AS overall_completion_rate_pct,
    ROUND(p.completion_rate - o.overall_completion_rate, 2) AS difference_from_overall_pct
FROM programs p
CROSS JOIN overall o
WHERE p.completion_rate < o.overall_completion_rate
ORDER BY p.completion_rate;