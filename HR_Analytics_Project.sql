CREATE DATABASE HR_Analytics;

USE HR_Analytics;

BULK INSERT HR_Staging
FROM 'C:\Users\Hp\Downloads\HR Data.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
CODEPAGE = '65001',
TABLOCK
);
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;

CREATE TABLE HR_Data (
Attrition VARCHAR(10),
Business_Travel VARCHAR(50),
Age_Band VARCHAR(20),
Department VARCHAR(50),
Education_Field VARCHAR(50),
Employee_Number INT,
Gender VARCHAR(10),
Job_Role VARCHAR(50),
Marital_Status VARCHAR(20),
Over_Time VARCHAR(10),
Age INT,
Daily_Rate INT,
Distance_From_Home INT,
Education VARCHAR(100),
Environment_Satisfaction INT,
Hourly_Rate INT,
Job_Involvement INT,
Job_Level INT,
Job_Satisfaction INT,
Monthly_Income INT,
Monthly_Rate INT,
Num_Companies_Worked INT,
Percent_Salary_Hike INT,
Performance_Rating INT,
Relationship_Satisfaction INT,
Stock_Option_Level INT,
Total_Working_Years INT,
Work_Life_Balance INT,
Years_At_Company INT,
Years_In_Current_Role INT,
Years_Since_Last_Promotion INT,
Years_With_Curr_Manager INT
);

IF OBJECT_ID('HR_Data', 'U') IS NOT NULL
DROP TABLE HR_Data;

IF OBJECT_ID('HR_Staging', 'U') IS NOT NULL
DROP TABLE HR_Staging;

CREATE TABLE HR_Staging (
Attrition VARCHAR(50),
Business_Travel VARCHAR(50),
Age_Band VARCHAR(50),
Attrition_Label VARCHAR(50),
Department VARCHAR(50),
Education_Field VARCHAR(50),
Emp_No VARCHAR(50),
Employee_Number VARCHAR(50),
Gender VARCHAR(20),
Job_Role VARCHAR(100),
Marital_Status VARCHAR(50),
Over_Time VARCHAR(10),
Over18 VARCHAR(10),
Training_Times_Last_Year VARCHAR(10),
Col15 VARCHAR(10),
Col16 VARCHAR(10),
Age VARCHAR(10),
Current_Employee VARCHAR(10),
Daily_Rate VARCHAR(20),
Distance_From_Home VARCHAR(20),
Education VARCHAR(100),
Employee_Count VARCHAR(10),
Environment_Satisfaction VARCHAR(10),
Hourly_Rate VARCHAR(10),
Job_Involvement VARCHAR(10),
Job_Level VARCHAR(10),
Job_Satisfaction VARCHAR(10),
Monthly_Income VARCHAR(20),
Monthly_Rate VARCHAR(20),
Num_Companies_Worked VARCHAR(10),
Percent_Salary_Hike VARCHAR(10),
Performance_Rating VARCHAR(10),
Relationship_Satisfaction VARCHAR(10),
Standard_Hours VARCHAR(10),
Stock_Option_Level VARCHAR(10),
Total_Working_Years VARCHAR(10),
Work_Life_Balance VARCHAR(10),
Years_At_Company VARCHAR(10),
Years_In_Current_Role VARCHAR(10),
Years_Since_Last_Promotion VARCHAR(10),
Years_With_Curr_Manager VARCHAR(10)
);

BULK INSERT HR_Staging
FROM 'C:\Users\Hp\Downloads\HR Data.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
CODEPAGE = '65001',
TABLOCK
);

CREATE TABLE HR_Data (
Attrition VARCHAR(10),
Business_Travel VARCHAR(50),
Age_Band VARCHAR(20),
Department VARCHAR(50),
Education_Field VARCHAR(50),
Employee_Number INT,
Gender VARCHAR(10),
Job_Role VARCHAR(50),
Marital_Status VARCHAR(20),
Over_Time VARCHAR(10),
Age INT,
Daily_Rate INT,
Distance_From_Home INT,
Education VARCHAR(100),
Environment_Satisfaction INT,
Hourly_Rate INT,
Job_Involvement INT,
Job_Level INT,
Job_Satisfaction INT,
Monthly_Income INT,
Monthly_Rate INT,
Num_Companies_Worked INT,
Percent_Salary_Hike INT,
Performance_Rating INT,
Relationship_Satisfaction INT,
Stock_Option_Level INT,
Total_Working_Years INT,
Work_Life_Balance INT,
Years_At_Company INT,
Years_In_Current_Role INT,
Years_Since_Last_Promotion INT,
Years_With_Curr_Manager INT
);

