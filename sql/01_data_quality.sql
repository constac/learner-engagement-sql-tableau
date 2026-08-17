-- ============================================================
-- LEARNER ENGAGEMENT ANALYTICS
-- 01 - DATA QUALITY ANALYSIS
-- Database: learner_analytics
-- Table: learner_enrollments
-- ============================================================


-- 1. Total number of records
SELECT COUNT(*) AS total_records
FROM learner_enrollments;


-- 2. Number of unique learners
SELECT COUNT(DISTINCT participant_id) AS unique_learners
FROM learner_enrollments;


-- 3. Check for duplicate enrollment IDs
SELECT
    COUNT(*) AS duplicate_enrollment_ids
FROM (
    SELECT enrollment_id
    FROM learner_enrollments
    GROUP BY enrollment_id
    HAVING COUNT(*) > 1
) AS duplicates;


-- 4. Check missing values in key analytical fields
SELECT
    COUNT(*) FILTER (WHERE enrollment_id IS NULL) AS missing_enrollment_id,
    COUNT(*) FILTER (WHERE participant_id IS NULL) AS missing_participant_id,
    COUNT(*) FILTER (WHERE program_name IS NULL) AS missing_program_name,
    COUNT(*) FILTER (WHERE start_date IS NULL) AS missing_start_date,
    COUNT(*) FILTER (WHERE end_date IS NULL) AS missing_end_date,
    COUNT(*) FILTER (WHERE attendance_rate IS NULL) AS missing_attendance_rate,
    COUNT(*) FILTER (WHERE completion_status IS NULL) AS missing_completion_status,
    COUNT(*) FILTER (WHERE pre_score IS NULL) AS missing_pre_score,
    COUNT(*) FILTER (WHERE post_score IS NULL) AS missing_post_score,
    COUNT(*) FILTER (WHERE score_improvement IS NULL) AS missing_score_improvement
FROM learner_enrollments;


-- 5. Attendance-rate range and average
SELECT
    MIN(attendance_rate) AS minimum_attendance,
    MAX(attendance_rate) AS maximum_attendance,
    ROUND(AVG(attendance_rate), 3) AS average_attendance
FROM learner_enrollments;


-- 6. Check for invalid attendance rates
SELECT COUNT(*) AS invalid_attendance_records
FROM learner_enrollments
WHERE attendance_rate < 0
   OR attendance_rate > 1;


-- 7. Check score ranges
SELECT
    MIN(pre_score) AS minimum_pre_score,
    MAX(pre_score) AS maximum_pre_score,
    MIN(post_score) AS minimum_post_score,
    MAX(post_score) AS maximum_post_score,
    MIN(score_improvement) AS minimum_improvement,
    MAX(score_improvement) AS maximum_improvement
FROM learner_enrollments;


-- 8. Check whether score improvement is calculated correctly
SELECT COUNT(*) AS inconsistent_score_records
FROM learner_enrollments
WHERE ABS((post_score - pre_score) - score_improvement) > 0.1;


-- 9. Check completion-status and completed-flag combinations
SELECT
    completion_status,
    completed_flag,
    COUNT(*) AS records
FROM learner_enrollments
GROUP BY completion_status, completed_flag
ORDER BY completion_status, completed_flag;


-- 10. Check for inconsistent completion flags
SELECT COUNT(*) AS inconsistent_completion_records
FROM learner_enrollments
WHERE
    (completion_status = 'Completed' AND completed_flag <> 1)
    OR
    (completion_status <> 'Completed' AND completed_flag = 1);


-- 11. Check date ranges
SELECT
    MIN(start_date) AS earliest_start_date,
    MAX(start_date) AS latest_start_date,
    MIN(end_date) AS earliest_end_date,
    MAX(end_date) AS latest_end_date
FROM learner_enrollments;


-- 12. Check for invalid dates
SELECT COUNT(*) AS invalid_date_records
FROM learner_enrollments
WHERE end_date < start_date;


-- 13. Check cohort duration
SELECT
    MIN(end_date - start_date) AS minimum_duration_days,
    MAX(end_date - start_date) AS maximum_duration_days,
    ROUND(AVG(end_date - start_date), 1) AS average_duration_days
FROM learner_enrollments;


-- 14. Check support-ticket and SLA values
SELECT
    MIN(ticket_count) AS min_tickets,
    MAX(ticket_count) AS max_tickets,
    ROUND(AVG(ticket_count), 2) AS avg_tickets,
    MIN(avg_resolution_hours) AS min_resolution_hours,
    MAX(avg_resolution_hours) AS max_resolution_hours,
    ROUND(AVG(avg_resolution_hours), 2) AS avg_resolution_hours,
    MIN(support_sla_rate) AS min_sla_rate,
    MAX(support_sla_rate) AS max_sla_rate,
    ROUND(AVG(support_sla_rate), 3) AS avg_sla_rate
FROM learner_enrollments;


-- 15. Check for invalid support values
SELECT COUNT(*) AS invalid_support_records
FROM learner_enrollments
WHERE ticket_count < 0
   OR avg_resolution_hours < 0
   OR support_sla_rate < 0
   OR support_sla_rate > 1;


-- 16. Records with and without support tickets
SELECT
    COUNT(*) FILTER (WHERE ticket_count = 0) AS no_ticket_records,
    COUNT(*) FILTER (WHERE ticket_count > 0) AS records_with_tickets
FROM learner_enrollments;
