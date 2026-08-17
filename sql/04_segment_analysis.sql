-- ============================================================
-- 04_segment_analysis.sql
-- Learner Segmentation Analysis
-- Purpose: Identify learner segments associated with
-- completion, attendance and learning outcomes.
-- ============================================================


-- ============================================================
-- 1. PERFORMANCE BY DIGITAL CONFIDENCE
-- ============================================================

SELECT
    digital_confidence,
    COUNT(*) AS enrollments,
    COUNT(*) FILTER (WHERE completed_flag = 1) AS completed_enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY digital_confidence
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- 2. PERFORMANCE BY DELIVERY MODE
-- ============================================================

SELECT
    delivery_mode,
    COUNT(*) AS enrollments,
    COUNT(*) FILTER (WHERE completed_flag = 1) AS completed_enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY delivery_mode
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- 3. PERFORMANCE BY AGE BAND
-- ============================================================

SELECT
    age_band,
    COUNT(*) AS enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY age_band
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- 4. PERFORMANCE BY EMPLOYMENT STATUS
-- ============================================================

SELECT
    employment_status,
    COUNT(*) AS enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY employment_status
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- 5. PERFORMANCE BY RISK BAND
-- ============================================================

SELECT
    risk_band,
    COUNT(*) AS enrollments,
    COUNT(*) FILTER (WHERE completed_flag = 1) AS completed_enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY risk_band
ORDER BY completion_rate_pct DESC;


-- ============================================================
-- 6. DIGITAL CONFIDENCE + RISK BAND
-- Identify combinations that may require intervention.
-- ============================================================

SELECT
    digital_confidence,
    risk_band,
    COUNT(*) AS enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY
    digital_confidence,
    risk_band
HAVING COUNT(*) >= 20
ORDER BY
    completion_rate_pct ASC;


-- ============================================================
-- 7. ACQUISITION CHANNEL PERFORMANCE
-- ============================================================

SELECT
    acquisition_channel,
    COUNT(*) AS enrollments,
    ROUND(
        AVG(completed_flag) * 100,
        2
    ) AS completion_rate_pct,
    ROUND(
        AVG(attendance_rate) * 100,
        2
    ) AS average_attendance_pct,
    ROUND(
        AVG(score_improvement),
        2
    ) AS average_score_improvement
FROM learner_enrollments
GROUP BY acquisition_channel
ORDER BY completion_rate_pct DESC;