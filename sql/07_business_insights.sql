-- ============================================================
-- 07_business_insights.sql
-- Final Business Insights
-- Purpose: Answer key management questions using SQL.
-- ============================================================


-- ============================================================
-- Q1. Which programs have the strongest and weakest completion?
-- ============================================================

SELECT
    program_name,
    COUNT(*) AS enrollments,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    RANK() OVER (
        ORDER BY AVG(completed_flag) DESC
    ) AS completion_rank
FROM learner_enrollments
GROUP BY program_name
ORDER BY completion_rank;


-- ============================================================
-- Q2. Which learner risk groups require intervention?
-- ============================================================

SELECT
    risk_band,
    COUNT(*) AS enrollments,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    ROUND(AVG(attendance_rate) * 100, 2) AS attendance_rate_pct,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement
FROM learner_enrollments
GROUP BY risk_band
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- Q3. Which combined learner segment has the greatest
-- intervention need?
-- ============================================================

SELECT
    digital_confidence,
    risk_band,
    COUNT(*) AS enrollments,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    ROUND(AVG(attendance_rate) * 100, 2) AS attendance_rate_pct,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement
FROM learner_enrollments
GROUP BY
    digital_confidence,
    risk_band
HAVING COUNT(*) >= 20
ORDER BY completion_rate_pct ASC
LIMIT 3;


-- ============================================================
-- Q4. How does delivery mode relate to learner completion?
-- ============================================================

SELECT
    delivery_mode,
    COUNT(*) AS enrollments,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    ROUND(AVG(attendance_rate) * 100, 2) AS attendance_rate_pct,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement
FROM learner_enrollments
GROUP BY delivery_mode
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- Q5. Which programs combine lower completion with
-- weaker learner experience?
-- ============================================================

WITH program_metrics AS (
    SELECT
        program_name,
        COUNT(*) AS enrollments,
        AVG(completed_flag) * 100 AS completion_rate_pct,
        AVG(attendance_rate) * 100 AS attendance_rate_pct,
        AVG(satisfaction_score) AS satisfaction_score
    FROM learner_enrollments
    GROUP BY program_name
)
SELECT
    program_name,
    enrollments,
    ROUND(completion_rate_pct, 2) AS completion_rate_pct,
    ROUND(attendance_rate_pct, 2) AS attendance_rate_pct,
    ROUND(satisfaction_score, 2) AS satisfaction_score
FROM program_metrics
WHERE completion_rate_pct < 82.19
ORDER BY completion_rate_pct ASC;


-- ============================================================
-- Q6. Create a management priority classification
-- ============================================================

WITH segment_metrics AS (
    SELECT
        digital_confidence,
        risk_band,
        COUNT(*) AS enrollments,
        AVG(completed_flag) * 100 AS completion_rate_pct,
        AVG(attendance_rate) * 100 AS attendance_rate_pct
    FROM learner_enrollments
    GROUP BY
        digital_confidence,
        risk_band
)
SELECT
    digital_confidence,
    risk_band,
    enrollments,
    ROUND(completion_rate_pct, 2) AS completion_rate_pct,
    ROUND(attendance_rate_pct, 2) AS attendance_rate_pct,
    CASE
        WHEN completion_rate_pct < 50
             AND attendance_rate_pct < 50
            THEN 'Priority 1 - Immediate intervention'

        WHEN completion_rate_pct < 70
             OR attendance_rate_pct < 70
            THEN 'Priority 2 - Targeted intervention'

        ELSE 'Priority 3 - Monitor'
    END AS management_priority
FROM segment_metrics
WHERE enrollments >= 20
ORDER BY completion_rate_pct ASC;


-- ============================================================
-- Q7. Overall management KPI summary
-- ============================================================

SELECT
    COUNT(*) AS total_enrollments,
    COUNT(DISTINCT participant_id) AS unique_learners,
    ROUND(AVG(completed_flag) * 100, 2) AS completion_rate_pct,
    ROUND(AVG(attendance_rate) * 100, 2) AS attendance_rate_pct,
    ROUND(AVG(score_improvement), 2) AS average_score_improvement,
    ROUND(AVG(satisfaction_score), 2) AS average_satisfaction_score,
    SUM(ticket_count) AS total_support_tickets
FROM learner_enrollments;