INSERT INTO HR_Data
SELECT
Attrition,
Business_Travel,
Age_Band,
Department,
Education_Field,
TRY_CAST(Employee_Number AS INT),
Gender,
Job_Role,
Marital_Status,
Over_Time,
TRY_CAST(Age AS INT),
TRY_CAST(Daily_Rate AS INT),
TRY_CAST(Distance_From_Home AS INT),
Education,
TRY_CAST(Environment_Satisfaction AS INT),
TRY_CAST(Hourly_Rate AS INT),
TRY_CAST(Job_Involvement AS INT),
TRY_CAST(Job_Level AS INT),
TRY_CAST(Job_Satisfaction AS INT),
TRY_CAST(Monthly_Income AS INT),
TRY_CAST(Monthly_Rate AS INT),
TRY_CAST(Num_Companies_Worked AS INT),
TRY_CAST(Percent_Salary_Hike AS INT),
TRY_CAST(Performance_Rating AS INT),
TRY_CAST(Relationship_Satisfaction AS INT),
TRY_CAST(Stock_Option_Level AS INT),
TRY_CAST(Total_Working_Years AS INT),
TRY_CAST(Work_Life_Balance AS INT),
TRY_CAST(Years_At_Company AS INT),
TRY_CAST(Years_In_Current_Role AS INT),
TRY_CAST(Years_Since_Last_Promotion AS INT),
TRY_CAST(Years_With_Curr_Manager AS INT)
FROM HR_Staging;

SELECT COUNT(*) AS Total_Employees
FROM HR_Data;

SELECT TOP 10 *
FROM HR_Data;

-- Overall Attrition Rate

SELECT 
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate_Percentage
FROM HR_Data;

--Attrition Rate By Age Band

SELECT 
Age_Band,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Age_Band
ORDER BY Attrition_Rate DESC;

--Attrition Rate By Dept

SELECT 
Department,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Department
ORDER BY Attrition_Rate DESC;

--Overtime VS Attrition

SELECT 
Over_Time,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Over_Time;

--Gender Distribution

SELECT 
Gender,
COUNT(*) AS Total_Employees,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM HR_Data),2) AS Percentage
FROM HR_Data
GROUP BY Gender;

--Attrition By Education Field

SELECT 
Education_Field,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Education_Field
ORDER BY Attrition_Rate DESC;

--Attrition By Education Level

SELECT 
Education,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Education
ORDER BY Attrition_Rate DESC;

-- Performance Rating VS Attrition

SELECT 
Performance_Rating,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate
FROM HR_Data
GROUP BY Performance_Rating
ORDER BY Performance_Rating;

--Enviroment Satisfaction VS Attrition

SELECT 
Environment_Satisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM HR_Data
GROUP BY Environment_Satisfaction
ORDER BY Environment_Satisfaction;

-- Job Satisfaction VS Attrition

SELECT 
Job_Satisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM HR_Data
GROUP BY Job_Satisfaction
ORDER BY Job_Satisfaction;

-- Relationship Satisfaction VS Attrition

SELECT 
Relationship_Satisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM HR_Data
GROUP BY Relationship_Satisfaction
ORDER BY Relationship_Satisfaction;

--Work Life Balance vs Avg tenure of Emp in Company

SELECT 
Work_Life_Balance,
AVG(Years_At_Company) AS Avg_Tenure,
COUNT(*) AS Employees
FROM HR_Data
GROUP BY Work_Life_Balance
ORDER BY Work_Life_Balance;

--Total working Years VS Attrition

SELECT 
Total_Working_Years,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM HR_Data
GROUP BY Total_Working_Years
ORDER BY Total_Working_Years;

-- Years Since Last promotion Vs Tenure

SELECT 
Years_Since_Last_Promotion,
AVG(Years_At_Company) AS Avg_Tenure,
COUNT(*) AS Employees
FROM HR_Data
GROUP BY Years_Since_Last_Promotion
ORDER BY Years_Since_Last_Promotion;

--Years In Current Role Vs Attrition

SELECT 
Years_In_Current_Role,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM HR_Data
GROUP BY Years_In_Current_Role
ORDER BY Years_In_Current_Role;

--EducationLevel vs Attrition

SELECT 
Education,
AVG(Performance_Rating) AS Avg_Performance,
AVG(Job_Satisfaction) AS Avg_Job_Satisfaction
FROM HR_Data
GROUP BY Education
ORDER BY Avg_Performance DESC;

--Education vs Number of Company working

SELECT 
Education,
AVG(Num_Companies_Worked) AS Avg_Companies_Worked,
COUNT(*) AS Employees
FROM HR_Data
GROUP BY Education
ORDER BY Avg_Companies_Worked DESC;

SELECT
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate,
AVG(Monthly_Income) AS Avg_Salary,
AVG(Years_At_Company) AS Avg_Tenure
FROM HR_Data;



SELECT DISTINCT salary
FROM Emp
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

SELECT MAX