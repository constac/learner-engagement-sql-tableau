# Learner Engagement Analytics — Business Story

## Business Objective

The objective of this analysis is to understand learner engagement and completion performance across programs and learner segments, and identify areas where targeted intervention could improve outcomes.

## Dataset

The analysis uses 2,583 learner enrollment records representing 760 unique learners.

The dataset contains information relating to:

- Learner characteristics
- Program participation
- Delivery mode
- Attendance
- Completion
- Pre- and post-learning scores
- Digital confidence
- Employment status
- Learner risk
- Support activity
- Satisfaction
- Acquisition channel

## Data Quality

The dataset was validated using PostgreSQL before analysis.

Key checks included:

- Record counts
- Unique learner counts
- Duplicate enrollment IDs
- Missing values
- Score consistency
- Attendance validity
- Completion consistency
- Date validity
- Support metric validity

Results showed:

- 2,583 valid enrollment records
- 760 unique learners
- No duplicate enrollment IDs
- No missing values across the validated analytical fields
- No invalid attendance records
- No inconsistent completion records

## Core KPIs

| KPI | Result |
|---|---:|
| Total enrollments | 2,583 |
| Unique learners | 760 |
| Completion rate | 82.19% |
| Average attendance | 78.98% |
| Average pre-score | 54.19 |
| Average post-score | 76.81 |
| Average score improvement | +22.62 |
| Average satisfaction | 4.02 / 5 |
| Average recommendation score | 7.47 / 10 |
| Total support tickets | 1,008 |

## Key Finding 1 — Risk is strongly associated with completion

Completion varies substantially across learner risk bands:

- On track: 91.13%
- Watch: 66.67%
- High risk: 44.97%

This represents a 46.16 percentage-point completion gap between on-track and high-risk learners.

High-risk learners also have substantially lower attendance and learning improvement.

## Key Finding 2 — Digital confidence is associated with learner outcomes

Completion increases with digital confidence:

- High: 87.42%
- Medium: 83.37%
- Low: 73.61%

Low digital-confidence learners also have lower average attendance and lower score improvement.

## Key Finding 3 — Priority intervention segment

The combination of low digital confidence and high-risk status represents the strongest intervention opportunity.

This segment has:

- 71 enrollments
- 35.21% completion
- 32.78% attendance
- +12.97 average score improvement

This suggests that targeted digital-support and engagement interventions could be valuable for this group.

## Key Finding 4 — Program performance varies

Business Analytics Essentials has the highest completion rate at 85.25%.

Financial Literacy has the lowest completion rate at 79.73%.

This indicates an opportunity to investigate whether lower-performing programs require additional learner-support or engagement interventions.

## Key Finding 5 — Delivery mode shows an engagement difference

Completion rates are:

- In-person: 86.57%
- Hybrid: 82.33%
- Virtual: 81.00%

Virtual learners also have lower average attendance than in-person learners.

Delivery mode therefore provides a secondary opportunity for investigating engagement differences.

## Business Recommendations

### 1. Prioritize high-risk learners

Introduce early-warning interventions for learners classified as high risk, focusing on attendance and engagement.

### 2. Provide targeted digital support

Develop additional onboarding, digital-skills guidance and learner support for low digital-confidence learners.

### 3. Investigate lower-performing programs

Review Financial Literacy and other below-average programs to identify potential differences in learner engagement, support demand or delivery.

### 4. Strengthen virtual learner engagement

Explore additional check-ins, reminders and support mechanisms for virtual learners with declining attendance.

### 5. Use SQL-driven segmentation for intervention

Use risk, digital confidence and engagement indicators to move from broad learner support to targeted intervention.

## Analytical Approach

The project uses PostgreSQL and SQL for:

- Data-quality validation
- KPI calculation
- Program analysis
- Learner segmentation
- Risk analysis
- CTE-based analysis
- Window functions
- Business prioritisation

Tableau is used as the visualization and communication layer.

## Portfolio Positioning

The project demonstrates an end-to-end analytics workflow:

Raw learner data  
→ PostgreSQL  
→ Data validation  
→ SQL analysis  
→ Segmentation  
→ Business insights  
→ Tableau visualization  
→ Recommendations