# Learner Engagement Analytics

## PostgreSQL SQL Analysis + Tableau Dashboard

An end-to-end data analytics project analyzing learner engagement, completion, attendance, learning outcomes and support activity across an edtech training dataset.

The project demonstrates a practical analyst workflow:

**Raw Data → PostgreSQL → Data Quality → SQL Analysis → Segmentation → Business Insights → Tableau → Recommendations**

---

## Business Problem

Learning and training teams need to understand why some learners successfully complete programs while others disengage.

This analysis investigates:

- Which programs perform best?
- What learner characteristics are associated with completion?
- Which learners require intervention?
- Does digital confidence relate to learner outcomes?
- Does delivery mode affect engagement?
- Where should learner-support resources be prioritised?

---

## Dataset

The dataset contains:

- **2,583 enrollment records**
- **760 unique learners**
- Multiple learning programs
- Learner demographic and employment characteristics
- Attendance and completion information
- Pre- and post-learning scores
- Digital confidence
- Delivery mode
- Risk classification
- Support activity
- Satisfaction and recommendation scores

---

## Technology Stack

| Tool | Purpose |
|---|---|
| PostgreSQL | Relational database and analytical SQL |
| SQL | Data validation, KPI analysis and segmentation |
| Tableau | Data visualization and dashboarding |
| Git/GitHub | Version control and portfolio presentation |

---

## Project Structure

```text
learner-engagement-sql-tableau/
│
├── data/
│   └── edtech_learner_analytics.csv
│
├── sql/
│   ├── 01_data_quality.sql
│   ├── 02_core_kpis.sql
│   ├── 03_program_analysis.sql
│   ├── 04_segment_analysis.sql
│   └── 07_business_insights.sql
│
├── docs/
│   ├── business_story.md
│   └── data_dictionary.md
│
├── tableau/
│   ├── dashboard_screenshot.png
│   └── tableau_public_link.md
│
└── README.md