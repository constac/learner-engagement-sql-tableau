-- ============================================================
-- LEARNER ENGAGEMENT ANALYTICS
-- 02 - CORE KPI ANALYSIS
-- Database: learner_analytics
-- Table: learner_enrollments
-- ============================================================


-- 1. Overall dataset KPIs
SELECT
    COUNT(*) AS total_enrollments,
    COUNT(DISTINCT participant_id) AS unique_learners,
    ROUND(AVG(attendance_rate) * 100, 2) AS average_attendance_pct,
    ROUND(AVG(completed_flag) * 100, 2) AS average_completion_pct,
    ROUND(AVG(pre_score), 2) AS average_pre_score,
    ROUND(AVG(post_score), 2) AS average_post_score,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction_score,
    ROUND(AVG(recommendation_score), 2) AS average_recommendation_score,
    SUM(ticket_count) AS total_support_tickets,
    ROUND(AVG(avg_resolution_hours), 2) AS average_resolution_hours,
    ROUND(AVG(support_sla_rate) * 100, 2) AS average_support_sla_pct
FROM learner_enrollments;


-- 2. Completion performance
SELECT
    completion_status,
    COUNT(*) AS enrollments,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_enrollments
FROM learner_enrollments
GROUP BY completion_status
ORDER BY enrollments DESC;


-- 3. Completed versus not completed
SELECT
    completed_flag,
    COUNT(*) AS enrollments,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_enrollments
FROM learner_enrollments
GROUP BY completed_flag
ORDER BY completed_flag DESC;


-- 4. Overall score improvement
SELECT
    ROUND(AVG(pre_score), 2) AS average_pre_score,
    ROUND(AVG(post_score), 2) AS average_post_score,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement
FROM learner_enrollments;


-- 5. Learner satisfaction
SELECT
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction_score,
    ROUND(AVG(recommendation_score), 2) AS average_recommendation_score
FROM learner_enrollments;


-- 6. Support operations
SELECT
    SUM(ticket_count) AS total_support_tickets,
    ROUND(AVG(ticket_count), 2) AS average_tickets_per_enrollment,
    ROUND(AVG(avg_resolution_hours), 2) AS average_resolution_hours,
    ROUND(AVG(support_sla_rate) * 100, 2) AS average_support_sla_pct
FROM learner_enrollments;