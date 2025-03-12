-- This view calculates total employees, attrition count, and attrition rate
CREATE VIEW attrition_summary AS 
SELECT 
    COUNT(employee_id) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(employee_id)) * 100, 2) AS attrition_rate
FROM ibm_hr;

-- This view shows attrition count & rate per department.
CREATE VIEW department_attrition AS
SELECT 
    department,
    COUNT(employee_id) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(employee_id)) * 100, 2) AS attrition_rate
FROM ibm_hr
GROUP BY department
ORDER BY attrition_rate DESC;

-- This view shows attrition trends by job role.
CREATE VIEW job_role_attrition AS
SELECT 
    job_role,
    COUNT(employee_id) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(employee_id)) * 100, 2) AS attrition_rate
FROM ibm_hr
GROUP BY job_role
ORDER BY attrition_rate DESC;

-- This view shows average, min, and max salaries for each job role
CREATE VIEW salary_by_job_role AS
SELECT 
    job_role,
    ROUND(AVG(monthly_income), 2) AS avg_salary,
    MAX(monthly_income) AS max_salary,
    MIN(monthly_income) AS min_salary
FROM ibm_hr
GROUP BY job_role
ORDER BY avg_salary DESC;

-- This view provides average job satisfaction, relationship satisfaction, and work-life balance scores per department
CREATE VIEW employee_satisfaction AS
SELECT 
    department,
    ROUND(AVG(job_satisfaction), 2) AS avg_job_satisfaction,
    ROUND(AVG(relationship_satisfaction), 2) AS avg_relationship_satisfaction,
    ROUND(AVG(work_life_balance), 2) AS avg_work_life_balance
FROM ibm_hr
GROUP BY department
ORDER BY avg_job_satisfaction DESC;
