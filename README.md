Project: Patient Win-Back & Lifecycle Automation

1. Business Strategy
This project addresses patient churn by identifying users inactive for 90+ days and delivering personalized re-engagement offers.

2. Technical Components
I have documented the technical build in separate modules for clarity:
View SQL Logic(./sql/winback_logic.sql)Segmentation Logic
Detailed script using LEFT JOIN on SFMC System Data Views to isolate lapsed subscribers.
View HTML Email Template
Responsive, table-based email design featuring AMPscript for dynamic treatment offers.

3. Journey Builder Architecture (The Process)
The automation follows a 4-stage lifecycle:
Entry: SQL Query refreshes the target Data Extension daily.
Split: Decision splits route patients by Preferred_Treatment_Type.
Wait: 3-day hold to prevent over-saturation.
Exit: Engagement splits remove patients from the journey once they click a "Book Now" link.

5. Quality Assurance (QA) Protocols
To ensure 100% deployment accuracy, I implemented:
Data Count Validation: Scripted checks to flag if the audience size exceeds 10% variance.
Cross-Client Rendering: Verified layouts via Litmus for Outlook and Mobile.
Subject Line A/B Testing: Deployed 10/10/80 tests to optimize Open Rates.
