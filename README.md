# HR_Analytics (Attrition)
# PROBLEM STATEMENT	HR MANAGEMENT
An Organization is asking its HR dept to analyze the current company data and present it analysis.
There a few parameters that the HR manager has to check and create a report to showcase in front of the management. 
Consider myself as  that HR manager.

# Sales Performance Analysis
## Business Problem
Employee attrition is costly and disruptive — yet most organisations lack a clear, datadriven
view of who is leaving, why, and when. This project was built to answer those
questions systematically using 1,470 employee records spanning demographics, job roles,
satisfaction scores, and behavioral patterns.
## Tools Used
Excel, SQL, Power BI
## Dataset
Sample HR Attrition dataset containing Attrition Status,	Business Travel,	CF_age band,	CF_attrition label,	Department,	Education Field, Employee Number,	Gender,	Job Role,	Marital Status,	Over Time,	Training Times,  Distance From Home,	Education, Environment Satisfaction,	Job Level,	Job Satisfaction,	Monthly Income,	Salary Hike	Performance Rating,	Relationship Satisfaction,	Work Life Balance,	Years At Company,	Years In Current Role,	Years Since Last Promotion,	Years With Curr Manager

## Key Steps
1. SQL (MSSQL) — Data cleaning, staging, aggregations, window functions
2. Power BI — DAX measures, Power Query (M), interactive dashboards
3. Power Query — Data type handling, custom column transformations

## Key Insights
- Employees who work overtime and travel frequently face the highest attrition in the entire dataset — nearly 3× the
company average. Overtime is the single strongest risk multiplier identified.
- Employees scoring their WLB as 'Poor' (Score 1) show 31.25% attrition — more than double those rating it 'Good'.
WLB scores function as a leading indicator before formal resignation signals appear.
- Sales Representatives face the highest role-level attrition at 39.76%. Lab Technicians (23.94%) and HR employees
(23.08%) also significantly exceed the 16.12% company benchmark.

## Recommendations
- Target the highest-risk employee segments first
- Reduce structural overtime and travel burden
- Embed real-time satisfaction monitoring in HR
- 
## Files Included
- HR Data.csv
- HR MANAGEMENT Projects.ipynb
- HR_Analytics_Project.sql
- HR_Attrition_Project.pdf
