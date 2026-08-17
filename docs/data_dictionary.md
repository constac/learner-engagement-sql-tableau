# Learner Engagement Analytics — Data Dictionary

## Dataset Overview

| Field | Description | Analytical Use |
|---|---|---|
| enrollment_id | Unique identifier for an enrollment | Record-level identification |
| participant_id | Learner identifier | Unique learner analysis |
| program_name | Name of the learning program | Program performance |
| start_date | Enrollment/program start date | Time and cohort analysis |
| end_date | Enrollment/program end date | Duration analysis |
| attendance_rate | Proportion of sessions attended | Engagement analysis |
| completion_status | Learner completion outcome | Completion analysis |
| completed_flag | Binary completion indicator | KPI and segmentation analysis |
| pre_score | Score before learning intervention | Baseline performance |
| post_score | Score after learning intervention | Outcome measurement |
| score_improvement | Difference between post- and pre-score | Learning impact |
| digital_confidence | Learner digital-confidence category | Learner segmentation |
| delivery_mode | Learning delivery format | Delivery analysis |
| age_band | Learner age category | Demographic segmentation |
| employment_status | Learner employment category | Learner segmentation |
| risk_band | Learner engagement/risk classification | Intervention prioritisation |
| acquisition_channel | Learner acquisition source | Channel analysis |
| satisfaction_score | Learner satisfaction rating | Experience analysis |
| recommendation_score | Learner recommendation score | Learner advocacy |
| ticket_count | Number of support tickets | Support demand |
| avg_resolution_hours | Average support resolution time | Support operations |
| support_sla_rate | Proportion of support cases meeting SLA | Support performance |

## Derived Fields

### completed_flag

A binary indicator derived from completion status:

- 1 = Completed
- 0 = Not completed

### score_improvement

Calculated as:

`post_score - pre_score`

### age_band

Learners are grouped into age categories for segmentation analysis.

### risk_band

Learners are classified into:

- On track
- Watch
- High risk

The risk classification is used to identify learners requiring different levels of intervention.

## Data Quality Checks

The dataset was validated using PostgreSQL for:

- Missing values
- Duplicate enrollment IDs
- Invalid attendance rates
- Score inconsistencies
- Completion inconsistencies
- Invalid dates
- Invalid support metrics

The validated dataset contained 2,583 enrollment records and 760 unique learners.

## Important Analytical Notes

Percentages such as attendance rate and support SLA rate are stored as decimal proportions between 0 and 1 and are converted to percentages for reporting.

Completion rate is calculated from the completed enrollment indicator rather than treating individual status categories as independent metrics.

The dataset represents enrollment-level records. Therefore, enrollment counts and unique learner counts are intentionally distinguished throughout the analysis.